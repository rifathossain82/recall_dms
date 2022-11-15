import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/models/introduction_screen_model.dart';
import 'package:recall/src/services/local_storage.dart';
import 'package:recall/src/utils/app_constants.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/screens/introduction/components/introduction_content.dart';
import 'package:recall/src/views/screens/introduction/components/skip_button.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int currentPage = 0;
  List<IntroductionScreenModel> introDataList = AppConstants.introData;
  PageController controller = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        actions: const [
          SkipButton(),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: buildIntroContent(),
          ),
          Expanded(
            flex: 2,
            child: buildIntroController(),
          ),
        ],
      ),
    );
  }

  Widget buildIntroContent() {
    return PageView.builder(
      controller: controller,
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      itemCount: introDataList.length,
      itemBuilder: (context, index) => IntroductionContent(
        introData: introDataList[currentPage],
      ),
    );
  }

  Widget buildIntroController() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.07,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /// back button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  if (currentPage != 0) {
                    controller.previousPage(
                      duration: const Duration(microseconds: 300),
                      curve: Curves.decelerate,
                    );
                  }
                },
                child: currentPage == 0
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Text(
                          'Back',
                          style: h3.copyWith(color: kGreyLight),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ],
          ),

          /// indicators
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    introDataList.length,
                    (index) => buildIndicator(index: index),
                  ),
                ),
              ],
            ),
          ),

          /// next button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  if (currentPage != introDataList.length - 1) {
                    controller.nextPage(
                      duration: const Duration(microseconds: 300),
                      curve: Curves.decelerate,
                    );
                  }
                  else {
                    LocalStorage.saveData(
                      key: LocalStorageKey.intro,
                      data: true,
                    );
                    Get.offAllNamed(RouteGenerator.login);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: currentPage == introDataList.length - 1
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Get Start',
                              style: h3.copyWith(
                                  color: mainColor,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: mainColor,
                            ),
                          ],
                        )
                      : Text(
                          'Next',
                          style: h3.copyWith(
                            color: mainColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildIndicator({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: Dimensions.marginSizeSmall),
      height: Dimensions.radiusSmall,
      width: Dimensions.radiusSmall,
      decoration: BoxDecoration(
        color: currentPage == index ? mainColor : kGreyMedium,
        shape: BoxShape.circle,
      ),
    );
  }
}
