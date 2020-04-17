import 'dart:async';
import 'package:appetizer/models/user/login.dart';
import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/password_models/new_password_model.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/colors.dart';

class ChooseNewPass extends StatefulWidget {
  final StudentData studentData;

  const ChooseNewPass({Key key, this.studentData}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChooseNewPassState();
}

class _ChooseNewPassState extends State<ChooseNewPass> {
  var formKey = new GlobalKey<FormState>();
  String password, email, contactNo;
  TextEditingController _newPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<NewPasswordModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: appiYellow,
          ),
          title: Text(
            "Choose New Password",
            style: TextStyle(color: Colors.white),
          ),
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
                    _choosePassword(),
                    _subTitle(),
                    _showNewPasswordInput(),
                    _showConfirmPasswordInput(),
                    _showEmailInput(),
                    _showContactNoInput(),
                    _showConfirmButton(model),
                  ],
                ),
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
            widget.studentData.name.split(" ")[0],
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
      padding: const EdgeInsets.only(top: 48.0),
      child: new TextFormField(
        controller: _newPasswordController,
        obscureText: true,
        decoration: new InputDecoration(
          labelText: "New Password",
          icon: new Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
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
        obscureText: true,
        decoration: new InputDecoration(
          labelText: "Confirm Password",
          icon: new Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Password can\'t be empty';
          }
          if (value != _newPasswordController.text) {
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
        initialValue: widget.studentData.email,
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
          labelText: "Email",
          icon: new Icon(
            Icons.email,
            color: Colors.grey,
          ),
        ),
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
        initialValue: widget.studentData.contactNo,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          labelText: "Contact No",
          icon: new Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
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

  Widget _showConfirmButton(NewPasswordModel model) {
    return new RaisedButton(
      elevation: 5.0,
      color: Colors.white,
      shape: new RoundedRectangleBorder(
        side: BorderSide(
          color: appiYellow,
          style: BorderStyle.solid,
          width: 2,
        ),
        borderRadius: new BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: new Text(
          'CONFIRM',
          style: new TextStyle(fontSize: 15.0, color: appiYellow),
        ),
      ),
      onPressed: () {
        _validateAndSave(model);
      },
    );
  }

  void _validateAndSave(NewPasswordModel model) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      loginUser(model);
    }
  }

  Future<void> loginUser(NewPasswordModel model) async {
    showCustomDialog(context, "Logging You In");
    await model.oAuthComplete(
      widget.studentData.enrNo,
      password,
      email,
      int.parse(contactNo),
    );
    if (model.oauthResponse.token != null) {
      StudentData studentData = model.oauthResponse.studentData;
      Navigator.pop(context);
      showCustomDialog(context, "Logging You In");
      Login userDetails = Login(
        email: studentData.email,
        hostelName: studentData.hostelName,
        hostelCode: studentData.hostelCode,
        roomNo: studentData.roomNo,
        enrNo: studentData.enrNo,
        name: studentData.name,
        contactNo: studentData.contactNo,
        branch: studentData.branch,
        imageUrl: studentData.imageUrl,
        isCheckedOut: studentData.isCheckedOut,
        lastUpdated: studentData.lastUpdated,
        leavesLeft: studentData.leavesLeft,
        dob: studentData.dob,
        gender: studentData.gender,
        degree: studentData.degree,
        admissionYear: studentData.admissionYear,
        role: studentData.role,
        token: model.oauthResponse.token,
      );
      model.currentUser = userDetails;
      await new Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context);
      Navigator.pushReplacementNamed(
        context,
        "home",
        arguments: model.oauthResponse.token,
      );
    } else {
      //TODO
      Navigator.pop(context);
      print("Error");
    }
  }
}
