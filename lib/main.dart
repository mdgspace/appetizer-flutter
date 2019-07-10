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
