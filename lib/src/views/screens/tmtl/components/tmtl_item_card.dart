import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/services/fake_data.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/screens/tmtl/tmtl_details_screen.dart';

class TMTLItemCard extends StatelessWidget {
  const TMTLItemCard({
    Key? key,
    required this.tmtlData,
    this.isNavigation = true,
  }) : super(key: key);

  final TMTLModel tmtlData;
  final bool isNavigation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault,
      ),
      child: GestureDetector(
        onTap: () => isNavigation
            ? context.pushNewScreen(TMTLDetailsScreen(id: tmtlData.id))
            : null,
        child: Container(
          width: Get.width,
          padding: EdgeInsets.only(
            left: Dimensions.paddingSizeDefault,
            top: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault,
          ),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            border: Border.all(
              color: tmtlData.status == TMTLStatus.In
                  ? kTMTLInColor
                  : kTMTLOutColor,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
                color: kItemShadowColor,
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TML- ${tmtlData.id}",
                        style: GoogleFonts.roboto(
                          textStyle: h2.copyWith(
                            fontWeight: FontWeight.w500,
                            color: tmtlData.status == TMTLStatus.In
                                ? kTMTLInColor
                                : kTMTLOutColor,
                          ),
                        ),
                      ),
                      addVerticalSpace(4),
                      Text(
                        tmtlData.bank,
                        style: GoogleFonts.roboto(
                          textStyle: h5.copyWith(
                            color: kBlackLight,
                          ),
                        ),
                      ),
                      addVerticalSpace(4),
                      Text(
                        tmtlData.address,
                        style: GoogleFonts.roboto(
                          textStyle: h4.copyWith(
                            color: kBlackLight,
                          ),
                        ),
                      ),
                      addVerticalSpace(6),
                      Text(
                        isNavigation ? tmtlData.time : tmtlData.quantity,
                        style: GoogleFonts.roboto(
                          textStyle: h5.copyWith(
                            color: kGreyLightProMax,
                          ),
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
                        width: Get.width * 0.12,
                        decoration: BoxDecoration(
                          color: tmtlData.status == TMTLStatus.In
                              ? kTMTLInColor.withOpacity(0.3)
                              : kTMTLOutColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: tmtlData.status == TMTLStatus.In
                                ? kTMTLInColor
                                : kTMTLOutColor,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tmtlData.status == TMTLStatus.In
                              ? TMTLStatus.In.name
                              : TMTLStatus.Out.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            textStyle: h4.copyWith(
                              color: tmtlData.status == TMTLStatus.In
                                  ? kTMTLInColor
                                  : kTMTLOutColor,
                            ),
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
          ),
        ),
      ),
    );
  }
}
