import 'package:appetizer/forgot_pass.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'Home.dart';
import 'help.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _enrollmentNo, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: FlareActor(
                "flare_files/Login Appetizer (1).flr",
                animation: "idle",
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: ListView(
                  children: <Widget>[
                    _showEnrollmentInput(),
                    _showPasswordInput(),
                    _showLoginButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _helpButton(),
                        _forgotPasswordButton(),
                      ],
                    ),
                    _showChanneliButton(),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _showEnrollmentInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid)),
            hintText: 'Enrollment No',
            icon: new Icon(
              Icons.account_circle,
              color: Colors.grey,
            )),
        validator: (value) =>
            value.isEmpty ? 'Enrollment No can\'t be empty' : null,
        onSaved: (value) => _enrollmentNo = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showLoginButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                side: BorderSide(
                  color: appiYellow,
                  style: BorderStyle.solid,
                  width: 2,
                ),
                borderRadius: new BorderRadius.circular(40.0)),
            child: new Text('LOGIN',
                style: new TextStyle(fontSize: 25.0, color: appiYellow)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }

  Widget _helpButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: SizedBox(
          height: 25.0,
          child: new FlatButton(
            child: new Text('Help',
                style: new TextStyle(fontSize: 15.0, color: appiYellow)),
            onPressed: _help,
          ),
        ));
  }

  Widget _forgotPasswordButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: SizedBox(
          height: 25.0,
          child: new FlatButton(
            child: new Text('Forgot Password?',
                style: new TextStyle(fontSize: 15.0, color: appiYellow)),
            onPressed: _forgotPassword,
          ),
        ));
  }

  Widget _showChanneliButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(40.0)),
            color: appiYellow,
            child: new Text('SIGNUP WITH CHANNEL-I',
                style: new TextStyle(fontSize: 15.0, color: Colors.white)),
            onPressed: _channelILogin,
          ),
        ));
  }

  void _validateAndSubmit() {

  }

  void _channelILogin() {}

  void _help() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>Help()));
  }

  void _forgotPassword() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPass()));
  }
}
