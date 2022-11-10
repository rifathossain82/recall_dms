import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/screens/home/components/home_item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHomeAppBar(),
            _buildHomeBody(),
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

  Widget _buildHomeBody() => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Masud Rana',
              textAlign: TextAlign.start,
              style: h2.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            addVerticalSpace(Dimensions.paddingSizeExtraSmall),
            Text(
              'Date: 1 Oct 2022',
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
                  assetImagePath: AssetPath.introImage1,
                  title: 'TMTL List',
                  onTap: () => Get.toNamed(RouteGenerator.tmtlList),
                ),
                HomeItemCard(
                  assetImagePath: AssetPath.introImage2,
                  title: 'Route Track',
                  onTap: () {
                    print('Route Track');
                  },
                ),
              ],
            )
          ],
        ),
      );
}
