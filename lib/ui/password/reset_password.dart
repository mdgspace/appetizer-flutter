import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/viewmodels/password_models/reset_password_model.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/strings.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  String oldPassword = "";
  String newPassword = "";

  final _formKey = new GlobalKey<FormState>();

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
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

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordModel>(
      builder: (context, model, child) => Scaffold(
        key: resetPasswordViewScaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Reset Password",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height) / 2 -
                        AppBar().preferredSize.height,
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                          child: new TextFormField(
                            maxLines: 1,
                            obscureText: _obscureText1,
                            autofocus: false,
                            decoration: new InputDecoration(
                              suffixIcon: GestureDetector(
                                child: new Icon(
                                  _obscureText1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: appiGreyIcon,
                                ),
                                onTap: _toggle1,
                              ),
                              labelText: "Old Password",
                              labelStyle:
                                  Theme.of(context).primaryTextTheme.subhead,
                              icon: new Icon(
                                Icons.lock,
                                color: appiGreyIcon,
                                size: 30,
                              ),
                            ),
                            validator: (value) => value.isEmpty
                                ? 'Password can\'t be empty'
                                : null,
                            onSaved: (value) => oldPassword = value,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                          child: new TextFormField(
                            maxLines: 1,
                            obscureText: _obscureText2,
                            autofocus: false,
                            decoration: new InputDecoration(
                              suffixIcon: GestureDetector(
                                child: new Icon(
                                  _obscureText2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: appiGreyIcon,
                                ),
                                onTap: _toggle2,
                              ),
                              labelText: "New Password",
                              labelStyle:
                                  Theme.of(context).primaryTextTheme.subhead,
                              icon: new Icon(
                                Icons.lock,
                                color: appiGreyIcon,
                                size: 30,
                              ),
                            ),
                            validator: (value) => value.isEmpty
                                ? 'Password can\'t be empty'
                                : null,
                            onSaved: (value) => newPassword = value,
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
                                "Reset Password",
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).primaryTextTheme.display1,
                              ),
                            ),
                            onPressed: () async {
                              if (_validateAndSave()) {
                                showCustomDialog(context, "Updating Password");
                                await model.resetPassword(
                                    oldPassword, newPassword);
                                if (model.state != ViewState.Error) {
                                  showSnackBar(resetPasswordViewScaffoldKey,
                                      "Password changed successfully");
                                } else {
                                  showSnackBar(resetPasswordViewScaffoldKey,
                                      model.errorMessage);
                                }
                                setState(() {
                                  Navigator.pop(context);
                                });
                                _formKey.currentState.reset();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
