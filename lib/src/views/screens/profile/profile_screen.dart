import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/routes/route.dart';
import 'package:recall/src/controllers/auth_controller.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/base/k_button.dart';
import 'package:recall/src/views/base/k_shadow_button.dart';
import 'package:recall/src/views/base/k_shadow_outline_button.dart';
import 'package:recall/src/views/screens/profile/components/dashed_line_painter.dart';
import 'package:recall/src/views/screens/profile/components/info_card.dart';
import 'package:recall/src/views/screens/profile/components/info_item.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              /// appBar content
              _buildProfileAppBar(context),

              /// body content
              Expanded(
                child: _buildProfileBody(context),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProfileAppBar(BuildContext context) {
    return KAppBar(
      title: Text(
        'Profile',
        style: h2.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProfileBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// profile image
          _buildImage(context, null),
          addVerticalSpace(Dimensions.paddingSizeDefault),

          /// user name
          Text(
            'Abdur Rahim',
            style: GoogleFonts.roboto(
              textStyle: h2.copyWith(
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
          addVerticalSpace(Dimensions.paddingSizeExtraSmall),

          /// user status
          Text(
            'Driver',
            style: GoogleFonts.roboto(
              textStyle: h3.copyWith(
                color: mainColor,
              ),
            ),
          ),
          addVerticalSpace(Dimensions.paddingSizeDefault),

          /// dashedLine
          SizedBox(
            width: Get.width,
            child: CustomPaint(
              painter: DashedLinePainter(),
            ),
          ),
          addVerticalSpace(Dimensions.paddingSizeExtraLarge),

          /// profile info card
          const ProfileInfoCard(),
          addVerticalSpace(40),

          /// change password button
          _buildChangePasswordButton(),
          addVerticalSpace(Dimensions.paddingSizeDefault),

          /// logout button
          _buildLogoutButton(context),
          addVerticalSpace(40),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, imgUrl) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Center(
        child: imgUrl == null
            ? Image.asset(
                AssetPath.profileDemo,
              )
            : Image.network(
                imgUrl,
                loadingBuilder: (context, child, _) =>
                    const CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _buildChangePasswordButton() => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: KShadowOutlineButton(
          onPressed: () => Get.toNamed(RouteGenerator.changePassword),
          child: Text(
            'Change Password',
            style: GoogleFonts.roboto(
              textStyle: h2.copyWith(
                color: mainColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );

  Widget _buildLogoutButton(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: KShadowButton(
          onPressed: () async {
            bool? result = await kConfirmDialog(
              context: context,
              title: 'Are you sure you want to logout?',
              negativeActionText: 'Cancel',
              positiveActionText: 'Logout',
            );

            if(result!){
              authController.logout();
            }
          },
          child: authController.isLoading.value
              ? Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: kWhite,
                  ),
                )
              : Text(
                  'Logout',
                  style: GoogleFonts.roboto(
                    textStyle: h2.copyWith(
                      color: kWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ),
      );
}
