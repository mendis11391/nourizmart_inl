import 'package:flutter/material.dart';

class AppColors {
  AppColors._privateConstructor();
  static final AppColors _instance = AppColors._privateConstructor();
  factory AppColors() {
    return _instance;
  }

  static const MaterialColor appThemeColor = MaterialColor(
    0xFF05B862,
    <int, Color>{
      50: Color(0xFFE1F6EC),
      100: Color(0xFFB4EAD0),
      200: Color(0xFF82DCB1),
      300: Color(0xFF50CD91),
      400: Color(0xFF2BC37A),
      500: Color(0xFF05B862),
      600: Color(0xFF04B15A),
      700: Color(0xFF04A850),
      800: Color(0xFF03A046),
      900: Color(0xFF019134),
    },
  );

  static const Color appBgGray = Color(0xFFF6F6F6);
  static const Color editFillColor = Color(0xffF2F3F4);
  static const Color appDividerGray = Color(0xffCCCCCC);
}
