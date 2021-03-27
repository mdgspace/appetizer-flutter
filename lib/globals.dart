import 'package:appetizer/colors.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> loginViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> menuViewScaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> myLeavesViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> faqViewScaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> newFeedbackViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> userFeedbackViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> leavesHistoryViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> homeViewScaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> myRebatesViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> rebatesHistoryViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> notificationHistoryViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> settingsViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> editProfileViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> resetPasswordViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> chooseNewPasswordViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> forgotPasswordViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> confirmSwitchPopupViewScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> switchableMealsViewScaffoldKey =
    GlobalKey<ScaffoldState>();

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

String url = 'http://appetizer-mdg.herokuapp.com';

void showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String _message) {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(_message),
    ),
  );
}
