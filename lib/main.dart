import 'package:appetizer/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'login.dart';

void main() async {

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(MaterialApp(
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
        accentTextTheme: TextTheme(
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

        ),
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
          /// used for skip button in onBoarding screen
          skip: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color : appiYellow,
            fontFamily: "OpenSans"
          ),
          /// for heading in onBoarding Screen
          onBoardingInfoBold:new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans-Bold.ttf",
              fontSize: 20
          ),
          ///for description in onBoarding Screen
          onBoardingInfoLight: new TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "OpenSans-Light.ttf"
          ),
        ),
      ),
//      darkTheme: ThemeData(
//        brightness: Brightness.dark,
//      ),
      home: Appetizer(),
    ));
}

class Appetizer extends StatefulWidget {
  @override
  _AppetizerState createState() => _AppetizerState();
}

class _AppetizerState extends State<Appetizer> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String code;
  var sharedData;

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
    try{
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
