import 'package:get/get.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/models/user_data.dart';
import 'package:recall/src/network/api.dart';
import 'package:recall/src/network/network_utils.dart';
import 'package:recall/src/services/local_storage.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/views/base/helper.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  Rx<UserData> user = UserData().obs;

  /// for login screen
  var passwordVisibility = true.obs;

  /// for change password screen
  var oldPasswordVisibility = true.obs;
  var newPasswordVisibility = true.obs;
  var confirmPasswordVisibility = true.obs;

  /// for login screen
  changePasswordVisibility() =>
      passwordVisibility.value = !passwordVisibility.value;

  /// for change password screen
  changeOldPasswordVisibility() =>
      oldPasswordVisibility.value = !oldPasswordVisibility.value;

  changeNewPasswordVisibility() =>
      newPasswordVisibility.value = !newPasswordVisibility.value;

  changeConfirmPasswordVisibility() =>
      confirmPasswordVisibility.value = !confirmPasswordVisibility.value;

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
        LocalStorage.saveData(key: LocalStorageKey.token, data: responseBody['token'],);
        kSnackBar(message: 'Logged in successfully!', bgColor: successColor);
        await getUserData();
        Get.toNamed(RouteGenerator.dashboard);
      } else {
        throw 'Logged in Failed!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future logout() async {
    try {
      isLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.postRequest(
          api: Api.logout,
        ),
      );

      if (responseBody != null) {
        LocalStorage.removeData(key: LocalStorageKey.token);
        kSnackBar(message: responseBody['message'], bgColor: successColor);
        Get.toNamed(RouteGenerator.login);
      } else {
        kSnackBar(message: 'Logout Failed!', bgColor: failedColor);
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isLoading(true);

      var map = <String, dynamic>{};
      map['old_password'] = oldPassword;
      map['password'] = newPassword;
      map['password_confirmation'] = confirmPassword;

      dynamic responseBody = await Network.handleResponse(
        await Network.postRequest(
          api: Api.changePassword,
          body: map,
        ),
      );

      if (responseBody != null) {
        LocalStorage.removeData(key: LocalStorageKey.token);
        kSnackBar(
            message: 'Password updated successfully.', bgColor: successColor);
        Get.toNamed(RouteGenerator.login);
      } else {
        kSnackBar(message: 'Change Password Failed!', bgColor: failedColor);
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

  Future getUserData() async {
    try {
      isLoading(true);

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(api: Api.getUser),
      );

      if (responseBody != null) {
        user.value = UserData.fromJson(responseBody);
      } else {
        throw 'Failed To Load User!';
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }
}
