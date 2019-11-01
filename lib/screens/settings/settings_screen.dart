import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/screens/FAQ/faq_screen.dart';
import 'package:appetizer/screens/settings/list_item.dart';
import 'package:appetizer/screens/settings/page_footer.dart';
import 'package:appetizer/screens/settings/user_details.dart';
import 'package:appetizer/services/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appetizer/resetPassword.dart';
import 'package:appetizer/alertDialog.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/help.dart';

import 'edit_profile.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences prefs;
  String shareText =
      "Let me recommend you this application:\n https://play.google.com/store/apps/details?id=co.sdslabs.mdg.appetizer&hl=en";
  String name, branch, hostel, room, email;
  String enr;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    SharedPreferences.getInstance().then((sharedPrefs) {
      prefs = sharedPrefs;
    });
  }

  Future getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    prefs = await SharedPreferences.getInstance();
    Me me = await userMeGet(prefs.getString("token"));

    setState(() {
      name = me.name;
      enr = me.enrNo.toString();
      branch = me.branch;
      hostel = me.hostelName;
      room = me.roomNo;
      email = me.email;
      isLoading = false;
    });
    print(name);
    print(enr.toString());
    print(branch);
    print(hostel);
    print(room);
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: const Color.fromRGBO(255, 193, 7, 1),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text(
              "Settings",
              style: new TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
            elevation: 0.0,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(121, 85, 72, 1)),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      GestureDetector(
                        child:
                            SettingsPageListItems(Icons.person, "Edit Profile"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()));
                        },
                      ),
                      GestureDetector(
                        child:
                            SettingsPageListItems(Icons.lock, "Reset Password"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword(
                                      token: prefs.getString("token"))));
                        },
                      ),
                      GestureDetector(
                        child: SettingsPageListItems(Icons.help, "FAQ"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FaqList(
                                      token: prefs.getString("token"))));
                        },
                      ),
                      GestureDetector(
                        child: SettingsPageListItems(Icons.info, "About"),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Help()));
                        },
                      ),
                      GestureDetector(
                        child: SettingsPageListItems(
                            Icons.share, "Share/Tell a friend"),
                        onTap: () {
                          final RenderBox box = context.findRenderObject();
                          Share.share(shareText,
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
                        },
                      ),
                      GestureDetector(
                        child:
                            SettingsPageListItems(Icons.exit_to_app, "Log Out"),
                        onTap: () async {
                          //Navigator.pop(context);
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
                                        SharedPreferences.getInstance()
                                            .then((prefs) {
                                          userMeGet(prefs.getString("token"))
                                              .then((me) async {
                                            fcm.unsubscribeFromTopic(
                                                "release-" + me.hostelCode);
                                            userLogout(
                                                prefs.getString("token"));
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    "/login",
                                                    (Route<dynamic> route) =>
                                                        false);
                                            prefs.clear();
                                            prefs.setBool("seen", true);
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
                      ),
                    ],
                  ),
                ),
                SettingsPageFooter(),
              ],
            ),
          ),
        ),
        Positioned(
          child: SvgPicture.asset(
            'assets/icons/IITRLogo.svg',
            height: 160.0,
            width: 160.0,
          ),
          left: 192.0,
          top: 30.0,
        ),
        (!isLoading)
            ? Positioned(
                child: UserDetails(name, enr, branch, hostel, room, email),
                top: 50.0,
                left: 0.0,
              )
            : Positioned(
                top: 50.0,
                left: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.35,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 30.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(appiYellow),
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
