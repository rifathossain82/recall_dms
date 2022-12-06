import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recall/src/controllers/vehicle_details_controller.dart';
import 'package:recall/src/models/stepper_data_model.dart';
import 'package:recall/src/models/vehicle_detail_data.dart';
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
import 'package:recall/src/views/screens/vehicle/components/custom_stepper.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final int id;

  VehicleDetailsScreen({Key? key, required this.id}) : super(key: key);

  final vehicleDetailsController = Get.put(VehicleDetailsController());
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    vehicleDetailsController.getVehicleDetails(id: id);
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              /// appBar content
              _buildVehicleDetailsAppBar(context),

              /// body content
              Expanded(
                child: _buildVehicleDetailsBody(context),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildVehicleDetailsAppBar(BuildContext context) {
    if (vehicleDetailsController.isClickSearch.value) {
      searchFocusNode.requestFocus();
    }
    return KAppBar(
      leading: GestureDetector(
        onTap: () {
          Get.delete<VehicleDetailsController>();
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
      title: vehicleDetailsController.isClickSearch.value
          ? KTextFiled(
              controller: searchController,
              focusNode: searchFocusNode,
              hintText: 'Search here',
              isBorder: false,
              onChanged: (value) {
                print(value);
              },
            )
          : Text(
              'Vehicle  $id',
              style: h2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
      actions: [
        GestureDetector(
          onTap: vehicleDetailsController.changeSearchStatus,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: vehicleDetailsController.isClickSearch.value
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

  Widget _buildVehicleDetailsBody(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// date and calender widget
          KDate(
            onPressed: () => _selectDate(context),
            dateTime: vehicleDetailsController.selectedDate.value,
          ),

          /// stepper
          Expanded(
            child: _buildStepper(),
          ),

          /// give space at the bottom
          addVerticalSpace(Dimensions.paddingSizeExtraLarge),
        ],
      );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: vehicleDetailsController.selectedDate.value,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (picked != null &&
        picked != vehicleDetailsController.selectedDate.value) {
      vehicleDetailsController.changeSelectedDateTime(picked);
      vehicleDetailsController.getVehicleDetails(id: id);
      kPrint('${picked.month}/${picked.day}/${picked.year}');
    }
  }

  Widget _buildStepper() {
    if (vehicleDetailsController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (vehicleDetailsController.routeList.isEmpty) {
      return const NoDataFound();
    } else {
      var stepperDataList = [];
      for (RouteData route in vehicleDetailsController.routeList) {
        stepperDataList.add(
          StepperData(
            isDone: true,
            content: Column(
              children: [
                _buildLocationListTile(
                  address: route.locationName ?? '',
                  totalItem: route.tmtlCount ?? 0,
                  time: route.assignTime ?? '',
                  isComplete: true,
                ),
                _buildBox(
                  tmtlList: route.routeTMTLs ?? [],
                  isComplete: true,
                ),
              ],
            ),
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: stepperDataList.length,
          itemBuilder: (context, index) {
            return CustomStepper(stepperData: stepperDataList[index]);
          },
        ),
      );
    }
  }

  Widget _buildLocationListTile({
    required String address,
    required int totalItem,
    required String time,
    required bool isComplete,
  }) =>
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 49,
          width: 49,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            color: isComplete ? Color(0xFFFFEECC) : kInActiveColor,
          ),
          child: SvgPicture.asset(
            AssetPath.locationIconSvgSvg,
            semanticsLabel: 'Location Icon',
            color: isComplete ? null : kWhite,
          ),
        ),
        title: Text(
          address,
          style: h3.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$totalItem Items     $time',
              maxLines: 1,
              style: h4.copyWith(
                color: isComplete ? mainColor : kInActiveColor,
              ),
            ),
            Text(
              isComplete ? 'Delivery Complete' : 'Delivery Pending',
              style: h4.copyWith(
                fontWeight: FontWeight.w500,
                color: isComplete ? kTMTLInColor : mainColor,
              ),
            ),
          ],
        ),
      );

  Widget _buildBox({
    required List<RouteTMTL> tmtlList,
    required bool isComplete,
  }) {
    return Column(
      children: [
        ...List.generate(
          tmtlList.length,
          (index) => Column(
            children: [
              _buildBoxListTile(tmtlList[index], isComplete),
              Divider(
                color: kDividerColor,
                height: 8,
                thickness: 1.0,
              ),
            ],
          ),
        ),
        addVerticalSpace(40),
      ],
    );
  }

  Widget _buildBoxListTile(RouteTMTL tmtl, bool isComplete) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 49,
          width: 49,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.radiusDefault,
            ),
            color: isComplete ? kActiveColor : kInActiveColor,
          ),
          child: SvgPicture.asset(
            AssetPath.boxIcon,
            semanticsLabel: 'Box Icon',
          ),
        ),
        title: Text(
          'TMTL -${tmtl.id}',
          style: h3.copyWith(
            fontWeight: FontWeight.w500,
            color: isComplete ? null : kInActiveColor,
          ),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${tmtl.tmtlItemsCount} Box',
              style: h4.copyWith(
                fontWeight: FontWeight.w500,
                color: kInActiveColor,
              ),
            ),
            addHorizontalSpace(2),
            Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isComplete ? mainColor : kInActiveColor,
              ),
            ),
            addHorizontalSpace(Dimensions.paddingSizeSmall),
            Text(
              '(${tmtl.clientShortCode})',
              style: h4.copyWith(
                fontWeight: FontWeight.w500,
                color: isComplete ? kBlueGrey : kInActiveColor,
              ),
            ),
          ],
        ),
        trailing: SvgPicture.asset(
          AssetPath.arrowRightIconSvg,
          semanticsLabel: 'Arrow Right',
          color: isComplete ? null : kInActiveColor,
        ),
      );
}
