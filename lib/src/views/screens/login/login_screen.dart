import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/controllers/login_controller.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_button.dart';
import 'package:recall/src/views/base/k_logo.dart';
import 'package:recall/src/views/base/k_text_field.dart';
import 'package:recall/src/views/screens/login/components/forgot_password_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: Column(
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
                _buildLoginButton(),

                /// forgot password button
                addVerticalSpace(Get.height * 0.025),
                const ForgotPasswordButton(),
              ],
            ),
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

  Widget _buildPasswordTextFiled() {
    return Obx(
      () => KTextFiled(
        controller: passwordController,
        labelText: 'Password',
        inputAction: TextInputAction.done,
        obscureValue: loginController.passwordVisibility.value,
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: loginController.showPassword,
              child: SvgPicture.asset(
                AssetPath.visibilityOnIconSvg,
                color: loginController.passwordVisibility.value
                    ? kBlackLight
                    : kGreyDeep1,
              ),
            ),
            addHorizontalSpace(Dimensions.paddingSizeDefault),
            GestureDetector(
              onTap: loginController.hidePassword,
              child: SvgPicture.asset(
                AssetPath.visibilityOffIconSvg,
                color: loginController.passwordVisibility.value
                    ? kGreyDeep1
                    : kBlackLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() => KButton(
        onPressed: _loginMethod,
        child: Text(
          'Login',
          style: GoogleFonts.roboto(
            textStyle: h3.copyWith(
              color: kWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  void _loginMethod() => Get.offAllNamed(RouteGenerator.dashboard);
}
