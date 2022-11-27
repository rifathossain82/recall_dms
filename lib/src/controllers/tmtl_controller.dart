import 'package:get/get.dart';
import 'package:recall/src/models/tmtl_data.dart';
import 'package:recall/src/network/api.dart';
import 'package:recall/src/network/network_utils.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/views/base/helper.dart';

class TMTLController extends GetxController {
  var tabBarIndex = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  var isClickListScreenSearch = false.obs;
  var isClickDetailsScreenSearch = false.obs;
  var isLoading = false.obs;
  var tmtlList = [].obs;

  changeIndex(int index) => tabBarIndex.value = index;

  changeDateTime(DateTime dateTime) => selectedDate.value = dateTime;

  void changeListScreenSearchStatus() => isClickListScreenSearch.value = !isClickListScreenSearch.value;
  void changeDetailsScreenSearchStatus() => isClickDetailsScreenSearch.value = !isClickDetailsScreenSearch.value;

  @override
  void onInit() {
    super.onInit();
    getTMTLList();
  }

  void getTMTLList({String? date}) async {
    try {
      isLoading(true);
      tmtlList.value = [];

      var map = <String, dynamic>{};
      map['date'] = date;

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.getAllTMTL,
          params: map,
        ),
      );

      if (responseBody != null) {
        for (Map<String, dynamic> i in responseBody['tmtls']) {
          tmtlList.add(TMTLData.fromJson(i));
          tmtlList.refresh();
        }
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
