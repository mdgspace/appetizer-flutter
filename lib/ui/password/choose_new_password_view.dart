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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseNewPasswordView extends StatefulWidget {
  static const String id = 'choose_new_password_view';
  final User user;

  const ChooseNewPasswordView({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooseNewPasswordViewState();
}

class _ChooseNewPasswordViewState extends State<ChooseNewPasswordView> {
  final _formKey = GlobalKey<FormState>();

  late String _newPassword, _email, _contactNo;

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
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.r),
                      child: Text(
                        'Hi ${(widget.user.name).split(' ')[0]}, Choose Your Password!',
                        textAlign: TextAlign.center,
                        style: AppTheme.headline5,
                      ),
                    ),
                    Text(
                      'Password should be of atleast 8 charecters',
                      textAlign: TextAlign.center,
                      style: AppTheme.subtitle2.copyWith(
                        color: AppTheme.red,
                      ),
                    ),
                    SizedBox(height: 12.r),
                    AppetizerPasswordField(
                      iconData: Icons.lock,
                      label: 'New Password',
                      onChanged: (value) => _newPassword = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password can\'t be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) _newPassword = value;
                      },
                    ),
                    SizedBox(height: 12.r),
                    AppetizerPasswordField(
                      iconData: Icons.lock,
                      label: 'Confirm Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password can\'t be empty';
                        }
                        if (value != _newPassword) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.r),
                    AppetizerTextField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: widget.user.email,
                      iconData: Icons.email,
                      label: 'Email Address',
                      validator: (value) => !Validators.isEmailValid(value)
                          ? 'Please enter a valid e-mail'
                          : null,
                      onSaved: (value) {
                        if (value != null) _email = value;
                      },
                    ),
                    SizedBox(height: 12.r),
                    AppetizerTextField(
                      keyboardType: TextInputType.number,
                      initialValue: widget.user.contactNo,
                      iconData: Icons.phone,
                      label: 'Contact Number',
                      validator: (value) =>
                          !Validators.isPhoneNumberValid(value)
                              ? 'Please enter a valid contact no.'
                              : null,
                      onSaved: (value) {
                        if (value != null) _contactNo = value;
                      },
                    ),
                    SizedBox(height: 24.r),
                    Container(
                      width: double.maxFinite,
                      child: AppetizerOutineButton(
                        title: 'Confirm',
                        onPressed: () async {
                          if (Validators.validateAndSaveForm(_formKey)) {
                            _formKey.currentState!.reset();
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
