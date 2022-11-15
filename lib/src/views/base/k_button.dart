import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';

class KButton extends StatelessWidget {
  const KButton({Key? key, required this.onPressed, required this.child, this.borderRadius}) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
      color: mainColor,
      height: 42,
      minWidth: Get.width,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      elevation: 0,
      child: child,
    );
  }
}
