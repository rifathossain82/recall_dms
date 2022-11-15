import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recall/src/models/stepper_data_model.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/base/k_date.dart';
import 'package:recall/src/views/screens/vehicle/components/custom_stepper.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// appBar content
            _buildVehicleDetailsAppBar(context),

            /// body content
            Expanded(
              child: _buildVehicleDetailsBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleDetailsAppBar(BuildContext context) => KAppBar(
        leading: GestureDetector(
          onTap: () => context.popScreen(),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Icon(
              Icons.arrow_back,
              color: kBlackLight,
            ),
          ),
        ),
        title: Text(
          'Vehicle 001',
          style: h2.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: SvgPicture.asset(
                AssetPath.searchIconSvg,
                semanticsLabel: 'Search Icon',
              ),
            ),
          ),
        ],
      );

  Widget _buildVehicleDetailsBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// date and calender widget
          KDate(
            onPressed: () {
              print('Please create method.');
            },
            dateTime: DateTime.now(),
          ),

          /// stepper
          Expanded(
            child: _buildStepper(),
          ),

          /// give space at the bottom
          addVerticalSpace(Dimensions.paddingSizeExtraLarge),
        ],
      );

  Widget _buildStepper() {
    final stepperDataList = [
      StepperData(
        isDone: true,
        content: Column(
          children: [
            _buildLocationListTile(true),
            _buildBox(true),
          ],
        ),
      ),
      StepperData(
        isDone: true,
        content: Column(
          children: [
            _buildLocationListTile(true),
            _buildBox(true),
          ],
        ),
      ),
      StepperData(
        isDone: false,
        content: Column(
          children: [
            _buildLocationListTile(false),
            _buildBox(false),
          ],
        ),
      ),
    ];

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

  Widget _buildLocationListTile(bool isComplete) => ListTile(
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
          'Uttara, Dhaka',
          style: h3.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '10:00 am   02 October 2022',
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

  Widget _buildBox(bool isComplete) {
    return Column(
      children: [
        ...List.generate(
          2,
          (index) => Column(
            children: [
              _buildBoxListTile(isComplete),
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

  Widget _buildBoxListTile(bool isComplete) => ListTile(
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
          'TMTL -001',
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
              '3 Box',
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
              '(CBL)',
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
