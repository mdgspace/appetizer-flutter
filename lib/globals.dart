import 'package:appetizer/colors.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> loginViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> menuViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> myLeavesViewScaffoldKey =
    new GlobalKey<ScaffoldState>();

bool isCheckedOut = false;

Map<int, Color> primarySwatchColor = {
  50: appiYellow.withOpacity(0.1),
  100: appiYellow.withOpacity(0.2),
  200: appiYellow.withOpacity(0.3),
  300: appiYellow.withOpacity(0.4),
  400: appiYellow.withOpacity(0.5),
  500: appiYellow.withOpacity(0.6),
  600: appiYellow.withOpacity(0.7),
  700: appiYellow.withOpacity(0.8),
  800: appiYellow.withOpacity(0.9),
  900: appiYellow.withOpacity(1),
};

Duration outdatedTime = Duration(hours: 12);

//String url = "http://appetizer-mdg.herokuapp.com";
String url = "https://api.mess.vishwas.rocks";

void showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String _message) {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(_message),
    ),
  );
}
