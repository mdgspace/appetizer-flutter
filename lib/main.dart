import 'package:appetizer/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        cursorColor: appiYellow,
        primaryTextTheme: TextTheme(
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
        ),
      ),
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
  static const platform = const MethodChannel('app.channel.shared.data');
  String code;

  void initState() {
    getIntent();
    navigate();
    super.initState();
  }

  void navigate() {
    getUserDetails().then((details) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => (details.getString("token") != null)
                  ? Home(
                      username: details.getString("username"),
                      enrollment: details.getString("enrNo"),
                      token: details.getString("token"),
                    )
                  : Login(code: code)));
    });
  }

  getIntent() async {
    var sharedData = await platform.invokeMethod("getCode");
    if (sharedData != null) {
      code = sharedData;
    }
    print("Code " + code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(),
    );
  }
}
