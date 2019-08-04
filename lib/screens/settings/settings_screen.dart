import 'package:appetizer/screens/settings/list_item.dart';
import 'package:appetizer/screens/settings/page_footer.dart';
import 'package:appetizer/screens/settings/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            leading: IconButton(icon:Icon(Icons.arrow_back),
              color: const Color.fromRGBO(255, 193, 7, 1),
              onPressed:() => Navigator.pop(context, false),
            ),
            title: Text("Settings"),
            backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
            elevation: 0.0,
          ),
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 320.0,
                  width: 412.0,
                  color: const Color.fromRGBO(121, 85, 72, 1)
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SettingsPageListItems(
                        Icons.person,
                        "Account"
                    ),
                    SettingsPageListItems(
                        Icons.lock,
                        "Reset Password"
                    ),
                    SettingsPageListItems(
                        Icons.help,
                        "FAQ"
                    ),
                    SettingsPageListItems(
                        Icons.info,
                        "About"
                    ),
                    SettingsPageListItems(
                        Icons.share,
                        "Share/Tell a friend"
                    ),
                    SettingsPageListItems(
                        Icons.exit_to_app,
                        "Log Out"
                    ),
                  ],
                ),
              ),
              SettingsPageFooter(),
            ],
          ),
        ),
        Positioned(
          child:
          SvgPicture.asset(
            'assets/icons/IITRLogo.svg',
            height: 160.0,
            width: 160.0,
          ),
          left: 192.0,
          top: 30.0,
        ),
        Positioned(
          child: UserDetails("Big Daddy", 18113088, "Computer Science",
              "Rajiv", "CF-146", "bdaddy@cs.iitr.ac.in"),
          top: 85.0,
          left: 5.0,
        )
      ],
    );
}
