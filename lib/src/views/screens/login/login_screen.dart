import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/controllers/auth_controller.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_button.dart';
import 'package:recall/src/views/base/k_logo.dart';
import 'package:recall/src/views/base/k_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                children: [
                  /// logo and loginWithPassword text
                  addVerticalSpace(Get.height * 0.05),
                  const KLogo(),
                  Text(
                    'Login with password',
                    style: GoogleFonts.roboto(
                      textStyle: h4.copyWith(
                        fontWeight: FontWeight.w300,
                        color: kBlackLight,
                      ),
                    ),
                  ),

                  /// email/phone textField
                  addVerticalSpace(Get.height * 0.05),
                  _buildEmailOrPhoneTextFiled(),

                  /// password textField
                  addVerticalSpace(Get.height * 0.03),
                  _buildPasswordTextFiled(),

                  /// login button
                  addVerticalSpace(Get.height * 0.05),
                  _buildLoginButton(context),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailOrPhoneTextFiled() => KTextFiled(
        controller: emailOrPhoneController,
        labelText: 'Email / Phone No',
        inputAction: TextInputAction.next,
      );

  Widget _buildPasswordTextFiled() => KTextFiled(
        controller: passwordController,
        labelText: 'Password',
        inputAction: TextInputAction.done,
        obscureValue: authController.passwordVisibility.value,
        suffix: GestureDetector(
          onTap: authController.changePasswordVisibility,
          child: Icon(
            authController.passwordVisibility.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: kBlackLight,
          ),
        ),
      );

  Widget _buildLoginButton(BuildContext context) => KButton(
        onPressed: () => _loginMethod(context),
        child: authController.isLoading.value
            ? Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: kWhite,
                ),
              )
            : Text(
                'Login',
                style: GoogleFonts.roboto(
                  textStyle: h3.copyWith(
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      );

  void _loginMethod(BuildContext context) {
    context.unFocusKeyboard();
    if (emailOrPhoneController.text.isEmpty) {
      kSnackBar(
        message: 'Please enter your phone or email!',
        bgColor: failedColor,
      );
    } else if (passwordController.text.isEmpty) {
      kSnackBar(
        message: 'Please enter your password!',
        bgColor: failedColor,
      );
    } else {
      authController.login(
        emailOrPhone: emailOrPhoneController.text,
        password: passwordController.text,
      );
    }
  }
}
