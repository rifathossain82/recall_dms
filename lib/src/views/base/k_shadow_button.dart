import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';

class KShadowButton extends StatelessWidget {
  const KShadowButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 42,
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        decoration: BoxDecoration(
          color: mainColor,
          border: Border.all(
            color: mainColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 0,
              color: kItemShadowColor,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
