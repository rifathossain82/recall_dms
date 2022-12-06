import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/controllers/auth_controller.dart';
import 'package:recall/src/services/local_storage.dart';
import 'package:recall/src/utils/app_constants.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  setSplashDuration() async {
    return Timer(
      const Duration(seconds: 3),
      () => pageNavigation(),
    );
  }

  void pageNavigation() async {
    if (LocalStorage.getData(key: LocalStorageKey.intro) == null) {
      Get.offAllNamed(RouteGenerator.intro);
    } else {
      if (LocalStorage.getData(key: LocalStorageKey.token) == null) {
        Get.offAllNamed(RouteGenerator.login);
      } else {
        final AuthController authController = Get.find<AuthController>();
        await authController.getUserData();
        Get.offAllNamed(RouteGenerator.dashboard);
      }
    }
  }

  @override
  void initState() {
    setSplashDuration();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    animation.addListener(() => setState(() {}));
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: Dimensions.paddingSizeExtraLarge,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Powered by ',
                        style: GoogleFonts.roboto(
                          textStyle: h3.copyWith(
                            color: kGrey,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: AppConstants.appName,
                        style: GoogleFonts.roboto(
                          textStyle: h3.copyWith(
                            color: kGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetPath.logo,
                height: animation.value * 150,
                width: animation.value * 150,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
