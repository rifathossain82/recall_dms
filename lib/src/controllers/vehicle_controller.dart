import 'package:get/get.dart';
import 'package:recall/src/models/vehicle_data.dart';
import 'package:recall/src/network/api.dart';
import 'package:recall/src/network/network_utils.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/views/base/helper.dart';

class VehicleController extends GetxController {
  var vehicleList = [].obs;
  var isLoading = false.obs;

  Rx<DateTime> listScreenDate = DateTime.now().obs;
  Rx<DateTime> detailsScreenDate = DateTime.now().obs;
  var isClickListScreenSearch = false.obs;
  var isClickDetailsScreenSearch = false.obs;

  changeListScreenDateTime(DateTime dateTime) =>
      listScreenDate.value = dateTime;

  changeDetailsScreenDateTime(DateTime dateTime) =>
      detailsScreenDate.value = dateTime;

  void changeListScreenSearchStatus() =>
      isClickListScreenSearch.value = !isClickListScreenSearch.value;

  void changeDetailsScreenSearchStatus() =>
      isClickDetailsScreenSearch.value = !isClickDetailsScreenSearch.value;

  @override
  void onInit() {
    super.onInit();
    getVehicleList();
  }

  void getVehicleList({String? date}) async {
    try {
      isLoading(true);
      vehicleList.value = [];

      var map = <String, dynamic>{};
      map['date'] = date;

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.getAllVehicle,
          params: map,
        ),
      );

      if (responseBody != null) {
        for (Map<String, dynamic> i in responseBody['vehicles']) {
          vehicleList.add(VehicleData.fromJson(i));
          vehicleList.refresh();
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
