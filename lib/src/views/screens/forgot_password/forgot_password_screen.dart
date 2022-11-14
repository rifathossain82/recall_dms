import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/controllers/forgot_password_controller.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_logo.dart';
import 'package:recall/src/views/screens/forgot_password/components/forgot_password_tab_item.dart';
import 'package:recall/src/views/screens/tmtl/components/tabBar_item.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
      ),
      body: Column(
        children: [
          /// logo and forgotPassword text
          const KLogo(),
          Text(
            'Forgot your Password',
            style: GoogleFonts.roboto(
              textStyle: h4.copyWith(
                fontWeight: FontWeight.w300,
                color: kBlackLight,
              ),
            ),
          ),

          Expanded(
            child: _buildTabWidget(),
          ),

          /// email/phone textField
          // addVerticalSpace(Get.height * 0.05),
          // _buildEmailOrPhoneTextFiled(),
          //
          // /// password textField
          // addVerticalSpace(Get.height * 0.03),
          // _buildPasswordTextFiled(),
          //
          // /// login button
          // addVerticalSpace(Get.height * 0.05),
          // _buildLoginButton(),
          //
          // /// forgot password button
          // addVerticalSpace(Get.height * 0.025),
          // const ForgotPasswordButton(),
        ],
      ),
    );
  }

  Widget _buildTabWidget() => Obx(
        () => DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                constraints: const BoxConstraints.expand(height: 50),
                child: _buildTabBar()
              ),
              addVerticalSpace(Dimensions.paddingSizeSmall),
              Expanded(
                child: _buildTabBarView(),
              ),
            ],
          ),
        ),
      );

  Widget _buildTabBar() => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: TabBar(
          onTap: forgotPasswordController.changeIndex,
          indicatorColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          labelPadding: EdgeInsets.zero,
          tabs: [
            Align(
              alignment: Alignment.centerLeft,
              child: ForgotPasswordTabItem(
                assetPath: AssetPath.phoneIcon,
                itemName: 'Phone No.',
                isActive: forgotPasswordController.tabBarIndex.value == 0
                    ? true
                    : false,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ForgotPasswordTabItem(
                assetPath: AssetPath.mailIcon,
                itemName: 'Email',
                isActive: forgotPasswordController.tabBarIndex.value == 1
                    ? true
                    : false,
              ),
            ),
          ],
        ),
      );

  Widget _buildTabBarView() => TabBarView(
        children: [
          _buildForgotWithPhone(),
          Container(),
        ],
      );

  Widget _buildForgotWithPhone() => Padding(
    padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
    child: Column(
      children: [
        Text(
          'Please enter the account that you want to reset the password',
          style: GoogleFonts.roboto(
            textStyle: h4.copyWith(
              color: kBlackLight,
            ),
          ),
        )
      ],
    ),
  );
}
