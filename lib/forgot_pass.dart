import 'package:flutter/material.dart';
import 'colors.dart';
import 'strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password',
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.light,
        primaryColor: appiBrown,
        accentColor: appiYellow,
      ),
      home: forgot_pass(),
    );
  }
}

class forgot_pass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return forgot_pass_state();
  }
}

class forgot_pass_state extends State<forgot_pass> {
  String _email = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppBar appBar = AppBar(
      backgroundColor: appiBrown,
      leading: Icon(Icons.arrow_back),
      iconTheme: IconThemeData(
        color: appiYellow,
      ),
      elevation: 0.0,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBar,
            Column(
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height) / 2 -
                      appBar.preferredSize.height,
                  width: MediaQuery.of(context).size.width,
                  color: appiBrown,
                  child: Row(
                    // image here

                    children: <Widget>[
                      Container(
                        height: (MediaQuery.of(context).size.height) / 2 -
                            appBar.preferredSize.height,
                        padding: const EdgeInsets.only(
                            bottom: 48, top: 8, right: 8, left: 8),
                        child: Image(
                          alignment: Alignment.bottomLeft,
                          image: AssetImage('assets/sppedy_paper.png'),
                          width: (MediaQuery.of(context).size.width / 2) - 16,
                        ),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height) / 2 -
                            appBar.preferredSize.height,
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          alignment: Alignment.topRight,
                          image: AssetImage('assets/mailbox.png'),
                          width: (MediaQuery.of(context).size.width / 2) - 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48, right: 48),
                  child: Text(
                    pass_instruction,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextFormField(
                    initialValue: _email,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.mail,
                        size: 36,
                        color: appiYellow,
                      ),
                      labelText: "Email address",
                      labelStyle: TextStyle(color: appiYellow),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: appiYellow, style: BorderStyle.solid),
                      ),
                    ),
                    cursorColor: appiYellow,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: OutlineButton(
                    borderSide: BorderSide(
                      color: appiYellow,
                      width: 2,
                    ),
                    splashColor: appiYellow,
                    child: ListTile(
                      title: Text(
                        "SEND INSTRUCTIONS",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: appiYellow),
                      ),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
