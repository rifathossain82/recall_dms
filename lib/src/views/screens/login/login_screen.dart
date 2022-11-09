import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/controllers/login_controller.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_button.dart';
import 'package:recall/src/views/base/k_logo.dart';
import 'package:recall/src/views/base/k_scroll_behavior.dart';
import 'package:recall/src/views/base/k_text_field.dart';
import 'package:recall/src/views/screens/login/components/forgot_password_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late LoginController loginController;

  @override
  void initState() {
    loginController = Get.put(LoginController());
    super.initState();
  }

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: ScrollConfiguration(
            behavior: KScrollBehavior(),
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
      ),
    );
  }

  Widget _buildEmailOrPhoneTextFiled()=> KTextFiled(
    controller: emailOrPhoneController,
    labelText: 'Email / Phone No',
    inputAction: TextInputAction.next,
  );

  Widget _buildPasswordTextFiled(){
    return Obx(() => KTextFiled(
      controller: passwordController,
      labelText: 'Password',
      inputAction: TextInputAction.done,
      obscureValue: loginController.passwordVisibility.value,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: loginController.showPassword,
            child: Icon(
              Icons.visibility_sharp,
              size: 20,
              color: loginController.passwordVisibility.value
                  ? kBlackLight
                  : kGreyDeep1,
            ),
          ),
          addHorizontalSpace(Dimensions.paddingSizeDefault),
          GestureDetector(
            onTap: loginController.hidePassword,
            child: Icon(
              Icons.visibility_off_outlined,
              size: 20,
              color: loginController.passwordVisibility.value
                  ? kGreyDeep1
                  : kBlackLight,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildLoginButton() => KButton(
      onPressed: _loginMethod,
      child: Text(
        'Login',
        style: GoogleFonts.roboto(
            textStyle: h3.copyWith(
          color: kWhite,
          fontWeight: FontWeight.w500,
        )),
      ));

  void _loginMethod() {}


}
