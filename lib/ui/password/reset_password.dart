import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/password_models/reset_password_model.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';

class ResetPassword extends StatefulWidget {
  static const String id = 'reset_password_view';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  String oldPassword = '';
  String newPassword = '';

  final _formKey = GlobalKey<FormState>();

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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Reset Password',
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
                    child: Text('Reset Password',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline4
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48, right: 48),
                    child: Text(
                      'Password should be of atleast 8 characters',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: appiRed.withOpacity(0.9),
                        fontFamily: 'OpenSans',
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
                          child: TextFormField(
                            maxLines: 1,
                            obscureText: _obscureText1,
                            autofocus: false,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: _toggle1,
                                child: Icon(
                                  _obscureText1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: appiGreyIcon,
                                ),
                              ),
                              labelText: 'Old Password',
                              labelStyle:
                                  Theme.of(context).primaryTextTheme.subtitle1,
                              icon: Icon(
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
                          child: TextFormField(
                            maxLines: 1,
                            obscureText: _obscureText2,
                            autofocus: false,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: _toggle2,
                                child: Icon(
                                  _obscureText2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: appiGreyIcon,
                                ),
                              ),
                              labelText: 'New Password',
                              labelStyle:
                                  Theme.of(context).primaryTextTheme.subtitle1,
                              icon: Icon(
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
                            onPressed: () async {
                              if (_validateAndSave()) {
                                _formKey.currentState.reset();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                await model.onResetPasswordTapped(
                                    oldPassword, newPassword);
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: ListTile(
                              title: Text(
                                'Reset Password',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline4,
                              ),
                            ),
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
