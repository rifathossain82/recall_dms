import 'package:get/get.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/models/user_data.dart';
import 'package:recall/src/network/api.dart';
import 'package:recall/src/network/network_utils.dart';
import 'package:recall/src/services/local_storage.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/views/base/helper.dart';

class AuthController extends GetxController {
  var passwordVisibility = true.obs;
  var isLoading = false.obs;
  Rx<UserData> user = UserData().obs;

  hidePassword() => passwordVisibility.value = true;

  showPassword() => passwordVisibility.value = false;

  Future login({
    required String emailOrPhone,
    required String password,
  }) async {
    try {
      isLoading(true);

      var map = <String, dynamic>{};
      map['email_or_phone'] = emailOrPhone;
      map['password'] = password;

      dynamic responseBody = await Network.handleResponse(
        await Network.postRequest(
          api: Api.login,
          body: map,
        ),
      );

      if (responseBody != null) {
        user.value = UserData.fromJson(responseBody['user']);
        LocalStorage.saveData(key: LocalStorageKey.token, data: responseBody['token']);
        KSnackBar(message: 'Logged in successfully!', bgColor: successColor);
        Get.toNamed(RouteGenerator.dashboard);
      } else {
        KSnackBar(message: 'Logged in Failed!', bgColor: failedColor);
      }
    } catch (e) {
      KSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }
}
