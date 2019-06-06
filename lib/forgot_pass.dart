import 'package:appetizer/models/detail.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/services/user.dart';
import 'colors.dart';
import 'strings.dart';

class ForgotPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ForgotPassState();
  }
}

class _ForgotPassState extends State<ForgotPass> {
  var formKey = new GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AppBar appBar = AppBar(
      backgroundColor: appiBrown,
      leading: IconButton(
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
                          image: AssetImage('assets/images/sppedy_paper.png'),
                          width: (MediaQuery.of(context).size.width / 2) - 16,
                        ),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height) / 2 -
                            appBar.preferredSize.height,
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          alignment: Alignment.topRight,
                          image: AssetImage('assets/images/mailbox.png'),
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
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                        validator: validateEmail,
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
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                        onSaved: (String value) {
                          this._email = value;
                        }),
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
                    onPressed: () {
                      formKey.currentState.save();
                      if (formKey.currentState.validate()) {
                        _sendInstruction();
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  _sendInstruction() async {
    _showDialog();
    Detail detail = await userReset(_email);
    _popContext();
    if (detail.detail != null) {
      _showSnackBar(detail.detail);
      if (detail.detail == "link has been emailed") {
        Future.delayed(new Duration(milliseconds: 2000), _popContext);
      }
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      child: new SimpleDialog(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
                  ),
                ),
                new Expanded(child: new Container()),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: new Text(
                    "Sending Email",
                    style: new TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _popContext() {
    Navigator.pop(context);
  }

  void _showSnackBar(String detail) {
    final snackBar = SnackBar(content: Text(detail));
    Scaffold.of(formKey.currentContext).showSnackBar(snackBar);
  }
}
