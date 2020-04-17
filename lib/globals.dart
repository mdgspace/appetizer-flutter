import 'package:appetizer/colors.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> loginViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> menuViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> myLeavesViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> faqViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> newFeedbackViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> userFeedbackViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> leavesHistoryViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> homeViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> myRebatesViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> rebatesHistoryViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> notificationHistoryViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> settingsViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> editProfileViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> resetPasswordViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> chooseNewPasswordViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> forgotPasswordViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> confirmSwitchPopupViewScaffoldKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> switchableMealsViewScaffoldKey =
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
