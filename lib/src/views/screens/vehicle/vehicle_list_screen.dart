import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/base/k_date.dart';
import 'package:recall/src/views/screens/vehicle/components/vehicle_item_card.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// appBar content
            _buildVehicleListAppBar(context),

            /// body content
            Expanded(
              child: _buildVehicleListBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleListAppBar(BuildContext context) => KAppBar(
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
          'Vehicle List',
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

  Widget _buildVehicleListBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// date and calender widget
          KDate(
            onPressed: () {
              print('Please create method.');
            },
            dateTime: DateTime.now(),
          ),

          /// vehicle list
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) => VehicleItemCard(),
              separatorBuilder: (context, index) => addVerticalSpace(
                Dimensions.paddingSizeSmall,
              ),
            ),
          ),

          /// give space at the bottom
          addVerticalSpace(Dimensions.paddingSizeExtraLarge),
        ],
      );

}
