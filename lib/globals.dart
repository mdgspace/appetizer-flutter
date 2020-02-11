import 'package:flutter/material.dart';

String playStoreLink =
    "https://play.google.com/store/apps/details?id=com.example.appetizer";

var menuScaffoldKey = new GlobalKey<ScaffoldState>();
bool isCheckedOut = false;
bool isCheckedLoading = false;

Duration outdatedTime = Duration(hours: 8);
