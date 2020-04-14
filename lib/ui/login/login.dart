import 'dart:async';
import 'dart:io';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/password/choose_new_password.dart';
import 'package:appetizer/ui/password/forgot_password.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/viewmodels/login_models/login_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors.dart';
import '../../globals.dart';
import '../help/help.dart';
import '../menu/home.dart';

class Login extends StatefulWidget {
  final String code;

  const Login({Key key, this.code}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  AnimationController _chefWrongController;
  AnimationController _chefCorrectController;

  Animation _chefWrongAnimation;
  Animation _chefCorrectAnimation;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = new GlobalKey<FormState>();

  String url =
      "http://people.iitr.ernet.in/oauth/?client_id=0a6fb094b8fe79ce0217&redirect_url=appetizer://mess.iitr.ac.in/oauth/";

  String _enrollmentNo, _password;
  FlareActor flareActor = FlareActor(
    "flare_files/login_appetizer.flr",
    animation: "idle",
  );
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void resetLogin(LoginModel model) {
    _formKey.currentState.reset();
    showSnackBar(_scaffoldKey, model.errorMessage);
  }

  void onModelReady() {
    if (widget.code != null && widget.code != "") {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => verifyUser(context));
    }

    _chefCorrectController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _chefWrongController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _chefCorrectAnimation =
        Tween(begin: 1.0, end: 0.21).animate(CurvedAnimation(
      parent: _chefCorrectController,
      curve: Curves.fastOutSlowIn,
    ));

    _chefWrongAnimation = Tween(begin: 1.0, end: 0.21).animate(CurvedAnimation(
      parent: _chefWrongController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  void onModelDestroy() {
    _chefWrongController.dispose();
    _chefCorrectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BaseView<LoginModel>(
      onModelReady: (model) => onModelReady(),
      onModelDestroy: (model) => onModelDestroy(),
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: <Widget>[
            Expanded(
              child: AnimatedBuilder(
                animation: model.areCredentialsCorrect == null
                    ? _chefWrongAnimation
                    : model.areCredentialsCorrect
                        ? _chefCorrectAnimation
                        : _chefWrongAnimation,
                builder: (BuildContext context, Widget child) {
                  return Container(
                    color: appiBrown,
                    child: SafeArea(
                      child: Container(
                        color: appiBrown,
                        child: Stack(
                          children: <Widget>[
                            flareActor,
                            Transform(
                              transform: Matrix4.translationValues(
                                  _chefCorrectAnimation.value * width, 0, 0),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SvgPicture.asset(
                                      "assets/images/happyChef.svg")),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  _chefWrongAnimation.value * width, 0, 0),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SvgPicture.asset(
                                      "assets/images/sadChef.svg")),
                            ),
                            Align(
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: new Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      _showEnrollmentInput(),
                      _showPasswordInput(),
                      Padding(
                        padding: const EdgeInsets.only(top: 45),
                        child: _showLoginButton(model),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 15, 13, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _helpButton(model),
                            _showDash(model),
                            _forgotPasswordButton(model),
                          ],
                        ),
                      ),
                      _showChannelIButton(model),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
      onSaved: (value) => _enrollmentNo = value.trim(),
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

  Widget _showLoginButton(LoginModel model) {
    return (model.state == ViewState.Busy)
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
        : (model.isLoginSuccessful)
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
                onPressed: () {
                  _validateAndSubmit(model);
                },
              );
  }

  Widget _helpButton(LoginModel model) {
    return (model.isLoginSuccessful)
        ? Container()
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

  Widget _showDash(LoginModel model) {
    return (model.isLoginSuccessful)
        ? Container()
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

  Widget _forgotPasswordButton(LoginModel model) {
    return (model.isLoginSuccessful)
        ? Container()
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

  Widget _showChannelIButton(LoginModel model) {
    return (model.isLoginSuccessful)
        ? Container()
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

  void _validateAndSubmit(LoginModel model) {
    if (_validateAndSave()) {
      FocusScope.of(context).requestFocus(new FocusNode());
      model
          .loginWithEnrollmentAndPassword(
              enrollment: _enrollmentNo, password: _password)
          .then((_) async {
        if (model.isLoginSuccessful) {
          isCheckedOut = model.login.isCheckedOut;
          saveUserDetails(
            model.login.enrNo.toString(),
            model.login.name,
            model.login.token,
            model.login.branch,
            model.login.hostelName,
            model.login.roomNo,
            model.login.email,
            model.login.contactNo,
          );
          if (model.areCredentialsCorrect == null) {
            _chefCorrectController.forward();
            setState(() {
              flareActor = FlareActor("flare_files/login_appetizer.flr",
                  animation: "Initial To Right");
            });
          } else {
            _chefWrongController.duration = Duration(milliseconds: 600);
            _chefCorrectController.duration = Duration(milliseconds: 1200);
            _chefWrongController.reverse();
            await Future.delayed(Duration(milliseconds: 100));
            _chefCorrectController.forward();
            setState(() {
              flareActor = FlareActor("flare_files/login_appetizer.flr",
                  animation: "Wrong To Right");
            });
          }
          model.areCredentialsCorrect = true;
          showSnackBar(_scaffoldKey, "Login Successful");
          await new Future.delayed(const Duration(seconds: 5));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return InheritedData(
              userDetails: UserDetailsSharedPref.fromData(
                model.login.enrNo.toString(),
                model.login.name,
                model.login.token,
                model.login.branch,
                model.login.hostelName,
                model.login.roomNo,
                model.login.email,
                model.login.contactNo,
              ),
              child: Home(
                token: model.login.token,
              ),
            );
          }));
        } else {
          resetLogin(model);
          setState(() {
            _chefWrongController.reset();
            _chefCorrectController.reset();
          });
          model.areCredentialsCorrect = false;
          _chefWrongController.forward();
          setState(() {
            flareActor = FlareActor("flare_files/login_appetizer.flr",
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
    exit(0);
  }

  Future verifyUser(BuildContext context) async {
    showCustomDialog(context, "Fetching Details");
    var oauthResponse = await UserApi().oAuthRedirect(widget.code);
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
        if (oauthResponse.token != null) {
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
          await new Future.delayed(const Duration(milliseconds: 500));
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return InheritedData(
              userDetails: UserDetailsSharedPref.fromData(
                  oauthResponse.studentData.enrNo.toString(),
                  oauthResponse.studentData.name,
                  oauthResponse.token,
                  oauthResponse.studentData.branch,
                  oauthResponse.studentData.hostelName,
                  oauthResponse.studentData.roomNo,
                  oauthResponse.studentData.email,
                  oauthResponse.studentData.contactNo),
              child: Home(
                token: oauthResponse.token,
              ),
            );
          }));
        }
      }
    }
  }

  Future _help() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
  }

  Future _forgotPassword() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPass()));
  }
}
