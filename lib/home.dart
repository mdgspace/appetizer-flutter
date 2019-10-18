import 'package:appetizer/services/leave.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:appetizer/currentDateModel.dart';
import 'package:appetizer/screens/user_feedback/user_feedback.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/utils/horizontal_date_picker.dart';
import 'package:appetizer/menu.dart';
import 'package:appetizer/screens/my_leaves/my_leaves_screen.dart';
import 'package:appetizer/screens/my_rebates/my_rebates_screen.dart';
import 'package:appetizer/screens/notification_history/noti_history_screen.dart';
import 'package:appetizer/alertDialog.dart';
import 'package:appetizer/screens/FAQ/faq_screen.dart';
import 'package:appetizer/globals.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/settings/settings_screen.dart';
import 'package:appetizer/screens/menu_screens/week_menu_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: appiPrimary,
          accentColor: appiAccent,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  final String username;
  final String enrollment;
  final String token;

  const Home({Key key, this.username, this.enrollment, this.token})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String version = "v1.5.6r";
  FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    userMeGet(widget.token).then((me) {
      setState(() {
        isCheckedOut = me.isCheckedOut;
      });
    });
  }

  void firebaseCloudMessagingListeners() {
    _fcm.getToken().then((token) {
      print(token);
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => CurrentDateModel(),
      child: Scaffold(
        floatingActionButton: !isCheckedOut
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          title: new Text(
                            "Check Out",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: new Text(
                              "Are you sure you would like to check out?"),
                          actions: <Widget>[
                            new FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: new Text(
                                "CANCEL",
                                style: TextStyle(
                                    color: appiYellow,
                                    fontWeight: FontWeight.bold),
                              ),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                            new FlatButton(
                              child: new Text(
                                "CHECK OUT",
                                style: TextStyle(
                                    color: appiYellow,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                                check(widget.token).then((check) {
                                  setState(() {
                                    isCheckedOut = check.isCheckedOut;
                                  });
                                });
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                          ],
                        );
                      });
                },
                backgroundColor: appiYellowLogo,
                child: Image.asset(
                  "assets/images/checkOut.png",
                  height: 25,
                  width: 25,
                ),
              )
            : null,
        key: menuScaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Mess Menu",
            style: new TextStyle(
                color: Colors.white, fontSize: 25.0, fontFamily: 'Lobster_Two'),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: GestureDetector(
                child: Container(
                  height: 23,
                  width: 23,
                  child: Image.asset("assets/icons/week_menu.png"),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeekMenu(widget.token)));
                },
              ),
            )
          ],
          backgroundColor: appiBrown,
          iconTheme: new IconThemeData(color: appiYellow),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  HorizontalDatePicker(token: widget.token),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Menu(
                        token: widget.token,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: appiBrown,
                  image: new DecorationImage(
                    alignment: Alignment.topRight,
                    image: AssetImage('assets/images/iit roorkee 1.png'),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 14.0),
                      child: Icon(
                        Icons.account_circle,
                        size: 80,
                        color: appiYellow,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 16, left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                widget.username,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).accentTextTheme.display2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 4),
                              child: Text(
                                widget.enrollment,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).accentTextTheme.display3,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: ListTile(
                          leading: Image(
                            image: AssetImage("assets/icons/feedback.png"),
                            width: 24,
                            height: 24,
                          ),
                          title: Text("FeedBack"),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserFeedback()));
                        },
                      ),
                      GestureDetector(
                        child: ListTile(
                          leading: Image(
                            image: AssetImage("assets/icons/leaves@1x.png"),
                            width: 24,
                            height: 24,
                          ),
                          title: Text("Leaves"),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyLeaves(
                                        token: widget.token,
                                      )));
                        },
                      ),
                      GestureDetector(
                        child: ListTile(
                          leading: Icon(
                            Icons.attach_money,
                            color: appiYellow,
                            size: 24,
                          ),
                          title: Text("Rebates"),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyRebates(
                                        token: widget.token,
                                      )));
                        },
                      ),
                      GestureDetector(
                        child: ListTile(
                          leading: Image(
                            image: AssetImage("assets/icons/notification.png"),
                            width: 24,
                            height: 24,
                          ),
                          title: Text("Notification History"),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationHistory(
                                      token: widget.token)));
                        },
                      ),
                      GestureDetector(
                        child: ListTile(
                          leading: Image(
                            image: AssetImage("assets/icons/setting.png"),
                            width: 24,
                            height: 24,
                          ),
                          title: Text("Settings"),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                        },
                      ),
                      GestureDetector(
                        child: ListTile(
                          leading: Icon(
                            Icons.help_outline,
                            color: appiYellow,
                            size: 24,
                          ),
                          title: Text("FAQ"),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FaqList(token: widget.token)));
                        },
                      ),
                      GestureDetector(
                        child: ListTile(
                          leading: Icon(
                            Icons.exit_to_app,
                            color: appiYellow,
                            size: 24,
                          ),
                          title: Text("Log Out"),
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    title: new Text(
                                      "Log Out",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: new Text(
                                        "Are you sure you want to log out?"),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: new Text(
                                          "CANCEL",
                                          style: TextStyle(
                                              color: appiYellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                      ),
                                      new FlatButton(
                                        child: new Text(
                                          "LOG OUT",
                                          style: TextStyle(
                                              color: appiYellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () async {
                                          showCustomDialog(
                                              context, "Logging You Out");
                                          userLogout(widget.token);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  "/login",
                                                  (Route<dynamic> route) =>
                                                      false);
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.clear();
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      version,
                      style: TextStyle(
                        fontSize: 12,
                        color: appiGreyIcon,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Made with ",
                          style: TextStyle(
                            fontSize: 12,
                            color: appiGreyIcon,
                          ),
                        ),
                        Icon(
                          Icons.favorite,
                          color: appiRed,
                          size: 12,
                        ),
                        Text(
                          " by MDG",
                          style: TextStyle(
                            fontSize: 12,
                            color: appiGreyIcon,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
