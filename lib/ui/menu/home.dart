import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/provider/current_date.dart';
import 'package:appetizer/services/connectivity_service.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/services/multimessing/switchable_hostels.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/ui/FAQ/faq_screen.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/components/horizontal_date_picker.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/menu/menu.dart';
import 'package:appetizer/ui/menu_screens/week_menu_screen.dart';
import 'package:appetizer/ui/my_leaves/my_leaves_screen.dart';
import 'package:appetizer/ui/my_rebates/my_rebates_screen.dart';
import 'package:appetizer/ui/notification_history/noti_history_screen.dart';
import 'package:appetizer/ui/user_feedback/user_feedback.dart';
import 'package:appetizer/utils/connectivity_status.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../settings/settings_screen.dart';

class Home extends StatefulWidget {
  final String token;

  const Home({Key key, this.token}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String version = "v1.5.6r";
  FirebaseMessaging _fcm = FirebaseMessaging();

  String selectedHostelName;

  List<String> switchableHostelsList = [];

  InheritedData inheritedData;
  YourMenuModel menuModel;

  @override
  void initState() {
    super.initState();

    firebaseCloudMessagingListeners();
    switchableHostelsList.add("Your Meals");
    switchableHostels(widget.token).then((hostelsList) {
      hostelsList.forEach((hostel) {
        switchableHostelsList.add(hostel[2].toString());
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Unable to fetch hostels");
    });
    userMeGet(widget.token).then((me) {
      setState(() {
        isCheckedOut = me.isCheckedOut;
      });
    });
  }

  void firebaseCloudMessagingListeners() {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
      menuModel = YourMenuModel(inheritedData.userDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return menuModel;
        }),
        ChangeNotifierProvider(create: (context) => CurrentDateModel()),
        StreamProvider<ConnectivityStatus>(
            create: (context) =>
                ConnectivityService().connectionStatusController.stream)
      ],
      child: Scaffold(
        floatingActionButton:
            !isCheckedOut ? _floatingActionButton(context) : null,
        key: menuScaffoldKey,
        appBar: _appBar(context),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  HorizontalDatePicker(token: widget.token),
                  Flexible(
                    child: SingleChildScrollView(
                      child: ChangeNotifierProvider(
                        create: (context) => OtherMenuModel(inheritedData.userDetails, hostelCodeMap[selectedHostelName]),
                        child: Menu(
                          token: widget.token,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: _drawer(context),
      ),
    );
  }

  Widget _floatingActionButton(context) => FloatingActionButton(
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
                  content:
                      new Text("Are you sure you would like to check out?"),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: new Text(
                        "CANCEL",
                        style: TextStyle(
                            color: appiYellow, fontWeight: FontWeight.bold),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    new FlatButton(
                      child: new Text(
                        "CHECK OUT",
                        style: TextStyle(
                            color: appiYellow, fontWeight: FontWeight.bold),
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
      );
  Widget _appBar(context) => AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black.withOpacity(0.25))),
          child: Theme(
            data: ThemeData(canvasColor: appiBrown),
            child: Center(
              child: DropdownButton<String>(
                underline: Container(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                value: selectedHostelName,
                hint: Text(
                  "Your Meals",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Lobster_Two'),
                ),
                items: switchableHostelsList.map((String hostelName) {
                  return DropdownMenuItem<String>(
                    value: hostelName,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 120,
                        child: Text(
                          hostelName,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'Lobster_Two',
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String _selectedHostelName) {
                  if (_selectedHostelName == "Your Meals") {
                    setState(() {
                      selectedHostelName = null;
                    });
                  } else {
                    setState(() {
                      selectedHostelName = _selectedHostelName;
                    });
                  }
                },
              ),
            ),
          ),
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
                        builder: (context) => ChangeNotifierProvider.value(
                            value: menuModel, child: WeekMenu())));
              },
            ),
          )
        ],
        backgroundColor: appiBrown,
        iconTheme: new IconThemeData(color: appiYellow),
      );
  Widget _drawer(context) => Drawer(
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
                              InheritedData.of(context).userDetails.username,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).accentTextTheme.display2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 4),
                            child: Text(
                              InheritedData.of(context).userDetails.enrNo,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).accentTextTheme.display3,
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
                                builder: (context) =>
                                    NotificationHistory(token: widget.token)));
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
                              builder: (BuildContext alertContext) {
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
                                        Navigator.pop(alertContext);
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
                                        Navigator.pop(alertContext);
                                        showCustomDialog(
                                            context, "Logging You Out");
                                        FirebaseMessaging fcm =
                                            FirebaseMessaging();
                                        userMeGet(widget.token)
                                            .then((me) async {
                                          fcm.unsubscribeFromTopic(
                                              "debug-" + me.hostelCode);
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
                                          prefs.setBool("seen", true);
                                        });
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
      );
}
