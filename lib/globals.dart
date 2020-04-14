import 'package:flutter/material.dart';

var menuScaffoldKey = new GlobalKey<ScaffoldState>();
var myLeavesScreenKey = new GlobalKey<ScaffoldState>();

bool isCheckedOut = false;

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
