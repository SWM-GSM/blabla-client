import 'package:blabla/styles/colors.dart';
import 'package:flutter/material.dart';

class BlaTheme {
  static final blaTheme = ThemeData(
    fontFamily: 'Pretendard',
    scaffoldBackgroundColor: BlaColor.white,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent
  );
}