import 'package:flutter/material.dart';
import '../../colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatelessWidget {
  static const String id = 'help_view';

  final String version = 'Version 1.6.2r';

  final AppBar _appBar = AppBar(
    title: Text(
      'About Us',
      style: TextStyle(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height / 2 -
                _appBar.preferredSize.height -
                8),
            color: appiBrown,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image(
                    image: AssetImage('assets/images/about_pattern.png'),
                    width: 280,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Material(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          clipBehavior: Clip.antiAlias,
                          child: Image(
                            image:
                                AssetImage('assets/icons/appetizer_logo.png'),
                            width: 100,
                          ),
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/appetizer_text.png'),
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
                    'Developed by',
                    style: TextStyle(
                      color: appiGreyIcon.withOpacity(0.9),
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
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
                      'Mobile Development Group, IIT Roorkee',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14,
                        color: appiGreyIcon.withOpacity(0.9),
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
                            onTap: () => launchGithubUrl(),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Image(
                                image: AssetImage('assets/images/github.png'),
                                width: 48,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => launchFbUrl(),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Image(
                                image: AssetImage('assets/images/fb.png'),
                                width: 48,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => launchWebUrl(),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Image(
                                image: AssetImage('assets/images/web.png'),
                                width: 48,
                              ),
                            ),
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

void launchFbUrl() {
  launch('https://m.facebook.com/mdgiitr/');
}

void launchGithubUrl() {
  launch('https://github.com/mdg-iitr/');
}

void launchWebUrl() {
  launch('http://mdg.iitr.ac.in');
}
