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
import 'package:recall/src/views/base/k_scroll_behavior.dart';
import 'package:recall/src/views/screens/tmtl/components/tabBar_item.dart';
import 'package:recall/src/views/screens/tmtl/components/tmtl_item_card.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';

class TMTLListScreen extends StatelessWidget {
  TMTLListScreen({Key? key}) : super(key: key);

  final TMTLController tmtlController = Get.put(TMTLController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// appBar content
            _buildTMTLAppBar(context),

            /// body content
            Expanded(child: _buildTMTLBody()),
          ],
        ),
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
        title: Text(
          'TMTL List',
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
                AssetPath.filterIconSvg,
                semanticsLabel: 'Filter Icon',
              ),
            ),
          ),
          addHorizontalSpace(2),
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

  Widget _buildTMTLBody() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// date and calender widget
          _buildDate(),

          /// give space
          addVerticalSpace(Dimensions.paddingSizeDefault),

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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDate() => Padding(
    padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today, 02 Octber 2022',
              textAlign: TextAlign.start,
              style: h4,
            ),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                AssetPath.calendarIconSvg,
                semanticsLabel: 'Calendar Icon',
              ),
            ),
          ],
        ),
  );

  Widget _buildTabBar() => Padding(
    padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
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
    itemBuilder: (context, index){
      return TMTLItemCard(tmtlData: tmtlDataList[index]);
    },
    separatorBuilder: (context, index) =>
        addVerticalSpace(Dimensions.paddingSizeSmall),
  );

  Widget _buildInTMTLList() => ListView.separated(
    itemCount: tmtlDataList.length,
    itemBuilder: (context, index){
      return tmtlDataList[index].status == TMTLStatus.In
          ? TMTLItemCard(tmtlData: tmtlDataList[index])
          : Container();
    },
    separatorBuilder: (context, index) =>
        addVerticalSpace(Dimensions.paddingSizeSmall),
  );

  Widget _buildOutTMTLList() => ListView.separated(
    itemCount: tmtlDataList.length,
    itemBuilder: (context, index){
      return tmtlDataList[index].status == TMTLStatus.Out
          ? TMTLItemCard(tmtlData: tmtlDataList[index])
          : Container();
    },
    separatorBuilder: (context, index) =>
        addVerticalSpace(Dimensions.paddingSizeSmall),
  );
}
