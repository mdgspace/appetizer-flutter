import 'package:flutter/material.dart';
import "colors.dart";
import 'package:appetizer/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Home extends StatefulWidget {
  final String username;
  final String enrollment;

  const Home({Key key, this.username, this.enrollment}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String version = "v1.5.6r";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mess Menu",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontFamily: 'Lobster_Two'),
        ),
        backgroundColor: appiBrown,
        iconTheme: new IconThemeData(color: appiYellow),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 4),
                            child: Text(
                              widget.enrollment,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: appiYellow, fontSize: 16),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("Log Out"),
                                  content: new Text(
                                      "Are you sure you want to log out?"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text(
                                        "LOG OUT",
                                        style: TextStyle(color: appiYellow),
                                      ),
                                      onPressed: () {},
                                    ),
                                    new FlatButton(
                                        onPressed: () {},
                                        child: new Text(
                                          "CANCEL",
                                          style: TextStyle(color: appiYellow),
                                        ))
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
