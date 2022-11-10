import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recall/src/controllers/dashboard_controller.dart';
import 'package:recall/src/utils/color.dart';
import 'package:recall/src/utils/dimensions.dart';
import 'package:recall/src/utils/styles.dart';
import 'package:recall/src/views/base/k_badge.dart';
import 'package:recall/src/views/screens/home/home_screen.dart';
import 'package:recall/src/views/screens/tmtl/tmtl_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final DashboardController dashboardController = Get.put(DashboardController());

  final _screens = [
    const HomeScreen(),
    Container(),
    Container(),
  ];

  final _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      tooltip: 'Home',
    ),
    BottomNavigationBarItem(
      icon: KBadge(
        bgColor: kRed,
        top: 4,
        right: 4,
        child: Icon(Icons.notifications)
      ),
      label: 'Notification',
      tooltip: 'Notification',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_rounded),
      label: 'Profile',
      tooltip: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: _screens[dashboardController.currentIndex.value],
      bottomNavigationBar: _bottomNavigationBar(),
    ));
  }

  Widget _bottomNavigationBar(){
    final size = max(Get.height, Get.width);
    return Container(
      height: size * 0.1,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radiusLarge),
          topRight: Radius.circular(Dimensions.radiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: kBottomNavBarShadowColor,
            spreadRadius: 0,
            blurRadius: 37,
            offset: const Offset(0, -12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radiusLarge),
          topRight: Radius.circular(Dimensions.radiusLarge),
        ),
        child: BottomNavigationBar(
          currentIndex: dashboardController.currentIndex.value,
          fixedColor: kBlackLight,
          backgroundColor: kWhite,
          selectedLabelStyle: GoogleFonts.quicksand(
            textStyle: h5.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          unselectedLabelStyle: GoogleFonts.quicksand(
            textStyle: h5.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: dashboardController.changeIndex,
          items: _bottomNavBarItems,
        ),
      ),
    );
  }
}
