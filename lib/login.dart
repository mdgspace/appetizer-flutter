import 'package:appetizer/forgot_pass.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'Home.dart';
import 'help.dart';
import 'package:appetizer/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = new GlobalKey<FormState>();
  String _enrollmentNo, _password;
  bool isLoading;
  bool isLoginButtonTapped = false;
  FlareActor flareActor = FlareActor(
    "flare_files/Login Appetizer (1).flr",
    animation: "idle",
  );

  // Check if form is valid before performing Login
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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
                      style: new TextStyle(fontSize: 25.0, color: appiYellow)),
                  onPressed: _validateAndSubmit,
                ),
        ));
  }

  Widget _helpButton() {
    return new Padding(
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
    return new Padding(
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
    return new Padding(
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
      userLogin(_enrollmentNo, _password).then((loginCreds) async {
        if (loginCreds.enrNo.toString() == _enrollmentNo) {
          saveUserDetails(
              loginCreds.enrNo.toString(), loginCreds.name, loginCreds.token);
          _showSnackBar(context, "Login Successful");
          setState(() {
            isLoginButtonTapped = false;
            flareActor = FlareActor("flare_files/Login Appetizer (1).flr",
                animation: "Initial To Right");
          });
          await new Future.delayed(const Duration(seconds: 5));

          getUserDetails().then((details) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Home(
                enrollment: details.getString("enrNo"),
                username: details.getString("username"),
                token: details.getString("token"),
              );
            }));
          });
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

  Future<void> saveUserDetails(
      String enrNo, String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("enrNo", enrNo);
    prefs.setString("username", username);
  }

  void _channelILogin() {}

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
      backgroundColor: Color.fromRGBO(0, 0, 0, .80),
      duration: Duration(seconds: 3),
    ));
  }
}

Future<SharedPreferences> getUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
