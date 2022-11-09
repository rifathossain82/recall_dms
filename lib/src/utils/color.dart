import 'package:flutter/material.dart';

Color kWhite = Colors.white;
Color kBlack = Colors.black;
Color kBlackLight = const Color(0xFF303030);
Color kBlackMedium = const Color(0xFF404040);
Color kGrey = const Color(0xFF9EA1B6);
Color kGreyLight = const Color(0xFF090F47).withOpacity(0.45);
Color kGreyMedium= const Color(0xFFC4C4C4);
Color kGreyDeep1 = const Color(0xFF808080);
Color kGreyDeep2 = const Color(0xFF707070);

Color mainColor = const Color(0xFFC89C34);

Color successColor = Colors.green;
Color failedColor = Colors.red;
Color warningColor = Colors.orange;



Color kLightBgColor = Colors.white;
Color? kDarkBgColor = Colors.blueGrey[900];






Map<int, Color> color =
  const {
    50:Color.fromRGBO(200, 156, 52, .1),
    100:Color.fromRGBO(200, 156, 52, .2),
    200:Color.fromRGBO(200, 156, 52, .3),
    300:Color.fromRGBO(200, 156, 52, .4),
    400:Color.fromRGBO(200, 156, 52, .5),
    500:Color.fromRGBO(200, 156, 52, .6),
    600:Color.fromRGBO(200, 156, 52, .7),
    700:Color.fromRGBO(200, 156, 52, .8),
    800:Color.fromRGBO(200, 156, 52, .9),
    900:Color.fromRGBO(200, 156, 52, 1),
  };

MaterialColor kLightPrimarySwatchColor = MaterialColor(0xFFC89C34, color);
