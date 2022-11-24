import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recall/src/controllers/tmtl_controller.dart';
import 'package:recall/src/models/tmtl_data.dart';
import 'package:recall/src/utils/asset_path.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/helper.dart';
import 'package:recall/src/views/base/k_appbar.dart';
import 'package:recall/src/views/base/k_date.dart';
import 'package:recall/src/views/base/k_text_field.dart';
import 'package:recall/src/views/base/no_data_found.dart';
import 'package:recall/src/views/screens/tmtl/components/tabBar_item.dart';
import 'package:recall/src/views/screens/tmtl/components/tmtl_item_card.dart';
import 'package:recall/src/services/extensions/build_context_extension.dart';

class TMTLListScreen extends StatelessWidget {
  TMTLListScreen({Key? key}) : super(key: key);

  final TMTLController tmtlController = Get.put(TMTLController());
  TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

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

  Widget _buildTMTLAppBar(BuildContext context) {
    if (tmtlController.isClickListScreenSearch.value) {
      searchFocusNode.requestFocus();
    }
    return KAppBar(
      leading: GestureDetector(
        onTap: () {
          Get.delete<TMTLController>();
          searchController.clear();
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
      title: tmtlController.isClickListScreenSearch.value
          ? KTextFiled(
              controller: searchController,
              focusNode: searchFocusNode,
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
          onTap: tmtlController.changeListScreenSearchStatus,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: tmtlController.isClickListScreenSearch.value
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
      tmtlController.getTMTLList(date: '${picked.month}/${picked.day}/${picked.year}');
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

  Widget _buildAllTMTLList() {
    return tmtlController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : tmtlController.tmtlList.isEmpty
            ? const NoDataFound()
            : ListView.separated(
                shrinkWrap: true,
                itemCount: tmtlController.tmtlList.length,
                itemBuilder: (context, index) {
                  return TMTLItemCard(
                    tmtlData: tmtlController.tmtlList[index],
                  );
                },
                separatorBuilder: (context, index) => addVerticalSpace(
                  Dimensions.paddingSizeSmall,
                ),
              );
  }

  Widget _buildInTMTLList() {
    if(tmtlController.isLoading.value){
      return const Center(child: CircularProgressIndicator());
    } else if(tmtlController.tmtlList.isEmpty){
      return const NoDataFound();
    } else{
      final List<TMTLData> tmtlInDataList = [];
      for (TMTLData value in tmtlController.tmtlList) {
        if (value.type == TMTLType.IN.name) {
          tmtlInDataList.add(value);
        }
      }

      return ListView.separated(
        shrinkWrap: true,
        itemCount: tmtlInDataList.length,
        itemBuilder: (context, index) {
          return TMTLItemCard(
            tmtlData: tmtlInDataList[index],
          );
        },
        separatorBuilder: (context, index) => addVerticalSpace(
          Dimensions.paddingSizeSmall,
        ),
      );
    }
  }

  Widget _buildOutTMTLList() {
    if(tmtlController.isLoading.value){
      return const Center(child: CircularProgressIndicator());
    } else if(tmtlController.tmtlList.isEmpty){
      return const NoDataFound();
    } else{
      final List<TMTLData> tmtlOutDataList = [];
      for (TMTLData value in tmtlController.tmtlList) {
        if (value.type == TMTLType.OUT.name) {
          tmtlOutDataList.add(value);
        }
      }

      return ListView.separated(
        shrinkWrap: true,
        itemCount: tmtlOutDataList.length,
        itemBuilder: (context, index) {
          return TMTLItemCard(
            tmtlData: tmtlOutDataList[index],
          );
        },
        separatorBuilder: (context, index) => addVerticalSpace(
          Dimensions.paddingSizeSmall,
        ),
      );
    }
  }
}
