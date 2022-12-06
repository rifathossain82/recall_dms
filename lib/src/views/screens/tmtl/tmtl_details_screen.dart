import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recall/src/controllers/tmtl_controller.dart';
import 'package:recall/src/controllers/tmtl_details_controller.dart';
import 'package:recall/src/models/tmtl_data.dart';
import 'package:recall/src/models/tmtl_detail_data.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/base/k_text_field.dart';
import 'package:recall/src/views/screens/tmtl/components/tmtl_item_card.dart';

class TMTLDetailsScreen extends StatelessWidget {
  final TMTLData tmtl;

  TMTLDetailsScreen({Key? key, required this.tmtl}) : super(key: key);

  final TMTLDetailsController _tmtlDetailsController =
      Get.put(TMTLDetailsController());
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _tmtlDetailsController.getTMTLDetails(id: tmtl.id!);
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              /// appBar content
              _buildTMTLDetailsAppBar(context),

              /// body content
              Expanded(
                child: _buildTMTLDetailsBody(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTMTLDetailsAppBar(BuildContext context) {
    if (_tmtlDetailsController.isClickSearch.value) {
      _focusNode.requestFocus();
    }
    return KAppBar(
      leading: GestureDetector(
        onTap: () {
          Get.delete<TMTLDetailsController>();
          _searchController.clear();
          context.popScreen();
        },
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Icon(
            Icons.arrow_back,
            color: kBlackLight,
          ),
        ),
      ),
      title: _tmtlDetailsController.isClickSearch.value
          ? KTextFiled(
              controller: _searchController,
              focusNode: _focusNode,
              hintText: 'Search here',
              isBorder: false,
              onChanged: (value) {
                print(value);
              },
            )
          : Text(
              'TMTL ${tmtl.id}',
              style: h2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
      actions: [
        GestureDetector(
          onTap: _tmtlDetailsController.changeSearchStatus,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: _tmtlDetailsController.isClickSearch.value
                ? Icon(
                    Icons.clear,
                    size: 20,
                    color: mainColor,
                  )
                : SvgPicture.asset(
                    AssetPath.searchIconSvg,
                    semanticsLabel: 'Search Icon',
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildTMTLDetailsBody() {
    return _tmtlDetailsController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            children: [
              _buildItemCard(),
              addVerticalSpace(Dimensions.paddingSizeExtraLarge),
              _buildLocationListTile(),
              Divider(
                color: mainColor,
                height: 20,
                thickness: 0.5,
              ),
              _tmtlDetailsController.tmtlDetails.value.isCurrent == 0
                  ? _buildBox()
                  : Container(),
              addVerticalSpace(Dimensions.paddingSizeExtraLarge),
            ],
          );
  }

  Widget _buildItemCard() => TMTLItemCard(
        tmtlData: tmtl,
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
            tmtl.locationName ?? '',
            style: h3.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tmtl.assignTime ?? '',
                style: h4.copyWith(
                  color: mainColor,
                ),
              ),
              addHorizontalSpace(Dimensions.paddingSizeLarge),
              Text(
                tmtl.assignDate ?? '',
                style: h4.copyWith(
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildBox() {
    final List<NBL1> nblList = _tmtlDetailsController.tmtlDetails.value.tmtlItems.nBL1;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: nblList.length,
      itemBuilder: (context, index) => _buildBoxListTile(nblList[index]),
      separatorBuilder: (context, index) => Divider(
        color: kDividerColor,
        height: 8,
        thickness: 1.0,
      ),
    );
  }

  Widget _buildBoxListTile(NBL1 nbl1) => Padding(
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
            nbl1.boxCode ?? '',
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
