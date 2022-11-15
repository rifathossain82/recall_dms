import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';

class KDate extends StatelessWidget {
  const KDate({Key? key, required this.onPressed, required this.dateTime}) : super(key: key);

  final VoidCallback onPressed;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSizeDefault,
        right: Dimensions.paddingSizeDefault,
        bottom: Dimensions.paddingSizeLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            customDateFormat(dateTime)!,
            textAlign: TextAlign.start,
            style: h4,
          ),
          GestureDetector(
            onTap: onPressed,
            child: SvgPicture.asset(
              AssetPath.calendarIconSvg,
              semanticsLabel: 'Calendar Icon',
            ),
          ),
        ],
      ),
    );
  }
}
