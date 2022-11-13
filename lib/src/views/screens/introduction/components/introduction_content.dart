import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/models/introduction_screen_model.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';

class IntroductionContent extends StatelessWidget {
  const IntroductionContent({
    Key? key,
    required this.introData,
  }) : super(key: key);

  final IntroductionScreenModel introData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImage(),
        addVerticalSpace(5),
        _buildTitle(),
        addVerticalSpace(10),
        _buildDescription(context)],
    );
  }

  Widget _buildImage() {
    return Image.asset(
      introData.image,
    );
  }

  Widget _buildTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: introData.titleFirstPart,
            style: h1.copyWith(color: kBlackLight, fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: introData.titleMiddlePart,
            style: h1.copyWith(color: mainColor, fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: introData.titleLastPart,
            style: h1.copyWith(color: kBlackLight, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.7,
      child: Text(
        introData.description,
        textAlign: TextAlign.center,
        style: GoogleFonts.overpass(
          textStyle: h3.copyWith(fontWeight: FontWeight.w300, color: kGreyLight)
        ),
      ),
    );
  }
}
