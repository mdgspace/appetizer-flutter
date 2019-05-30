import 'package:flutter/material.dart';
import "colors.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primaryColor: appiBrown), home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomeState();
  }
}

class _MyHomeState extends State<Home> {
  String _username = "ABhishek";
  String _enrollment = "18114003";

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Mess Menu"),
      ),
      //body: null,// this is to be implemented


      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: appiBrown,
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
                            _username.toUpperCase(),
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
            ListTile(
              leading: Icon(
                Icons.feedback,
                color: appiYellow,
              ),
              title: Text("FeedBack"),
            ),
            ListTile(
              leading: Icon(
                Icons.do_not_disturb,
                color: appiYellow,
              ),
              title: Text("Leaves"),
            ),
            ListTile(
              leading: Icon(
                Icons.attach_money,
                color: appiYellow,
              ),
              title: Text("Rebates"),
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_none,
                color: appiYellow,
              ),
              title: Text("Notification History"),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: appiYellow,
              ),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline,
                color: appiYellow,
              ),
              title: Text("FAQ"),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: appiYellow,
              ),
              title: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
