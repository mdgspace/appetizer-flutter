import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_outline_button.dart';
import 'package:appetizer/ui/components/appetizer_password_field.dart';
import 'package:appetizer/utils/validators.dart';
import 'package:appetizer/viewmodels/password/reset_password_viewmodel.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  static const String id = 'reset_password_view';

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();

  String _oldPassword = '';
  String _newPassword = '';

  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPasswordViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppetizerAppBar(title: 'Reset Password'),
        body: ListView(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) /
                  2,
              width: MediaQuery.of(context).size.width,
              color: AppTheme.secondary,
              alignment: Alignment.centerRight,
              child: Image(
                alignment: Alignment.centerRight,
                image: AssetImage('assets/images/reset_password.png'),
                width: (MediaQuery.of(context).size.width) * 0.8,
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Reset Password',
                        textAlign: TextAlign.center,
                        style: AppTheme.headline3,
                      ),
                    ),
                    Text(
                      'Password should be of atleast 8 characters',
                      textAlign: TextAlign.center,
                      style: AppTheme.subtitle1.copyWith(
                        color: AppTheme.red,
                      ),
                    ),
                    SizedBox(height: 16),
                    AppetizerPasswordField(
                      iconData: Icons.lock,
                      label: 'Old Password',
                      validator: (value) =>
                          value.isEmpty ? 'Password can\'t be empty' : null,
                      onSaved: (value) => _oldPassword = value,
                    ),
                    AppetizerPasswordField(
                      iconData: Icons.lock,
                      label: 'New Password',
                      validator: (value) =>
                          value.isEmpty ? 'Password can\'t be empty' : null,
                      onSaved: (value) => _newPassword = value,
                    ),
                    SizedBox(height: 32),
                    Container(
                      width: double.maxFinite,
                      child: AppetizerOutineButton(
                        title: 'Reset Password',
                        onPressed: () async {
                          if (Validators.validateAndSaveForm(_formKey)) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await model.onResetPasswordTapped(
                              _oldPassword,
                              _newPassword,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
