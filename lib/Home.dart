import 'package:flutter/material.dart';
import "colors.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _username = "Abhishek";
  String _enrollment = "18114003";
  String version = "v1.5.6r";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mess Menu"),
      ),
      //body: null,// this is to be implemented

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
                  Container(
                    padding: EdgeInsets.only(bottom: 16, left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _username,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: Text(
                            _enrollment,
                            style: TextStyle(color: appiYellow, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image(
                        image: AssetImage("assets/icons/feedback.png"),
                        width: 24,
                        height: 24,
                      ),
                      title: Text("FeedBack"),
                    ),
                    ListTile(
                      leading: Image(
                        image: AssetImage("assets/icons/leaves@1x.png"),
                        width: 24,
                        height: 24,
                      ),
                      title: Text("Leaves"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.attach_money,
                        color: appiYellow,
                        size: 24,
                      ),
                      title: Text("Rebates"),
                    ),
                    ListTile(
                      leading: Image(
                        image: AssetImage("assets/icons/notification.png"),
                        width: 24,
                        height: 24,
                      ),
                      title: Text("Notification History"),
                    ),
                    ListTile(
                      leading: Image(
                        image: AssetImage("assets/icons/setting.png"),
                        width: 24,
                        height: 24,
                      ),
                      title: Text("Settings"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help_outline,
                        color: appiYellow,
                        size: 24,
                      ),
                      title: Text("FAQ"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: appiYellow,
                        size: 24,
                      ),
                      title: Text("Log Out"),
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
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Made with ",
                        style: TextStyle(fontSize: 12),
                      ),
                      Icon(
                        Icons.favorite,
                        color: appiRed,
                        size: 12,
                      ),
                      Text(
                        " by MDG",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
