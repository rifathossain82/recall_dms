import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/controllers/auth_controller.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_button.dart';
import 'package:recall/src/views/base/k_logo.dart';
import 'package:recall/src/views/base/k_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                /// logo and loginWithPassword text
                const KLogo(),
                Text(
                  'Change Password',
                  style: GoogleFonts.roboto(
                    textStyle: h4.copyWith(
                      fontWeight: FontWeight.w300,
                      color: kBlackLight,
                    ),
                  ),
                ),

                /// old textField
                addVerticalSpace(Get.height * 0.05),
                _buildOldPasswordTextFiled(),

                /// new password textField
                addVerticalSpace(Get.height * 0.03),
                _buildNewPasswordTextFiled(),

                /// confirm password textField
                addVerticalSpace(Get.height * 0.03),
                _buildConfirmPasswordTextFiled(),

                /// change password button
                addVerticalSpace(Get.height * 0.05),
                _buildChangePasswordButton(context),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildOldPasswordTextFiled() => KTextFiled(
        controller: oldPassword,
        labelText: 'Old Password',
        inputAction: TextInputAction.next,
        obscureValue: authController.oldPasswordVisibility.value,
        suffix: GestureDetector(
          onTap: authController.changeOldPasswordVisibility,
          child: Icon(
            authController.oldPasswordVisibility.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: kBlackLight,
          ),
        ),
      );

  Widget _buildNewPasswordTextFiled() => KTextFiled(
        controller: newPassword,
        labelText: 'New Password',
        inputAction: TextInputAction.next,
        obscureValue: authController.newPasswordVisibility.value,
        suffix: GestureDetector(
          onTap: authController.changeNewPasswordVisibility,
          child: Icon(
            authController.newPasswordVisibility.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: kBlackLight,
          ),
        ),
      );

  Widget _buildConfirmPasswordTextFiled() => KTextFiled(
        controller: confirmPassword,
        labelText: 'Confirm Password',
        inputAction: TextInputAction.done,
        obscureValue: authController.confirmPasswordVisibility.value,
        suffix: GestureDetector(
          onTap: authController.changeConfirmPasswordVisibility,
          child: Icon(
            authController.confirmPasswordVisibility.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: kBlackLight,
          ),
        ),
      );

  Widget _buildChangePasswordButton(BuildContext context) => KButton(
        onPressed: () => _changePassword(context),
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
                'Change Password',
                style: GoogleFonts.roboto(
                  textStyle: h3.copyWith(
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      );


  void _changePassword(BuildContext context) async{
    if (oldPassword.text.isEmpty) {
      kSnackBar(
        message: 'Please enter your old password!',
        bgColor: failedColor,
      );
    } else if (newPassword.text.isEmpty) {
      kSnackBar(
        message: 'Please enter a new password!',
        bgColor: failedColor,
      );
    } else if (confirmPassword.text.isEmpty) {
      kSnackBar(
        message: 'Please enter confirm password!',
        bgColor: failedColor,
      );
    } else if (newPassword.text != confirmPassword.text) {
      kSnackBar(
        message: 'The password confirmation does not match!',
        bgColor: failedColor,
      );
    } else {
      bool? result = await kConfirmDialog(
        context: context,
        title: 'Are you sure you want to change password?',
        negativeActionText: 'Cancel',
        positiveActionText: 'Change',
      );

      if(result!){
        authController.changePassword(
          oldPassword: oldPassword.text.trim(),
          newPassword: newPassword.text.trim(),
          confirmPassword: confirmPassword.text.trim(),
        );
      }
    }
  }
}
