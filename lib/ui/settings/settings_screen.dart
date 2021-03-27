import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/FAQ/faq_view.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/settings/list_item.dart';
import 'package:appetizer/ui/settings/page_footer.dart';
import 'package:appetizer/ui/settings/user_details.dart';
import 'package:appetizer/viewmodels/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:appetizer/ui/password/reset_password.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/ui/help/help.dart';
import 'edit_profile.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings_view';

  final String shareText =
      'Let me recommend you this application:\n https://play.google.com/store/apps/details?id=co.sdslabs.mdg.appetizer&hl=en';

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(
        'Settings',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
    );

    return BaseView<SettingsViewModel>(
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
                'assets/icons/iitr_logo.svg',
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
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 30),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      appiYellow,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Builder(
                              builder: (context) {
                                var userDetails = model.userDetails;
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfile(),
                                    ),
                                  );
                                },
                                child: SettingsPageListItems(
                                    Icons.person, 'Edit Profile'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPassword(),
                                    ),
                                  );
                                },
                                child: SettingsPageListItems(
                                    Icons.lock, 'Reset Password'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FaqView(),
                                    ),
                                  );
                                },
                                child: SettingsPageListItems(Icons.help, 'FAQ'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Help(),
                                    ),
                                  );
                                },
                                child:
                                    SettingsPageListItems(Icons.info, 'About'),
                              ),
                              GestureDetector(
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
                                child: SettingsPageListItems(
                                    Icons.share, 'Share/Tell a friend'),
                              ),
                              GestureDetector(
                                onTap: model.onLogoutTap,
                                child: SettingsPageListItems(
                                  Icons.exit_to_app,
                                  'Log Out',
                                ),
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
