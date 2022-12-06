import 'package:get/get.dart';
import 'package:recall/src/models/tmtl_data.dart';
import 'package:recall/src/network/api.dart';
import 'package:recall/src/network/network_utils.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/views/base/helper.dart';

class TMTLController extends GetxController {
  var tabBarIndex = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  var isClickSearch = false.obs;

  var isLoading = false.obs;
  var tmtlList = [].obs;

  void changeIndex(int index) => tabBarIndex.value = index;
  changeSelectedDateTime(DateTime dateTime) => selectedDate.value = dateTime;
  void changeSearchStatus() => isClickSearch.value = !isClickSearch.value;

  @override
  void onInit() {
    super.onInit();
    getTMTLList();
  }

  void getTMTLList() async {
    try {
      isLoading(true);
      tmtlList.value = [];

      final date = selectedDate.value;
      var map = <String, dynamic>{};
      map['date'] = '${date.month}/${date.day}/${date.year}';

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
