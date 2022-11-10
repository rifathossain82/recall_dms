import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/styles.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({Key? key, required this.itemName, required this.isActive}) : super(key: key);

  final String itemName;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: Get.width * 0.22,
      decoration: BoxDecoration(
        color: isActive ? kTabItemBgColor : kWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive? mainColor : kGreyLightPro,
          width: 1,
        ),
      ),
      child: Text(
        itemName,
        textAlign: TextAlign.center,
        style: h2.copyWith(
            color: isActive? mainColor : kGreyLightProMax,
        ),
      ),
    );
  }
}
