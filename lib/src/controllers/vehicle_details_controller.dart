import 'package:get/get.dart';
import 'package:recall/src/models/vehicle_detail_data.dart';
import 'package:recall/src/network/api.dart';
import 'package:recall/src/network/network_utils.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/views/base/helper.dart';

class VehicleDetailsController extends GetxController {
  var routeList = [].obs;
  var isLoading = false.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  var isClickSearch = false.obs;

  changeSelectedDateTime(DateTime dateTime) => selectedDate.value = dateTime;
  void changeSearchStatus() => isClickSearch.value = !isClickSearch.value;

  void getVehicleDetails({required int id}) async {
    try {
      isLoading(true);
      routeList.value = [];

      final date = selectedDate.value;
      var map = <String, dynamic>{};
      map['id'] = id.toString();
      map['date'] = '${date.month}/${date.day}/${date.year}';

      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: Api.getVehicleDetails,
          params: map,
        ),
      );

      if (responseBody != null) {
        for (Map<String, dynamic> i in responseBody['routes']) {
          routeList.add(RouteData.fromJson(i));
          routeList.refresh();
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
