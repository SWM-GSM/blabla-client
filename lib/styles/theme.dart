import 'package:blabla/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlaTheme {
  static final blaTheme = ThemeData(
      fontFamily: 'Pretendard',
      scaffoldBackgroundColor: BlaColor.white,
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.transparent),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: BlaColor.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      )));
}
