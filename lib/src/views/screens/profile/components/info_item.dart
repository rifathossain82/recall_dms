import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';

class ProfileInfoItem extends StatelessWidget {
  final String title;
  final String data;
  final VoidCallback onPressed;

  const ProfileInfoItem({
    Key? key,
    required this.title,
    required this.data,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              textStyle: h4,
            ),
          ),
          const Spacer(),
          Text(
            data,
            style: GoogleFonts.roboto(
              textStyle: h5.copyWith(
                color: kGreyDeep2,
              ),
            ),
          ),
          addHorizontalSpace(Dimensions.paddingSizeDefault),
          SvgPicture.asset(
            AssetPath.arrowRightIconSvg,
            semanticsLabel: 'Arrow Right',
            color: kGreyDeep2,
            height: 8,
          ),
        ],
      ),
    );
  }
}
