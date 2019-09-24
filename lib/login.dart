import 'dart:async';
import 'dart:io';
import 'package:appetizer/alertDialog.dart';
import 'package:appetizer/chooseNewPassword.dart';
import 'package:appetizer/forgotPassword.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';
import 'colors.dart';
import 'help.dart';
import 'package:appetizer/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.code);
    if (widget.code != null && widget.code != "") {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => verifyUser(context));
    }
    showConnectivityStatus();
  }

  Future showConnectivityStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
        msg: "Please check your connection!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 7,
        fontSize: 12.0,
      );
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
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: _showLoginButton(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(13, 15, 13, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _helpButton(),
                          _showDash(),
                          _forgotPasswordButton(),
                        ],
                      ),
                    ),
                    _showChannelIButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFlareAnimation() {
    return flareActor;
  }

  Widget _showEnrollmentInput() {
    return new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: new InputDecoration(
        labelText: "Enrollment No.",
        labelStyle: Theme.of(context).primaryTextTheme.subhead,
        icon: new Icon(
          Icons.person,
          color: appiGreyIcon,
          size: 39,
        ),
      ),
      validator: (value) =>
          value.isEmpty ? 'Enrollment No can\'t be empty' : null,
      onSaved: (value) => _enrollmentNo = value,
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
          suffixIcon: GestureDetector(
            child: new Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: appiGreyIcon,
            ),
            onTap: _toggle,
          ),
          labelText: "Password",
          labelStyle: Theme.of(context).primaryTextTheme.subhead,
          icon: new Icon(
            Icons.lock,
            color: appiGreyIcon,
            size: 39,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showLoginButton() {
    showConnectivityStatus();

    return (isLoginButtonTapped)
        ? new FlatButton(
            padding: EdgeInsets.all(8),
            color: appiYellow,
            shape: new Border.all(
              width: 2,
              color: appiYellow,
              style: BorderStyle.solid,
            ),
            child: new Text(
              'Authenticating...',
              style: Theme.of(context).accentTextTheme.display1,
            ),
            onPressed: () {})
        : (_isLoginSuccessful)
            ? new FlatButton(
                padding: EdgeInsets.all(8),
                color: Colors.white,
                shape: new Border.all(
                  width: 2,
                  color: appiYellow,
                  style: BorderStyle.solid,
                ),
                child: new Text(
                  'Logged In Successfully',
                  style: Theme.of(context).primaryTextTheme.display1,
                ),
                onPressed: () {})
            : new FlatButton(
                padding: EdgeInsets.all(8),
                color: Colors.white,
                shape: new Border.all(
                  width: 2,
                  color: appiYellow,
                  style: BorderStyle.solid,
                ),
                child: new Text(
                  'LOGIN',
                  style: Theme.of(context).primaryTextTheme.display1,
                ),
                onPressed: _validateAndSubmit,
              );
  }

  Widget _helpButton() {
    return (_isLoginSuccessful)
        ? emptyContainer()
        : SizedBox(
            height: 25.0,
            child: new GestureDetector(
              child: new Text(
                'Help',
                style: Theme.of(context).primaryTextTheme.display3,
              ),
              onTap: _help,
            ),
          );
  }

  Widget _showDash() {
    return (_isLoginSuccessful)
        ? emptyContainer()
        : SizedBox(
            height: 25.0,
            child: new GestureDetector(
              child: new Text(
                '  |  ',
                style: Theme.of(context).primaryTextTheme.display4,
              ),
              onTap: _help,
            ),
          );
  }

  Widget _forgotPasswordButton() {
    return (_isLoginSuccessful)
        ? emptyContainer()
        : SizedBox(
            height: 25.0,
            child: new GestureDetector(
              child: new Text(
                'Forgot Password?',
                style: Theme.of(context).primaryTextTheme.display3,
              ),
              onTap: _forgotPassword,
            ),
          );
  }

  Widget _showChannelIButton() {
    return (_isLoginSuccessful)
        ? emptyContainer()
        : new FlatButton(
            padding: EdgeInsets.all(12),
            color: appiYellow,
            shape: new Border.all(
              width: 2,
              color: appiYellow,
              style: BorderStyle.solid,
            ),
            child: new Text(
              'SIGNUP WITH CHANNEL-I',
              style: Theme.of(context).primaryTextTheme.display2,
            ),
            onPressed: _channelILogin,
          );
  }

  Widget emptyContainer() {
    return new Container(
      height: 0,
      width: 0,
    );
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      setState(() {
        isLoginButtonTapped = true;
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      userLogin(_enrollmentNo, _password).then((loginCredentials) async {
        if (loginCredentials.enrNo.toString() == _enrollmentNo) {
          saveUserDetails(
            loginCredentials.enrNo.toString(),
            loginCredentials.name,
            loginCredentials.token,
            loginCredentials.branch,
            loginCredentials.hostelName,
            loginCredentials.roomNo,
            loginCredentials.email,
            loginCredentials.contactNo,
          );
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
      String enrNo,
      String username,
      String token,
      String branch,
      String hostelName,
      String roomNo,
      String email,
      String contactNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("enrNo", enrNo);
    prefs.setString("username", username);
    prefs.setString("branch", branch);
    prefs.setString("hostelName", hostelName);
    prefs.setString("roomNo", roomNo);
    prefs.setString("email", email);
    prefs.setString("contactNo", contactNo);
  }

  void _channelILogin() {
    //FlutterWebBrowser.openWebPage(url: url);
    launch(url);
    //exit(0);
  }

  Future verifyUser(BuildContext context) async {
    showCustomDialog(context, "Fetching Details");
    var oauthResponse = await oAuthRedirect(widget.code);
    print("Code " + widget.code);
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
          oauthResponse.studentData.branch,
          oauthResponse.studentData.hostelName,
          oauthResponse.studentData.roomNo,
          oauthResponse.studentData.email,
          oauthResponse.studentData.contactNo,
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
