import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/screens/vehicle/vehicle_details_screen.dart';

class VehicleItemCard extends StatelessWidget {
  const VehicleItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNewScreen(VehicleDetailsScreen()),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Container(
            width: Get.width,
            padding: EdgeInsets.only(
              left: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeDefault,
              top: Dimensions.paddingSizeLarge,
              bottom: Dimensions.paddingSizeLarge,
            ),
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault,),
                border: Border.all(
                  color: mainColor,
                  width: 0.2,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: kItemShadowColor,
                  )
                ]
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AssetPath.vehicleIcon,
                        ),
                      ],
                    ),
                  ),
                  addHorizontalSpace(Dimensions.paddingSizeExtraSmall),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vehicle ID #001",
                          style: h3.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        addVerticalSpace(2),
                        Text(
                          '10:00am - 02:00pm',
                          style: h5,
                        ),
                        addVerticalSpace(2),
                        Text(
                          'Uttara - Banani - Mirpur - Basabo.',
                          style: GoogleFonts.roboto(
                            textStyle: h4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  addHorizontalSpace(Dimensions.paddingSizeExtraSmall),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 24,
                          width: Get.width * 0.15,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault,),
                          ),
                          child: Text(
                            'Route',
                            textAlign: TextAlign.center,
                            style: h5.copyWith(
                              color: kWhite,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          AssetPath.arrowRightIconSvg,
                          semanticsLabel: 'Arrow Right',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
