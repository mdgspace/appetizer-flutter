import 'dart:async';
import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/menu/home.dart';
import 'package:appetizer/models/user/oauth.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/colors.dart';

class ChooseNewPass extends StatefulWidget {
  final String name;
  final int enr;
  final String email;
  final String contactNo;

  const ChooseNewPass(
      {Key key, this.email, this.contactNo, this.enr, this.name})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChooseNewPassState();
  }
}

class _ChooseNewPassState extends State<ChooseNewPass> {
  var formKey = new GlobalKey<FormState>();
  String password, email, contactNo;
  int enr;
  TextEditingController controller1 = new TextEditingController();

  @override
  void initState() {
    super.initState();
    enr = widget.enr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appiBrown,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: appiYellow,
        ),
        title: Text(
          "Choose New Password",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Form(
              key: formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //new Expanded(child: new Container()),
                  _choosePassword(),
                  //new Expanded(child: new Container()),
                  _subTitle(),
                  //new Expanded(child: new Container()),
                  _showNewPasswordInput(),
                  //new Expanded(child: new Container()),
                  _showConfirmPasswordInput(),
                  //new Expanded(child: new Container()),
                  _showEmailInput(),
                  //new Expanded(child: new Container()),
                  _showContactNoInput(),
                  //new Expanded(child: new Container()),
                  _showConfirmButton(),
                  //new Expanded(child: new Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _choosePassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Hi ",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          new Text(
            widget.name.split(" ")[0],
            style: new TextStyle(
              color: appiYellow,
              fontSize: 16,
            ),
          ),
          new Text(
            ", Choose You Password",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _subTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: new Text(
        " Password should be of atleast 8 \n charecters",
        style: TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _showNewPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 0.0),
      child: new TextFormField(
        controller: controller1,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: "New Password",
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return "Password can\'t be empty";
          } else if (value.length < 8) {
            return "Password is too short";
          }
          return null;
        },
        onSaved: (value) => password = value,
      ),
    );
  }

  Widget _showConfirmPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: "Confirm Password",
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return 'Password can\'t be empty';
          }
          if (value != controller1.text) {
            return "Passwords do not match";
          }
          return null;
        },
        onSaved: (value) => password = value,
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 0.0),
      child: new TextFormField(
        initialValue: widget.email,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: "Email",
            icon: new Icon(
              Icons.email,
              color: Colors.grey,
            )),
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value)) return 'Enter Valid Email';
          return null;
        },
        onSaved: (value) => email = value,
      ),
    );
  }

  Widget _showContactNoInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 0.0),
      child: new TextFormField(
        initialValue: widget.contactNo,
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: "Contact No",
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return "Contact No can\'t be empty";
          } else if (value.length != 10) {
            return "Please check the entered number";
          }
          return null;
        },
        onSaved: (value) => contactNo = value,
      ),
    );
  }

  Widget _showConfirmButton() {
    return new RaisedButton(
      elevation: 5.0,
      color: Colors.white,
      shape: new RoundedRectangleBorder(
          side: BorderSide(
            color: appiYellow,
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: new BorderRadius.circular(40.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: new Text('CONFIRM',
            style: new TextStyle(fontSize: 15.0, color: appiYellow)),
      ),
      onPressed: _validateAndSave,
    );
  }

  void _validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      loginUser();
    }
  }

  // TODO: (remove duplication) duplication in login, password
  void loginUser() async {
    showCustomDialog(context, "Logging You In");
    OauthResponse oauthResponse =
        await oAuthComplete(enr, password, email, int.parse(contactNo));
    if (oauthResponse.token != null) {
      saveUserDetails(oauthResponse.studentData.enrNo.toString(),
          oauthResponse.studentData.name, oauthResponse.token);
      await new Future.delayed(const Duration(milliseconds: 1000));
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
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
    } else {
      //TODO
      Navigator.pop(context);
      print("Error");
    }
  }

  Future<void> saveUserDetails(
      String enrNo, String username, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("enrNo", enrNo);
    prefs.setString("username", username);
  }
}
