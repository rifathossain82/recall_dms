import 'package:get/get.dart';
import 'package:recall/src/models/vehicle_data.dart';
import 'package:recall/src/network/api.dart';
import 'package:recall/src/network/network_utils.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/views/base/helper.dart';

class VehicleController extends GetxController{
  var vehicleList = [].obs;
  var isLoading = false.obs;

  Rx<DateTime> vehicleListScreenDate = DateTime.now().obs;
  var isClickSearch = false.obs;

  changeVehicleListScreenDateTime(DateTime dateTime) => vehicleListScreenDate.value = dateTime;

  void changeSearchStatus() => isClickSearch.value = !isClickSearch.value;

  @override
  void onInit() {
    super.onInit();
    getVehicleList();
  }

  void getVehicleList({
    String? date,
  }) async {
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
        KSnackBar(message: 'Failed to load data!', bgColor: failedColor);
      }
    } catch (e) {
      KSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }
}