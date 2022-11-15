import 'package:get/get.dart';

class TMTLController extends GetxController {
  var tabBarIndex = 0.obs;
  Rx<DateTime> selectedDate = DateTime
      .now()
      .obs;
  var isClickSearch = false.obs;

  changeIndex(int index) => tabBarIndex.value = index;

  changeDateTime(DateTime dateTime) => selectedDate.value = dateTime;

  void changeSearchStatus() => isClickSearch.value = !isClickSearch.value;

}