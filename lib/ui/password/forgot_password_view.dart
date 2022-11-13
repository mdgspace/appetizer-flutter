import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_outline_button.dart';
import 'package:appetizer/ui/components/appetizer_text_field.dart';
import 'package:appetizer/utils/validators.dart';
import 'package:appetizer/viewmodels/password/forgot_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordView extends StatefulWidget {
  static const String id = 'forgot_password_view';

  @override
  State<StatefulWidget> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();

  late String _email;

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppetizerAppBar(title: 'Forgot Password'),
        body: ListView(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height) /
                  2,
              color: AppTheme.secondary,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    padding: EdgeInsets.only(top: 70.r),
                    child: Image.asset(
                      'assets/images/sppedy_paper.png',
                      alignment: Alignment.bottomLeft,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.only(bottom: 70.r),
                    child: Image.asset(
                      'assets/images/mailbox.png',
                      alignment: Alignment.topRight,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.r),
                      child: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.center,
                        style: AppTheme.headline3,
                      ),
                    ),
                    Text(
                      'Enter your email below to recieve your password reset instructions',
                      textAlign: TextAlign.center,
                      style: AppTheme.subtitle1,
                    ),
                    SizedBox(height: 16.r),
                    AppetizerTextField(
                      iconData: Icons.email,
                      label: 'Email Address',
                      validator: (value) => !Validators.isEmailValid(value)
                          ? 'Please enter a valid e-mail'
                          : null,
                      onSaved: (value){
                        if (value != null) _email = value;
                      },
                    ),
                    SizedBox(height: 32.r),
                    Container(
                      width: double.maxFinite,
                      child: AppetizerOutineButton(
                        title: 'Send Instructions',
                        onPressed: () async {
                          if (Validators.validateAndSaveForm(_formKey)) {
                            _formKey.currentState!.reset();
                            FocusScope.of(context).requestFocus(FocusNode());
                            await model.sendResetEmail(_email);
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
