import 'package:flutter/widgets.dart';

bool isDarkModeEnable = false;
bool isRTL = false;
List<String?> rtlLanguageCodeLList = ['ar', 'arc', 'ckb', 'dv', 'fa', 'ha', 'he', 'khw', 'ks', 'ps', 'ur', 'uz_AF', 'yi'];
String? languageCode;

List<Color> gradientColors = [
  isDarkModeEnable ? Color(0xFF862254) : Color(0xFFFA457E),
  isDarkModeEnable ? Color(0xFF483585) : Color(0xFF7B49FF),
];

List<Color> scaffoldBackgroundGradientColors = [
  Color(0xFF03000C),
  Color(0xFF292343),
];
