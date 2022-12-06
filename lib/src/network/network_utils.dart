import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/services/local_storage.dart';
import 'package:recall/src/views/base/helper.dart';

class Network {
  static var noInternetMessage = "Please check your connection!";

  static getRequest({required String api, params}) async {
    if(!await hasInternet){
      throw noInternetMessage;
    }

    kPrint("\nYou hit: $api");
    kPrint("Request Params: $params");

    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    Response response = await get(
      Uri.parse(api).replace(queryParameters: params),
      headers: headers,
    );
    return response;
  }

  static postRequest({required String api, body}) async {
    if(!await hasInternet){
      throw noInternetMessage;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${LocalStorage.getData(key: LocalStorageKey.token)}"
    };

    Response response = await post(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static handleResponse(Response response) async {
    try {
      if(!await hasInternet){
        throw noInternetMessage;
      }

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        kPrint('SuccessCode: ${response.statusCode}');
        kPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 401) {
        _logout();
        String msg = "Unauthorized";
        if (response.body.isNotEmpty) {
          msg = json.decode(response.body)['errors'];
        }
        throw msg;
      } else if (response.statusCode == 404) {
        throw 'Page Not Found!';
      } else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        kPrint('ErrorCode: ${response.statusCode}');
        kPrint('ErrorResponse: ${response.body}');

        String msg = "Something went wrong";
        if (response.body.isNotEmpty) {
          msg = json.decode(response.body)['errors'];
        }

        throw msg;
      }
    } on SocketException catch (e) {
      throw noInternetMessage;
    } on FormatException catch (e) {
      throw "Bad response format";
    } catch (e) {
      throw e.toString();
    }
  }

  static void _logout(){
    LocalStorage.removeData(key: LocalStorageKey.token);
    Get.toNamed(RouteGenerator.login);
  }
}
