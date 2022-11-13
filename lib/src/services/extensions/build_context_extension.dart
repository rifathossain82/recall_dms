import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

extension BuildContextExtension on BuildContext{
  Future pushNewScreen(Widget screen) => PersistentNavBarNavigator.pushNewScreen(
    this,
    screen: screen,
    withNavBar: true,
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
  );

  popScreen() => Navigator.of(this).pop();
}