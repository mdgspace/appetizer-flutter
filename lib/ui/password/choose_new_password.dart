import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/user/user.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_outline_button.dart';
import 'package:appetizer/ui/components/appetizer_password_field.dart';
import 'package:appetizer/ui/components/appetizer_text_field.dart';
import 'package:appetizer/utils/validators.dart';
import 'package:appetizer/viewmodels/password/choose_new_password_viewmodel.dart';
import 'package:flutter/material.dart';

class ChooseNewPasswordView extends StatefulWidget {
  static const String id = 'choose_new_password_view';
  final User user;

  const ChooseNewPasswordView({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooseNewPasswordViewState();
}

class _ChooseNewPasswordViewState extends State<ChooseNewPasswordView> {
  final _formKey = GlobalKey<FormState>();

  String _newPassword, _email, _contactNo;

  @override
  Widget build(BuildContext context) {
    return BaseView<NewPasswordViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppetizerAppBar(title: 'Choose Password'),
        body: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Hi ${(widget?.user?.name ?? '').split(' ')[0]}, Choose Your Password!',
                        textAlign: TextAlign.center,
                        style: AppTheme.headline3,
                      ),
                    ),
                    Text(
                      'Password should be of atleast 8 charecters',
                      textAlign: TextAlign.center,
                      style: AppTheme.subtitle1.copyWith(
                        color: AppTheme.red,
                      ),
                    ),
                    SizedBox(height: 16),
                    AppetizerPasswordField(
                      iconData: Icons.lock,
                      label: 'New Password',
                      validator: (value) =>
                          value.isEmpty ? 'Password can\'t be empty' : null,
                      onSaved: (value) => _newPassword = value,
                    ),
                    SizedBox(height: 16),
                    AppetizerPasswordField(
                      iconData: Icons.lock,
                      label: 'Confirm Password',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password can\'t be empty';
                        }
                        if (value != _newPassword) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    AppetizerTextField(
                      initialValue: widget?.user?.email,
                      iconData: Icons.email,
                      label: 'Email Address',
                      validator: (value) => !Validators.isEmailValid(value)
                          ? 'Please enter a valid e-mail'
                          : null,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 16),
                    AppetizerTextField(
                      initialValue: widget?.user?.contactNo,
                      iconData: Icons.phone,
                      label: 'Contact Number',
                      validator: (value) =>
                          !Validators.isPhoneNumberValid(value)
                              ? 'Please enter a valid contact no.'
                              : null,
                      onSaved: (value) => _contactNo = value,
                    ),
                    SizedBox(height: 32),
                    Container(
                      width: double.maxFinite,
                      child: AppetizerOutineButton(
                        title: 'Confirm',
                        onPressed: () async {
                          if (Validators.validateAndSaveForm(_formKey)) {
                            _formKey.currentState.reset();
                            FocusScope.of(context).requestFocus(FocusNode());
                            await model.loginUser(
                              widget.user.enrNo,
                              _newPassword,
                              _email,
                              int.parse(_contactNo),
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
