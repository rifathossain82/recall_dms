import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/controllers/login_controller.dart';
import 'package:recall/src/utils/app_constants.dart';
import 'package:recall/src/utils/app_theme.dart';
import 'package:recall/src/views/base/k_scroll_behavior.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      initialRoute: RouteGenerator.splash,
      getPages: RouteGenerator.routes,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
    );
  }
}
