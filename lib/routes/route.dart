
import 'package:get/get.dart';
import 'package:recall/src/views/screens/introduction/introduction_screen.dart';
import 'package:recall/src/views/screens/login/login_screen.dart';
import 'package:recall/src/views/screens/splash/splash_screen.dart';

class RouteGenerator {
  static const String splash = '/';
  static const String login = '/login';
  static const String intro = '/intro';

  static final routes=[
    GetPage(name: RouteGenerator.splash, page: ()=> const SplashScreen()),
    GetPage(name: RouteGenerator.login, page: ()=> const LoginScreen()),
    GetPage(name: RouteGenerator.intro, page: ()=> const IntroductionScreen()),
  ];

}