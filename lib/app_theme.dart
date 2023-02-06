import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Text Styles
  static TextStyle headline1 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: blackPrimary,
    fontFamily: 'OpenSans',
  );
  static TextStyle headline2 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: blackPrimary,
    fontFamily: 'OpenSans',
  );
  static TextStyle headline3 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: blackPrimary,
    fontFamily: 'OpenSans',
  );
  static TextStyle headline4 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: blackPrimary,
    fontFamily: 'OpenSans',
  );
  static TextStyle headline5 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: blackPrimary,
    fontFamily: 'OpenSans',
  );
  static TextStyle headline6 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: blackPrimary,
    fontFamily: 'OpenSans',
  );
  static TextStyle subtitle1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: blackSecondary,
    fontFamily: 'OpenSans',
  );
  static TextStyle subtitle2 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: blackSecondary,
    fontFamily: 'OpenSans',
  );
  static TextStyle bodyText1 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: blackSecondary,
    fontFamily: 'OpenSans',
  );
  static TextStyle bodyText2 = TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.w400,
    color: blackSecondary,
    fontFamily: 'OpenSans',
  );
  static TextStyle bodyText3 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: blackSecondary,
    fontFamily: 'OpenSans',
  );
  static TextStyle overline = TextStyle(
    fontSize: 6.sp,
    fontWeight: FontWeight.w400,
    color: blackSecondary,
    fontFamily: 'OpenSans',
  );
  static TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: primary,
    fontFamily: 'OpenSans',
  );

  // Colors
  static const Color primary = Color(0xFFFFC107);
  static const Color secondary = Color(0xFF795548);
  static const Color tertiary = Color(0xFFA16938);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFEB5757);
  static const Color blue = Color(0xFF2196F3);
  static const Color yellow = Color(0xffF6BA18);
  static const Color green = Color(0xFF2ACC00);
  static const Color grey = Color(0xFFD2D2D2);
  static const Color lightGrey = Color(0xFFECECEC);
  static const Color blackPrimary = Color(0xFF3E3E3E);
  static const Color blackSecondary = Color(0xFF636363);
  static const Color blackTertiary = Color(0xFFAEAEAE);
  static const Color shadow = Color(0x408E8E8E);
}
