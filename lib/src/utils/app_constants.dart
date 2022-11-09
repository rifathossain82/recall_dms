import 'package:recall/src/models/introduction_screen_model.dart';
import 'package:recall/src/utils/asset_path.dart';

class AppConstants {
  static const String appName = 'Recall DMS';
  
  
  static List<IntroductionScreenModel> introData = [
    IntroductionScreenModel(
      image: AssetPath.introImage1,
        titleFirstPart: 'Received ',
        titleMiddlePart: 'Document\n',
        titleLastPart: 'Securely',
      description: 'Lorem ipsum dolor sit amet. Tellus luctus id eu nulla accumsan sed fringilla.'
    ),
    IntroductionScreenModel(
        image: AssetPath.introImage2,
        titleFirstPart: 'Get ',
        titleMiddlePart: 'Delivery ',
        titleLastPart: 'on time \n& fastest delivery.',
        description: 'Lorem ipsum dolor sit amet. Tellus luctus id eu nulla accumsan sed fringilla.'
    ),
    IntroductionScreenModel(
        image: AssetPath.introImage3,
        titleFirstPart: 'Get ',
        titleMiddlePart: 'Delivery ',
        titleLastPart: 'on time \n& fastest delivery.',
        description: 'Lorem ipsum dolor sit amet. Tellus luctus id eu nulla accumsan sed fringilla.'
    ),
  ];


}
