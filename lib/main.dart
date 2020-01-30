import 'package:appetizer/styles.dart';
import 'package:appetizer/ui/menu/home.dart';
import 'package:appetizer/utils/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_notifiers/menu_model.dart';

import 'colors.dart';
import 'ui/login/login.dart';
import 'ui/on_boarding/onBoarding.dart';

void main() async {
  //await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ChangeNotifierProvider(
    builder: (context) => MenuModel(),
    child: MaterialApp(
      routes: {
        "/home": (context) => Home(),
        "/login": (context) => Login(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Appetizer',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: appiYellow,
        accentColor: appiGrey,
        cursorColor: appiYellow,
        accentTextTheme: accentTextTheme,
        primaryTextTheme: primaryTextTheme,
      ),
      home: Appetizer(),
    ),
  ));
}

// TODO: Appetizer Widget MUST NOT exist
// TODO: (Improvement) OnBoarding implementation very naive, adds overhead on app start
// TODO: (Improvement) getIntent() method looks naive

class Appetizer extends StatefulWidget {
  @override
  _AppetizerState createState() => _AppetizerState();
}

class _AppetizerState extends State<Appetizer> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String code;
  var sharedData;

  Future checkFirstScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      navigate();
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnBoarding()));
    }
  }

  void initState() {
    getIntent();
    checkFirstScreen();
    super.initState();
  }

  void navigate() {
    UserDetailsUtils.getUserDetails().then((details) {
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
    try {
      sharedData = await platform.invokeMethod("getCode");
    } on Exception catch (e) {
      print(e);
    }
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
