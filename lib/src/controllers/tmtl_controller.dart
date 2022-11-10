import 'package:get/get.dart';

class TMTLController extends GetxController{
  var tabBarIndex = 0.obs;

  changeIndex(int index) => tabBarIndex.value = index;
}