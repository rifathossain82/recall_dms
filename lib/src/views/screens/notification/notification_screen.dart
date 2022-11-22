import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/services/fake_data.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/screens/notification/components/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// appBar content
            _buildNotificationAppBar(context),

            /// body content
            Expanded(
              child: _buildNotificationBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationAppBar(BuildContext context) {
    // if(tmtlController.isClickSearch.value){
    //   searchFocusNode.requestFocus();
    // }
    return KAppBar(
      title: Text(
        'Notification',
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
  }

  Widget _buildNotificationBody(BuildContext context) {
    return ListView.separated(
      itemCount: notificationList.length + 1,
      itemBuilder: (context, index) {
        if(index == notificationList.length){
          return Column(
            children: [
              addVerticalSpace(Dimensions.paddingSizeLarge),
              GestureDetector(
                onTap: (){
                  kPrint('Load More.......');
                },
                child: Text(
                  'Tap To load more',
                  style: GoogleFonts.roboto(
                    textStyle: h5.copyWith(
                      color: mainColor,
                    ),
                  ),
                ),
              ),

              addVerticalSpace(50),
            ],
          );
        } else{
          return NotificationCard(
            notification: notificationList[index],
          );
        }

      },
      separatorBuilder: (context, index) => addVerticalSpace(
        Dimensions.paddingSizeDefault,
      ),
    );
  }
}
