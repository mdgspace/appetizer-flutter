import 'package:appetizer/Home.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'colors.dart';
import 'login.dart';

void main() => runApp(MaterialApp(
      routes: {
        "/home": (context) => Home(),
        "/login": (context) => Login(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Appetizer',
      theme: ThemeData(
          primaryColor: appiYellow,
          accentColor: appiGrey,
          cursorColor: appiYellow),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Appetizer(),
    ));

class Appetizer extends StatefulWidget {
  @override
  _AppetizerState createState() => _AppetizerState();
}

class _AppetizerState extends State<Appetizer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
    );
  }

//  Widget getBody() {
//    Widget firstScreen;
//    getUserDetails().then((details) {
//      firstScreen = (details.getString("token") != null)
//          ? Home(
//              username: details.getString("username"),
//              enrollment: details.getString("enrNo"),
//              token: details.getString("token"),
//            )
//          : Login();
//    });
//    return firstScreen;
//  }
}
