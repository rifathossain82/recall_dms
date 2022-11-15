import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recall/src/controllers/tmtl_controller.dart';
import 'package:recall/src/services/fack_data.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/base/k_date.dart';
import 'package:recall/src/views/base/k_text_field.dart';
import 'package:recall/src/views/screens/tmtl/components/tabBar_item.dart';
import 'package:recall/src/views/screens/tmtl/components/tmtl_item_card.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';

class TMTLListScreen extends StatelessWidget {
  TMTLListScreen({Key? key}) : super(key: key);

  final TMTLController tmtlController = Get.put(TMTLController());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              /// appBar content
              _buildTMTLAppBar(context),

              /// body content
              Expanded(
                child: _buildTMTLBody(context),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTMTLAppBar(BuildContext context) => KAppBar(
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
        title: tmtlController.isClickSearch.value
            ? KTextFiled(
                controller: searchController,
                hintText: 'Search here',
                isBorder: false,
                onChanged: (value) {
                  print(value);
                },
              )
            : Text(
                'TMTL List',
                style: h2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
        actions: [
          /// filter icon
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: SvgPicture.asset(
                AssetPath.filterIconSvg,
                semanticsLabel: 'Filter Icon',
              ),
            ),
          ),

          /// horizontal space
          addHorizontalSpace(2),

          /// search and close icon
          GestureDetector(
            onTap: tmtlController.changeSearchStatus,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: tmtlController.isClickSearch.value
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

  Widget _buildTMTLBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// date and calender widget
        KDate(
          onPressed: () => _selectDate(context),
          dateTime: tmtlController.selectedDate.value,
        ),

        /// tabBar widgets
        Expanded(
          child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  constraints: const BoxConstraints.expand(height: 50),
                  child: _buildTabBar(),
                ),
                addVerticalSpace(Dimensions.paddingSizeSmall),
                Expanded(
                  child: _buildTabBarView(),
                ),
                addVerticalSpace(Dimensions.paddingSizeLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tmtlController.selectedDate.value,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != tmtlController.selectedDate.value) {
      tmtlController.changeDateTime(picked);
      print(picked);
    }
  }

  Widget _buildTabBar() => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: TabBar(
          onTap: tmtlController.changeIndex,
          indicatorColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          labelPadding: EdgeInsets.zero,
          tabs: [
            Align(
              alignment: Alignment.centerLeft,
              child: TabBarItem(
                itemName: 'All',
                isActive: tmtlController.tabBarIndex.value == 0 ? true : false,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TabBarItem(
                itemName: 'In',
                isActive: tmtlController.tabBarIndex.value == 1 ? true : false,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TabBarItem(
                itemName: 'Out',
                isActive: tmtlController.tabBarIndex.value == 2 ? true : false,
              ),
            ),
          ],
        ),
      );

  Widget _buildTabBarView() => TabBarView(
        children: [
          _buildAllTMTLList(),
          _buildInTMTLList(),
          _buildOutTMTLList(),
        ],
      );

  Widget _buildAllTMTLList() => ListView.separated(
        itemCount: tmtlDataList.length,
        itemBuilder: (context, index) {
          return TMTLItemCard(tmtlData: tmtlDataList[index]);
        },
        separatorBuilder: (context, index) => addVerticalSpace(
          Dimensions.paddingSizeSmall,
        ),
      );

  Widget _buildInTMTLList() => ListView.separated(
        itemCount: tmtlDataList.length,
        itemBuilder: (context, index) {
          return tmtlDataList[index].status == TMTLStatus.In
              ? TMTLItemCard(tmtlData: tmtlDataList[index])
              : Container();
        },
        separatorBuilder: (context, index) => addVerticalSpace(
          Dimensions.paddingSizeSmall,
        ),
      );

  Widget _buildOutTMTLList() => ListView.separated(
        itemCount: tmtlDataList.length,
        itemBuilder: (context, index) {
          return tmtlDataList[index].status == TMTLStatus.Out
              ? TMTLItemCard(tmtlData: tmtlDataList[index])
              : Container();
        },
        separatorBuilder: (context, index) => addVerticalSpace(
          Dimensions.paddingSizeSmall,
        ),
      );
}
