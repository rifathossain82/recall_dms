import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recall/src/controllers/vehicle_controller.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/base/k_date.dart';
import 'package:recall/src/views/base/k_text_field.dart';
import 'package:recall/src/views/base/no_data_found.dart';
import 'package:recall/src/views/screens/vehicle/components/vehicle_item_card.dart';

class VehicleListScreen extends StatelessWidget {
  VehicleListScreen({Key? key}) : super(key: key);

  final vehicleController = Get.put(VehicleController());
  TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              /// appBar content
              _buildVehicleListAppBar(context),

              /// body content
              Expanded(
                child: _buildVehicleListBody(context),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildVehicleListAppBar(BuildContext context) {
    if(vehicleController.isClickListScreenSearch.value){
      searchFocusNode.requestFocus();
    }
    return KAppBar(
      leading: GestureDetector(
        onTap: () {
          Get.delete<VehicleController>();
          context.popScreen();
        },
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Icon(
            Icons.arrow_back,
            color: kBlackLight,
          ),
        ),
      ),
      title: vehicleController.isClickListScreenSearch.value
          ? KTextFiled(
        controller: searchController,
        focusNode: searchFocusNode,
        hintText: 'Search here',
        isBorder: false,
        onChanged: (value) {
          print(value);
        },
      ) : Text(
        'Vehicle List',
        style: h2.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        /// search and close icon
        GestureDetector(
          onTap: vehicleController.changeListScreenSearchStatus,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: vehicleController.isClickListScreenSearch.value
                ? Icon(
              Icons.clear,
              size: 20,
              color: mainColor,
            )
                : SvgPicture.asset(
              AssetPath.searchIconSvg,
              semanticsLabel: 'Search Icon',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleListBody(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// date and calender widget
          KDate(
            onPressed: () => _selectDate(context),
            dateTime: vehicleController.listScreenDate.value,
          ),

          /// vehicle list
          Expanded(
            child: vehicleController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : vehicleController.vehicleList.isEmpty
                    ? const NoDataFound()
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: vehicleController.vehicleList.length,
                        itemBuilder: (context, index) {
                          return VehicleItemCard(
                            vehicle: vehicleController.vehicleList[index],
                          );
                        },
                        separatorBuilder: (context, index) => addVerticalSpace(
                          Dimensions.paddingSizeSmall,
                        ),
                      ),
          ),

          /// give space at the bottom
          addVerticalSpace(Dimensions.paddingSizeExtraLarge),
        ],
      );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: vehicleController.listScreenDate.value,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (picked != null &&
        picked != vehicleController.listScreenDate.value) {
      vehicleController.changeListScreenDateTime(picked);
      vehicleController.getVehicleList(
          date: '${picked.month}/${picked.day}/${picked.year}');
      kPrint('${picked.month}/${picked.day}/${picked.year}');
    }
  }
}
