import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Text Styles
  static TextStyle headline1 = TextStyle(
    color: const Color(0xFFF6F6F6),
    fontSize: 24.toAutoScaledFont,
    fontFamily: 'NotoSans',
    fontWeight: FontWeight.w700,
  );
  static TextStyle headline2 = TextStyle(
    color: const Color(0xFF1E1E1E),
    fontSize: 12.toAutoScaledFont,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w700,
  );
  static TextStyle headline3 = TextStyle(
    color: const Color(0xFF111111),
    fontSize: 18.toAutoScaledFont,
    fontFamily: 'Noto Sans',
    fontWeight: FontWeight.w500,
  );
  static TextStyle subtitle1 = TextStyle(
    color: Colors.white,
    fontSize: 20.toAutoScaledFont,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w600,
  );
  static TextStyle bodyText1 = TextStyle(
    color: const Color(0xFF2E2E2E),
    fontSize: 12.toAutoScaledFont,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    height: 1.32,
  );
  static TextStyle bodyText2 = TextStyle(
    color: const Color(0xFF2E2E2E),
    fontSize: 10.toAutoScaledFont,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    height: 1.09,
  );
  static TextStyle button = TextStyle(
    color: const Color(0xFFF6F6F6),
    fontSize: 12.toAutoScaledFont,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w700,
    height: 1.50,
  );

  // Colors
  //new colors
  static const Color black2e = Color(0xFF2E2E2E);
  static const Color black1e = Color(0xFF1E1E1E);
  static const Color black11 = Color(0xFF111111);
  static const Color customWhite = Color(0xFFF6F6F6);
  static const Color transparentWhite = Color(0x00FFFFFF);
  static const Color primary = Color(0xFFFFCB74);
  static const Color shadow = Color(0x99FFDDDD);
  static const Color grey2f = Color(0xFF2F2F2F);
  static const Color grey2e = Color(0xCC2E2E2E);
  static const Color toggleOff = Color(0xFFB9B9B9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color rulerColor = Color(0xFFE4E4E4);
  static const Color shadowColor = Color(0x19000000);
  static const Color customRed = Color(0xFF9F1F1F);
  // These are the old colors only, need to be set afterwards
  static const Color secondary = Color(0xFF795548);
  static const Color tertiary = Color(0xFFA16938);
  static const Color red = Color(0xFFEB5757);
  static const Color blue = Color(0xFF2196F3);
  static const Color yellow = Color(0xffF6BA18);
  static const Color green = Color(0xFF2ACC00);
  static const Color grey = Color(0xFFD2D2D2);
  static const Color lightGrey = Color(0xFFECECEC);
  static const Color blackPrimary = Color(0xFF3E3E3E);
  static const Color blackSecondary = Color(0xFF636363);
  static const Color blackTertiary = Color(0xFFAEAEAE);
}
