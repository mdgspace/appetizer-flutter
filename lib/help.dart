import 'package:flutter/material.dart';
import 'colors.dart';
import 'strings.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: help(),
    );
  }
}

class help extends StatelessWidget {
  String version = "Version 1.6.2r";
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: appiBrown,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      iconTheme: IconThemeData(
        color: appiYellow,
      ),
      title: Text(
        "About Us",
        style: TextStyle(color: Colors.white),
      ),
      elevation: 0.0,
    );
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height / 2 -
                appBar.preferredSize.height -
                8),
            color: appiBrown,
            child: new Stack(
              children: <Widget>[
                Positioned(
                  child: Image(
                    image: AssetImage("assets/images/about_pattern.png"),
                    width: 280,
                  ),
                  right: 0,
                  bottom: 0,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Material(
                          child: Image(
                            image: AssetImage("assets/icons/appetizerlogo.png"),
                            width: 100,
                          ),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(22.0)),
                          clipBehavior: Clip.antiAlias,
                        ),
                      ),
                      Image(
                        image: AssetImage("assets/images/AppetizerText.png"),
                        width: 100,
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          version,
                          style: TextStyle(
                              color: Colors.white70, fontFamily: 'OpenSans'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Text(
                    "Developed by",
                    style: TextStyle(
                        color: appidarkgrey,
                        fontFamily: 'OpenSans',
                        fontStyle: FontStyle.italic,
                        fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/images/mdg.png'),
                      height: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      mdg_full,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                        color: appidarkgrey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Image(
                                image: AssetImage('assets/images/github.png'),
                                width: 48,
                              ),
                            ),
                            onTap: () => _launch_github_url(),
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Image(
                                image: AssetImage('assets/images/fb.png'),
                                width: 48,
                              ),
                            ),
                            onTap: () => _launch_fb_url(),
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Image(
                                image: AssetImage('assets/images/web.png'),
                                width: 48,
                              ),
                            ),
                            onTap: () => _launch_web_url(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _launch_fb_url() {
  launch('https://m.facebook.com/mdgiitr/');
}

void _launch_github_url() {
  launch('https://github.com/mdg-iitr/');
}

void _launch_web_url() {
  launch('http://mdg.iitr.ac.in');
}

