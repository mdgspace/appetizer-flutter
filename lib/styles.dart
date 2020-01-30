import 'package:flutter/material.dart';
import 'colors.dart';

final accentTextTheme = TextTheme(
  //used for authenticating button
  display1: new TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 19.0,
      color: Colors.white,
      fontFamily: "OpenSans"),
  //used for username in nav drawer
  display2: TextStyle(

    color: Colors.white,
    fontSize: 22,
  ),
  //used for enrolment no in nav drawer
  display3: TextStyle(
    color: appiYellow,
    fontSize: 15,
  ),
  title: TextStyle(
    fontWeight: FontWeight.bold,
    color: appiLightGreyText,
    fontSize: 16,
  ),
  subtitle: TextStyle(
    color: appiLightGreyText,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
);
final primaryTextTheme =  TextTheme(
  //display1 theme is used for the Login Button
  display1: new TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 22.0,
    color: appiYellow,
    fontFamily: "OpenSans",
  ),
  //display2 theme is used for the channel-I button
  display2: new TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 14.0,
      color: Colors.white,
      fontFamily: "OpenSans"),
  //display3 theme is used for the help and forgot password button
  display3: new TextStyle(
    fontSize: 15.0,
    color: appiYellow,
    decoration: TextDecoration.underline,
    fontFamily: "OpenSans",
  ),
  //display4 theme is used for the "showDash function"
  display4: new TextStyle(
    fontSize: 15.0,
    color: appiYellow,
    fontFamily: "OpenSans",
  ),
  //subhead theme is used for the Enrollment No and Password Input field
  subhead: new TextStyle(
    fontSize: 17.0,
    color: appiGreyIcon.withOpacity(0.8),
    fontFamily: "OpenSans",
  ),
  //headline used for forgot password title
  headline: new TextStyle(
    fontSize: 24.0,
    color: appiGreyIcon,
    fontFamily: "OpenSans",
  ),
  //caption used for sub-Text
  caption: new TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 16.0,
    color: appiYellow,
    fontFamily: "OpenSans",
  ),
);