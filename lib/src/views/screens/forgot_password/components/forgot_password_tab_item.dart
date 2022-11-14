import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';

class ForgotPasswordTabItem extends StatelessWidget {
  const ForgotPasswordTabItem({
    Key? key,
    required this.assetPath,
    required this.itemName,
    required this.isActive,
  }) : super(key: key);

  final String assetPath;
  final String itemName;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            color: isActive ? kBlue : kBlackLight,
          ),
          addHorizontalSpace(Dimensions.paddingSizeSmall),
          Text(
            itemName,
            style: GoogleFonts.roboto(
              textStyle: h4.copyWith(
                color: isActive ? kBlue : kBlackLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
