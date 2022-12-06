import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/controllers/auth_controller.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/screens/home/components/home_item_card.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/views/screens/tmtl/tmtl_list_screen.dart';
import 'package:recall/src/views/screens/vehicle/vehicle_list_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHomeAppBar(),
            Expanded(child: _buildHomeBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeAppBar() => KAppBar(
        leading: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            color: mainColor,
          ),
          child: Text(
            'R',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              textStyle: h1.copyWith(
                fontWeight: FontWeight.w600,
                color: kWhite,
              ),
            ),
          ),
        ),
        title: Text(
          'Recall Driver',
          style: GoogleFonts.manrope(
            textStyle: h1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  Widget _buildHomeBody(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () {
                  return Text(
                    'Welcome ${authController.user.value.name ?? ''}',
                    textAlign: TextAlign.start,
                    style: h2.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
              ),
              addVerticalSpace(Dimensions.paddingSizeExtraSmall),
              Text(
                'Date: ${DateFormat('d MMM yyyy').format(DateTime.now())}',
                textAlign: TextAlign.start,
                style: h4.copyWith(
                  color: kGreyTextColor,
                ),
              ),
              addVerticalSpace(Dimensions.paddingSizeDefault),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeItemCard(
                    assetImagePath: AssetPath.folderIcon,
                    title: 'TMTL List',
                    onTap: () => context.pushNewScreen(TMTLListScreen()),
                  ),
                  HomeItemCard(
                    assetImagePath: AssetPath.routeIcon,
                    title: 'Route Track',
                    onTap: () => context.pushNewScreen(VehicleListScreen()),
                  ),
                ],
              ),
              addVerticalSpace(Dimensions.paddingSizeLarge),
            ],
          ),
        ),
      );
}
