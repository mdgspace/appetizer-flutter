import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/ui/FAQ/faq_screen.dart';
import 'package:appetizer/ui/settings/list_item.dart';
import 'package:appetizer/ui/settings/page_footer.dart';
import 'package:appetizer/ui/settings/user_details.dart';
import 'package:appetizer/services/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appetizer/ui/password/reset_password.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/ui/help/help.dart';
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
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(121, 85, 72, 1),
        ),
        SafeArea(
          child: Container(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/icons/IITRLogo.svg',
              height: 160,
              width: 160,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (!isLoading)
                        ? Container(
                            alignment: Alignment.center,
                            child: UserDetails(
                                name, enr, branch, hostel, room, email),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height / 3.3,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 0.0, 16.0, 30.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      appiYellow),
                                ),
                              ),
                            ),
                      alignment: Alignment.center,
                          ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        //height: MediaQuery.of(context).size.height / 1.83,
                        child: ListView(
                          children: <Widget>[
                            GestureDetector(
                              child: SettingsPageListItems(
                                  Icons.person, "Edit Profile"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                              email: prefs.getString("email"),
                                              contactNo:
                                                  prefs.getString("contactNo"),
                                            )));
                              },
                            ),
                            GestureDetector(
                              child: SettingsPageListItems(
                                  Icons.lock, "Reset Password"),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Help()));
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
                              child: SettingsPageListItems(
                                  Icons.exit_to_app, "Log Out"),
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
                                  },
                                );
                              },
                            ),
                            SettingsPageFooter(),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
