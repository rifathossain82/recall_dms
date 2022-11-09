import 'package:get/get.dart';

class LoginController extends GetxController{
  var passwordVisibility = false.obs;

  hidePassword() => passwordVisibility.value = true;

  showPassword() => passwordVisibility.value = false;
}