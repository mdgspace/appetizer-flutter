import 'dart:async';

import 'package:appetizer/app_theme.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_outline_button.dart';
import 'package:appetizer/ui/components/appetizer_password_field.dart';
import 'package:appetizer/ui/components/appetizer_primary_button.dart';
import 'package:appetizer/ui/components/appetizer_text_field.dart';
import 'package:appetizer/ui/help/help_view.dart';
import 'package:appetizer/ui/home_view.dart';
import 'package:appetizer/ui/login/oauth_view.dart';
import 'package:appetizer/ui/password/forgot_password_view.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/utils/validators.dart';
import 'package:appetizer/viewmodels/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  static const String id = 'login_view';

  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  LoginViewModel _model;
  final _formKey = GlobalKey<FormState>();
  String _enrollmentNo, _password;

  Widget _buildEnrollmentInput() {
    return AppetizerTextField(
      iconData: Icons.person,
      label: 'Enrollment No.',
      keyboardType: TextInputType.number,
      validator: (value) =>
          value.isEmpty ? 'Enrollment No can\'t be empty' : null,
      onSaved: (value) => _enrollmentNo = value.trim(),
    );
  }

  Widget _buildPasswordInput() {
    return AppetizerPasswordField(
      iconData: Icons.lock,
      label: 'Password',
      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _buildLoginButton() {
    if (_model.state == ViewState.Busy) {
      return AppetizerPrimaryButton(
        title: 'Authenticating..',
        onPressed: () {},
      );
    }

    if (_model.isLoggedIn) {
      return AppetizerOutineButton(
        title: 'Login Successful',
        onPressed: () {},
      );
    }

    return AppetizerOutineButton(
      title: 'LOGIN',
      onPressed: _validateAndSubmit,
    );
  }

  Widget _buildHelpTextCopmonent() {
    return GestureDetector(
      onTap: () => Get.toNamed(HelpView.id),
      child: Text(
        'Help',
        style: AppTheme.bodyText1.copyWith(
          color: AppTheme.primary,
        ),
      ),
    );
  }

  Widget _buildForgotPasswordTextComponent() {
    return GestureDetector(
      onTap: () => Get.toNamed(ForgotPasswordView.id),
      child: Text(
        'Forgot Password?',
        style: AppTheme.bodyText1.copyWith(
          color: AppTheme.primary,
        ),
      ),
    );
  }

  Widget _buildChannelIButton() {
    return AppetizerPrimaryButton(
      title: 'SIGNUP WITH CHANNEL-I',
      onPressed: () async {
        var _code = await Get.toNamed(OAuthView.id);
        if (_code is String) await _model.verifyUser(_code);
      },
    );
  }

  Future<void> _validateAndSubmit() async {
    if (Validators.validateAndSaveForm(_formKey)) {
      FocusScope.of(context).requestFocus(FocusNode());
      await _model.loginWithEnrollmentAndPassword(
        enrollment: _enrollmentNo,
        password: _password,
      );
      if (_model.isLoggedIn) {
        _model.subscribeToFCMTopic();
        await Get.offAllNamed(HomeView.id);
      } else {
        _formKey.currentState.reset();
        SnackBarUtils.showDark('Error', _model.errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) {
        _model = model;
        Future.delayed(Duration(seconds: 1), () => _model.currentUser = null);
      },
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: AppTheme.secondary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SafeArea(
                      child: Text(
                        'Appetizer',
                        textAlign: TextAlign.center,
                        style: AppTheme.subtitle1.copyWith(
                          fontSize: 48.0,
                          fontFamily: 'Lobster_Two',
                          color: AppTheme.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: SvgPicture.asset(
                        'assets/images/fingerprint.svg',
                        width: MediaQuery.of(context).size.width / 1.5,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildEnrollmentInput(),
                      _buildPasswordInput(),
                      SizedBox(height: 32),
                      Container(
                        width: double.maxFinite,
                        child: _buildLoginButton(),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildHelpTextCopmonent(),
                            VerticalDivider(color: AppTheme.primary),
                            _buildForgotPasswordTextComponent(),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.maxFinite,
                        child: _buildChannelIButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
