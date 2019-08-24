import 'package:flutter/material.dart';
import 'colors.dart';
import 'strings.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: appiBrown,
      leading: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
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
                  alignment: Alignment.centerRight,
                  child: Image(
                    alignment: Alignment.centerRight,
                    image: AssetImage('assets/images/reset_password.png'),
                    width: (MediaQuery.of(context).size.width) * 0.8,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Reset Password",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display1
                          .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48, right: 48),
                  child: Text(
                    forgotInstruction,
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: appiRed.withOpacity(0.9),
                      fontFamily: "OpenSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
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
                        size: 30,
                      ),
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Password can\'t be empty' : null,
                    onSaved: (value) => Null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
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
                        size: 30,
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
                    highlightedBorderColor: appiYellow,
                    borderSide: BorderSide(
                      color: appiYellow,
                      width: 2,
                    ),
                    splashColor: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        "RESET PASSWORD",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).primaryTextTheme.display1,
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
