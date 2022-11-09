import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/services/local_storage.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        LocalStorage.saveData(key: LocalStorageKey.intro, data: true);
        Get.offAllNamed(RouteGenerator.login);
      },
      child: Center(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: Text(
            'Skip',
            style: h4.copyWith(color: kGreyLight),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
