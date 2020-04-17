import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/ui/FAQ/faq_screen.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/settings/list_item.dart';
import 'package:appetizer/ui/settings/page_footer.dart';
import 'package:appetizer/ui/settings/user_details.dart';
import 'package:appetizer/viewmodels/settings_models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:appetizer/ui/password/reset_password.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/ui/help/help.dart';
import 'edit_profile.dart';

class Settings extends StatelessWidget {
  final String shareText =
      "Let me recommend you this application:\n https://play.google.com/store/apps/details?id=co.sdslabs.mdg.appetizer&hl=en";

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(
        "Settings",
        style: new TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
    );

    return BaseView<SettingsModel>(
      onModelReady: (model) => model.getUserDetails(),
      builder: (context, model, child) => Stack(
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
            appBar: appBar,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (model.state == ViewState.Busy)
                          ? Container(
                              height: MediaQuery.of(context).size.height / 2 -
                                  appBar.preferredSize.height,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 30),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                      appiYellow,
                                    ),
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                            )
                          : Builder(
                              builder: (context) {
                                Me userDetails = model.userDetails;
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2 -
                                          appBar.preferredSize.height,
                                  alignment: Alignment.center,
                                  child: UserDetails(
                                    userDetails.name,
                                    userDetails.enrNo.toString(),
                                    userDetails.branch,
                                    userDetails.hostelName,
                                    userDetails.roomNo,
                                    userDetails.email,
                                  ),
                                );
                              },
                            ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: ListView(
                            children: <Widget>[
                              GestureDetector(
                                child: SettingsPageListItems(
                                    Icons.person, "Edit Profile"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfile(),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: SettingsPageListItems(
                                    Icons.lock, "Reset Password"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPassword(),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: SettingsPageListItems(Icons.help, "FAQ"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FaqList(),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                child:
                                    SettingsPageListItems(Icons.info, "About"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Help(),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                child: SettingsPageListItems(
                                    Icons.share, "Share/Tell a friend"),
                                onTap: () {
                                  final RenderBox box =
                                      context.findRenderObject();
                                  Share.share(
                                    shareText,
                                    sharePositionOrigin:
                                        box.localToGlobal(Offset.zero) &
                                            box.size,
                                  );
                                },
                              ),
                              GestureDetector(
                                child: SettingsPageListItems(
                                  Icons.exit_to_app,
                                  "Log Out",
                                ),
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext alertContext) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
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
                                              model.logout();
                                            },
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
      ),
    );
  }
}
