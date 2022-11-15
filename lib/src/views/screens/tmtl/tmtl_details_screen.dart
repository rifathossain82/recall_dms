import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/services/fack_data.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/screens/tmtl/components/tmtl_item_card.dart';

class TMTLDetailsScreen extends StatelessWidget {
  const TMTLDetailsScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// appBar content
            _buildTMTLDetailsAppBar(context),

            /// body content
            Expanded(
              child: _buildTMTLDetailsBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTMTLDetailsAppBar(BuildContext context) => KAppBar(
        leading: GestureDetector(
          onTap: () => context.popScreen(),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Icon(
              Icons.arrow_back,
              color: kBlackLight,
            ),
          ),
        ),
        title: Text(
          'TMTL $id',
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

  Widget _buildTMTLDetailsBody() {
    return ListView(
      children: [
        _buildItemCard(),
        addVerticalSpace(Dimensions.paddingSizeExtraLarge),
        _buildLocationListTile(),
        Divider(
          color: mainColor,
          height: 20,
          thickness: 0.5,
        ),
        _buildBox(),
        Divider(
          color: kDividerColor,
          height: 8,
          thickness: 1.0,
        ),
        addVerticalSpace(Dimensions.paddingSizeExtraLarge),
      ],
    );
  }

  Widget _buildItemCard() => TMTLItemCard(
        tmtlData: tmtlDataList[0],
        isNavigation: false,
      );

  Widget _buildLocationListTile() => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 49,
            width: 49,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              color: Color(0xFFFFEECC),
            ),
            child: SvgPicture.asset(
              AssetPath.locationIconSvgSvg,
              semanticsLabel: 'Location Icon',
            ),
          ),
          title: Text(
            tmtlDataList[0].address,
            style: h3.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '10:00 am',
                style: h4.copyWith(
                  color: mainColor,
                ),
              ),
              addHorizontalSpace(Dimensions.paddingSizeLarge),
              Text(
                '02 October 2022',
                style: h4.copyWith(
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildBox() => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) => _buildBoxListTile(),
        separatorBuilder: (context, index) => Divider(
          color: kDividerColor,
          height: 8,
          thickness: 1.0,
        ),
      );

  Widget _buildBoxListTile() => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 49,
            width: 49,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              color: mainColor,
            ),
            child:
                SvgPicture.asset(AssetPath.boxIcon, semanticsLabel: 'Box Icon'),
          ),
          title: Text(
            'Box -001',
            style: h3.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: SvgPicture.asset(
            AssetPath.arrowDownIconSvg,
            semanticsLabel: 'Arrow Down',
          ),
        ),
      );
}
