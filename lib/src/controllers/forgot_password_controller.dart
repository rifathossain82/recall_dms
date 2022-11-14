import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{
  var tabBarIndex = 0.obs;

  changeIndex(int index) => tabBarIndex.value = index;
}