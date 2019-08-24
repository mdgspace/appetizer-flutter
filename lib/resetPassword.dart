import 'package:flutter/material.dart';
import 'colors.dart';
import 'strings.dart';



class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AppBar appBar = AppBar(
    backgroundColor: appiBrown,
    leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
    iconTheme: IconThemeData(
      color: appiYellow,
    ),
    elevation: 0.0,
  );
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  alignment: Alignment.centerRight,
                  child: Image(
                    alignment: Alignment.centerRight,
                    image: AssetImage('assets/images/reset_password.png'),
                    width: (MediaQuery.of(context).size.width)*0.8,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Reset Password",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48, right: 48),
                  child: Text(
                    forgotInstruction,
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: appiGreyIcon.withOpacity(0.9),
                      fontFamily: "OpenSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: new TextFormField(
                    maxLines: 1,
                    obscureText: _obscureText,
                    autofocus: false,
                    decoration: new InputDecoration(
                      suffixIcon: GestureDetector(
                        child: new Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: appiGreyIcon,
                        ),
                        onTap: _toggle,
                      ),
                      labelText: "Old Password",
                      labelStyle: Theme.of(context).primaryTextTheme.subhead,
                      icon: new Icon(
                        Icons.lock,
                        color: appiGreyIcon,
                        size: 39,
                      ),
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Password can\'t be empty' : null,
                    onSaved: (value) => Null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: new TextFormField(
                    maxLines: 1,
                    obscureText: _obscureText,
                    autofocus: false,
                    decoration: new InputDecoration(
                      suffixIcon: GestureDetector(
                        child: new Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: appiGreyIcon,
                        ),
                        onTap: _toggle,
                      ),
                      labelText: "New Password",
                      labelStyle: Theme.of(context).primaryTextTheme.subhead,
                      icon: new Icon(
                        Icons.lock,
                        color: appiGreyIcon,
                        size: 39,
                      ),
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Password can\'t be empty' : null,
                    onSaved: (value) => Null,
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
                        "RESET PASSWORD",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).primaryTextTheme.caption,
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
