import 'package:appetizer/colors.dart';
import 'package:appetizer/enums/token_status.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/services/api/leave.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/api/version_check.dart';
import 'package:appetizer/ui/FAQ/faq_screen.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/date_picker/date_picker.dart';
import 'package:appetizer/ui/menu/other_menu.dart';
import 'package:appetizer/ui/menu/your_menu.dart';
import 'package:appetizer/ui/my_leaves/my_leaves_screen.dart';
import 'package:appetizer/ui/my_rebates/my_rebates_screen.dart';
import 'package:appetizer/ui/my_switches/my_switches_screen.dart';
import 'package:appetizer/ui/notification_history/noti_history_screen.dart';
import 'package:appetizer/ui/settings/settings_screen.dart';
import 'package:appetizer/ui/user_feedback/user_feedback.dart';
import 'package:appetizer/viewmodels/current_date_model.dart';
import 'package:appetizer/viewmodels/home_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  final String token;

  const Home({Key key, this.token}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String version = "2.0.0a";
  String playStoreLink;
  FirebaseMessaging _fcm = FirebaseMessaging();

  String selectedHostelName;

  List<String> switchableHostelsList;

  InheritedData inheritedData;
  CurrentDateModel currentDateModel;

  @override
  void initState() {
    super.initState();
    _checkVersionAndPlayStoreLink();

    firebaseCloudMessagingListeners();

    UserApi().checkTokenStatus().then((status) async {
      if (status == TokenStatus.INVALID_TOKEN) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        prefs.setBool("seen", true);
        Fluttertoast.showToast(msg: "Please login again.");
      }
    }).catchError((e) => print(e));

    switchableHostelsList = [];
    switchableHostelsList.add("Your Meals");
    MultimessingApi().switchableHostels().then((hostelsList) {
      print("HOSTELS LIST $hostelsList");
      hostelsList.forEach((hostel) {
        switchableHostelsList.add(hostel[2].toString());
      });
      setState(() {});
    }).catchError((e) {
      Fluttertoast.showToast(msg: "Unable to fetch hostels");
    });
    UserApi().userMeGet().then((me) {
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

  void _checkVersionAndPlayStoreLink() {
    RemoteConfig.instance.then((remoteConfig) async {
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      setState(() {
        version = remoteConfig.getString("appetizer_flutter_version");
        playStoreLink = remoteConfig.getString("appetizer_flutter_play_link");
      });
      VersionCheckApi().checkVersion(version).then((version) {
        if (version.isExpired) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext alertContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: new Text(
                    "Current Version Expired",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: new Text(
                    "Your Appetizer App is out of date. You need to update the app to continue!",
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(alertContext);
                      },
                      child: new Text(
                        "CANCEL",
                        style: TextStyle(
                          color: appiYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    new FlatButton(
                      child: new Text(
                        "UPDATE",
                        style: TextStyle(
                          color: appiYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(alertContext);
                        if (await canLaunch(playStoreLink)) {
                          await launch(playStoreLink);
                        } else {
                          throw 'Could not launch $playStoreLink';
                        }
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                  ],
                );
              });
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
      currentDateModel = CurrentDateModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, model, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => currentDateModel),
        ],
        child: Scaffold(
          floatingActionButton: !isCheckedOut ? _fab(context) : null,
          appBar: _appBar(context, model),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      child: DatePicker(
                        padding: 0,
                      ),
                    ),
                    isCheckedOut == null
                        ? Container()
                        : isCheckedOut
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                color: appiRed,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 4, 16, 4),
                                      child: Center(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "You are currently Checked-Out",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyLeaves(),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 4, 16, 4),
                                        child: Text(
                                          "CHECK-IN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                    Flexible(
                      child: GestureDetector(
                        onHorizontalDragEnd: (d) {
                          if (d.velocity.pixelsPerSecond.dx < -500) {
                            currentDateModel.setDateTime(
                                currentDateModel.dateTime
                                    .add(Duration(days: 1)),
                                context);
                          } else if (d.velocity.pixelsPerSecond.dx > 500) {
                            currentDateModel.setDateTime(
                                currentDateModel.dateTime
                                    .subtract(Duration(days: 1)),
                                context);
                          }
                        },
                        child: model.selectedHostel == "Your Meals"
                            ? YourMenu()
                            : OtherMenu(hostelName: model.selectedHostel),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          drawer: _drawer(context),
        ),
      ),
    );
  }

  Widget _appBar(context, HomeModel model) => AppBar(
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
                  "       Your Meals",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'Lobster_Two',
                  ),
                ),
                items: switchableHostelsList.map((String hostelName) {
                  return DropdownMenuItem<String>(
                    value: hostelName,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.47,
                        child: Text(
                          hostelName,
                          textAlign: TextAlign.center,
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
                  setState(() {
                    selectedHostelName = _selectedHostelName;
                  });
                  model.selectedHostel = _selectedHostelName;
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ChangeNotifierProvider.value(
                //             value: menuModel, child: WeekMenu())));
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
                              inheritedData.userDetails.username,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).accentTextTheme.display2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 4),
                            child: Text(
                              inheritedData.userDetails.enrNo,
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
                            builder: (context) => UserFeedback(),
                          ),
                        );
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
                            builder: (context) => MyLeaves(),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      child: ListTile(
                        leading: Image(
                          image: AssetImage("assets/icons/leaves@1x.png"),
                          width: 24,
                          height: 24,
                        ),
                        title: Text("Switches"),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MySwitches(),
                          ),
                        );
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
                            builder: (context) => MyRebates(),
                          ),
                        );
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
                            builder: (context) => NotificationHistory(),
                          ),
                        );
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
                            builder: (context) => Settings(),
                          ),
                        );
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
                            builder: (context) => FaqList(),
                          ),
                        );
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
                                        UserApi().userMeGet().then((me) async {
                                          fcm.unsubscribeFromTopic(
                                              "debug-" + me.hostelCode);
                                          UserApi().userLogout();
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

  Widget _fab(context) => FloatingActionButton(
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
                        LeaveApi().check().then((check) {
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
}
