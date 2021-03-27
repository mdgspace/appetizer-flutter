import 'package:flutter/material.dart';
import 'colors.dart';

final accentTextTheme = TextTheme(
  //used for authenticating button
  headline4: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 19.0,
      color: Colors.white,
      fontFamily: 'OpenSans'),
  //used for username in nav drawer
  headline3: TextStyle(
    color: Colors.white,
    fontSize: 22,
  ),
  //used for enrolment no in nav drawer
  headline2: TextStyle(
    color: appiYellow,
    fontSize: 15,
  ),
  headline6: TextStyle(
    fontWeight: FontWeight.bold,
    color: appiLightGreyText,
    fontSize: 12.5,
  ),
  subtitle2: TextStyle(
    color: appiLightGreyText,
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
  ),
);
final primaryTextTheme = TextTheme(
  //display1 theme is used for the Login Button
  headline4: TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 22.0,
    color: appiYellow,
    fontFamily: 'OpenSans',
  ),
  //display2 theme is used for the channel-I button
  headline3: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 14.0,
      color: Colors.white,
      fontFamily: 'OpenSans'),
  //display3 theme is used for the help and forgot password button
  headline2: TextStyle(
    fontSize: 15.0,
    color: appiYellow,
    decoration: TextDecoration.underline,
    fontFamily: 'OpenSans',
  ),
  //display4 theme is used for the "showDash function"
  headline1: TextStyle(
    fontSize: 15.0,
    color: appiYellow,
    fontFamily: 'OpenSans',
  ),
  //subhead theme is used for the Enrollment No and Password Input field
  subtitle1: TextStyle(
    fontSize: 17.0,
    color: appiGreyIcon.withOpacity(0.8),
    fontFamily: 'OpenSans',
  ),
  //headline used for forgot password title
  headline5: TextStyle(
    fontSize: 24.0,
    color: appiGreyIcon,
    fontFamily: 'OpenSans',
  ),
  //caption used for sub-Text
  caption: TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 16.0,
    color: appiYellow,
    fontFamily: 'OpenSans',
  ),
);
