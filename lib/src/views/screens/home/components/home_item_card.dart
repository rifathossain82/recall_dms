import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';

class HomeItemCard extends StatelessWidget {
  const HomeItemCard({
    Key? key,
    required this.assetImagePath,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String assetImagePath;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = min(Get.height, Get.width);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size * 0.43,
        height: size * 0.43,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: kWhite,
          border: Border.all(
            color: mainColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: kItemShadowColor,
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              assetImagePath,
              height: size * 0.23,
              width: size * 0.23,
              fit: BoxFit.cover,
            ),
            addVerticalSpace(Dimensions.paddingSizeSmall),
            Text(
              title,
              style: h4.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
