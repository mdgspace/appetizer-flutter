import 'dart:async';
import 'dart:io';
import 'package:appetizer/alertdialog.dart';
import 'package:appetizer/choosenewpassword.dart';
import 'package:appetizer/forgot_pass.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'Home.dart';
import 'colors.dart';
import 'help.dart';
import 'package:appetizer/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class Login extends StatefulWidget {
  final String code;

  const Login({Key key, this.code}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = new GlobalKey<FormState>();

  String url =
      "http://people.iitr.ernet.in/oauth/?client_id=0a6fb094b8fe79ce0217&redirect_url=appetizer://mess.iitr.ac.in/oauth/";

  String _enrollmentNo, _password;
  bool isLoading;
  bool isLoginButtonTapped = false;
  bool _isLoginSuccessful = false;
  FlareActor flareActor = FlareActor(
    "flare_files/Login Appetizer (1).flr",
    animation: "idle",
  );

  @override
  void initState() {
    super.initState();
    if (widget.code != null) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => verifyUser(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Stack(
              children: <Widget>[
                getFlareAnimation(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Appetizer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50.0,
                          fontFamily: 'Lobster_Two',
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: new Form(
                  key: _formKey,
                  child: ListView(
                    physics: ClampingScrollPhysics(),
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
                ),
              ))
        ],
      ),
    );
  }

  Widget getFlareAnimation() {
    return flareActor;
  }

  Widget _showEnrollmentInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: "Enrollment No",
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
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: "Password",
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
          child: (isLoginButtonTapped)
              ? new RaisedButton(
                  elevation: 5.0,
                  color: appiYellow,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40.0)),
                  child: new Text(
                    "AUTHENTICATING...",
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: () {})
              : (_isLoginSuccessful)
                  ? new RaisedButton(
                      elevation: 5,
                      color: appiYellow,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(40.0)),
                      child: new Text(
                        "Logged In",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      onPressed: () {})
                  : new RaisedButton(
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
                          style:
                              new TextStyle(fontSize: 25.0, color: appiYellow)),
                      onPressed: _validateAndSubmit,
                    ),
        ));
  }

  Widget _helpButton() {
    return (_isLoginSuccessful)
        ? Container(
            height: 0,
            width: 0,
          )
        : new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 0.0),
            child: SizedBox(
              height: 25.0,
              child: new GestureDetector(
                child: new Text('Help',
                    style: new TextStyle(fontSize: 15.0, color: appiYellow)),
                onTap: _help,
              ),
            ));
  }

  Widget _forgotPasswordButton() {
    return (_isLoginSuccessful)
        ? Container(
            height: 0,
            width: 0,
          )
        : new Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
            child: SizedBox(
              height: 25.0,
              child: new GestureDetector(
                child: new Text('Forgot Password?',
                    style: new TextStyle(fontSize: 15.0, color: appiYellow)),
                onTap: _forgotPassword,
              ),
            ));
  }

  Widget _showChanneliButton() {
    return (_isLoginSuccessful)
        ? Container(
            height: 0,
            width: 0,
          )
        : new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
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
    if (_validateAndSave()) {
      setState(() {
        isLoginButtonTapped = true;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      userLogin(_enrollmentNo, _password).then((loginCredentials) async {
        if (loginCredentials.enrNo.toString() == _enrollmentNo) {
          saveUserDetails(loginCredentials.enrNo.toString(),
              loginCredentials.name, loginCredentials.token);
          _showSnackBar(context, "Login Successful");
          setState(() {
            _isLoginSuccessful = true;
            isLoginButtonTapped = false;
            flareActor = FlareActor("flare_files/Login Appetizer (1).flr",
                animation: "Initial To Right");
          });
          await new Future.delayed(const Duration(seconds: 5));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return Home(
              enrollment: loginCredentials.enrNo.toString(),
              username: loginCredentials.name,
              token: loginCredentials.token,
            );
          }));
        } else {
          setState(() {
            isLoginButtonTapped = false;
          });
          _showSnackBar(context, "Incorrect authentication credentials.");
          setState(() {
            flareActor = FlareActor("flare_files/Login Appetizer (1).flr",
                animation: "Initial To Wrong");
          });
        }
      });
    }
  }

  // Check if form is valid before performing Login
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> saveUserDetails(
      String enrNo, String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("enrNo", enrNo);
    prefs.setString("username", username);
  }

  void _channelILogin() {
    FlutterWebBrowser.openWebPage(url: url);
    exit(0);
  }

  Future verifyUser(BuildContext context) async {
    showCustomDialog(context, "Fetching Details");
    var oauthResponse = await oAuthRedirect(widget.code);
    if (oauthResponse != null) {
      if (oauthResponse.isNew) {
        Navigator.pop(context);
        showCustomDialog(context, "Redirecting");
        await new Future.delayed(
          new Duration(milliseconds: 500),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ChooseNewPass(
            name: oauthResponse.studentData.name,
            enr: oauthResponse.studentData.enrNo,
            email: oauthResponse.studentData.email,
            contactNo: oauthResponse.studentData.contactNo,
          );
        }));
      } else {
        print(oauthResponse.isNew);
        print(oauthResponse.token);
        Navigator.pop(context);
        showCustomDialog(context, "Logging You In");
        saveUserDetails(
          oauthResponse.studentData.enrNo.toString(),
          oauthResponse.studentData.name,
          oauthResponse.token,
        );
        setState(() {
          _isLoginSuccessful = true;
          isLoginButtonTapped = false;
        });
        await new Future.delayed(const Duration(milliseconds: 500));
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home(
            enrollment: oauthResponse.studentData.enrNo.toString(),
            username: oauthResponse.studentData.name,
            token: oauthResponse.token,
          );
        }));
      }
    }
  }

  void _help() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
  }

  void _forgotPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPass()));
  }

  void _showSnackBar(BuildContext context, String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

Future<SharedPreferences> getUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
