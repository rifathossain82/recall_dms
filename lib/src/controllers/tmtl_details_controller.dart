import 'dart:convert';

import 'package:get/get.dart';
import 'package:recall/src/models/tmtl_data.dart';
import 'package:recall/src/models/tmtl_detail_data.dart';
import 'package:recall/src/network/api.dart';
import 'package:recall/src/network/network_utils.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/views/base/helper.dart';

class TMTLDetailsController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  var isClickSearch = false.obs;

  var isLoading = false.obs;
  var tmtlDetails = TmtlDetailData().obs;

  changeSelectedDateTime(DateTime dateTime) => selectedDate.value = dateTime;
  void changeSearchStatus() => isClickSearch.value = !isClickSearch.value;

  void getTMTLDetails({required int id}) async {
    try {
      isLoading(true);
      tmtlDetails.value = TmtlDetailData();

      final date = selectedDate.value;
      var map = <String, dynamic>{};
      map['id'] = id.toString();
      map['date'] = '${date.month}/${date.day}/${date.year}';

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.getTMTLDetails,
          params: map,
        ),
      );

      if (responseBody != null) {
        tmtlDetails.value = TmtlDetailData.fromJson(responseBody['tmtl']);
      } else {
        kSnackBar(message: 'Failed to load data!', bgColor: failedColor);
      }
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }
}
