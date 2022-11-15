import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/styles.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        RouteGenerator.forgotPassword,
      ),
      child: Text(
        'Forgot your Password?',
        style: GoogleFonts.roboto(
          textStyle: h4.copyWith(
            color: kBlackLight,
          ),
        ),
      ),
    );
  }
}
