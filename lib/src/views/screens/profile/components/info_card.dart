import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/views/screens/profile/components/info_item.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
      ),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 0,
              color: kItemShadowColor,
            ),
          ],
        ),
        child: Column(
          children: [
            ProfileInfoItem(
              title: 'Name',
              data: 'Abdur Rahim',
              onPressed: () {},
            ),
            _buildDivider(),
            ProfileInfoItem(
              title: 'Phone Number',
              data: '01882508771',
              onPressed: () {},
            ),
            _buildDivider(),
            ProfileInfoItem(
              title: 'Email',
              data: 'Not Set',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => Divider(
    color: kGreyMedium,
    height: 26,
  );
}
