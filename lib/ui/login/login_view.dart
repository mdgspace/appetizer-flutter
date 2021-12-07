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
import 'package:appetizer/ui/login/login_webview.dart';
import 'package:appetizer/ui/password/forgot_password_view.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/utils/validators.dart';
import 'package:appetizer/viewmodels/login/login_viewmodel.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  AnimationController _chefWrongController;
  AnimationController _chefCorrectController;

  Animation _chefWrongAnimation;
  Animation _chefCorrectAnimation;

  final _formKey = GlobalKey<FormState>();

  String _enrollmentNo, _password;

  FlareActor _flareActor = FlareActor(
    'assets/flare/login_appetizer.flr',
    animation: 'idle',
  );

  @override
  void initState() {
    super.initState();

    _chefCorrectController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _chefWrongController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _chefCorrectAnimation = Tween(begin: 1.0, end: 0.21).animate(
      CurvedAnimation(
        parent: _chefCorrectController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _chefWrongAnimation = Tween(begin: 1.0, end: 0.21).animate(
      CurvedAnimation(
        parent: _chefWrongController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

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

    if (_model.isLoginSuccessful) {
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
    if (_model.isLoginSuccessful) return Container();

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

  Widget _buildDashComponent() {
    if (_model.isLoginSuccessful) return Container();

    return VerticalDivider(color: AppTheme.primary);
  }

  Widget _buildForgotPasswordTextComponent() {
    if (_model.isLoginSuccessful) return Container();

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

  Widget _buildChannelIButton(LoginViewModel model) {
    if (_model.isLoginSuccessful) return Container();

    return AppetizerPrimaryButton(
      title: 'SIGNUP WITH CHANNEL-I',
      onPressed: () {
        Get.toNamed(
          LoginWebView.id,
          arguments: model,
        );
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
      if (_model.isLoginSuccessful) {
        if (_model.areCredentialsCorrect == null) {
          await _chefCorrectController.forward();
          setState(() {
            _flareActor = FlareActor(
              'assets/flare/login_appetizer.flr',
              animation: 'Initial To Right',
            );
          });
        } else {
          _chefWrongController.duration = Duration(milliseconds: 600);
          _chefCorrectController.duration = Duration(milliseconds: 1200);
          await _chefWrongController.reverse();
          await Future.delayed(Duration(milliseconds: 100));
          await _chefCorrectController.forward();
          setState(() {
            _flareActor = FlareActor(
              'assets/flare/login_appetizer.flr',
              animation: 'Wrong To Right',
            );
          });
        }
        _model.areCredentialsCorrect = true;
        SnackBarUtils.showDark('Info', 'Login Successful');
        await Future.delayed(const Duration(seconds: 5));
        await Get.offAllNamed(HomeView.id);
      } else {
        _formKey.currentState.reset();
        SnackBarUtils.showDark('Error', _model.errorMessage);
        setState(() {
          _chefWrongController.reset();
          _chefCorrectController.reset();
        });
        _model.areCredentialsCorrect = false;
        await _chefWrongController.forward();
        setState(() {
          _flareActor = FlareActor(
            'assets/flare/login_appetizer.flr',
            animation: 'Initial To Wrong',
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return BaseView<LoginViewModel>(
      onModelReady: (model) {
        _model = model;
        Future.delayed(Duration(seconds: 1), () => _model.currentUser = null);
      },
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: AnimatedBuilder(
                animation: model.areCredentialsCorrect == null
                    ? _chefWrongAnimation
                    : model.areCredentialsCorrect
                        ? _chefCorrectAnimation
                        : _chefWrongAnimation,
                builder: (BuildContext context, Widget child) {
                  return Container(
                    color: AppTheme.secondary,
                    child: SafeArea(
                      child: Container(
                        color: AppTheme.secondary,
                        child: Stack(
                          children: <Widget>[
                            _flareActor,
                            Transform(
                              transform: Matrix4.translationValues(
                                  _chefCorrectAnimation.value * _width, 0, 0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SvgPicture.asset(
                                  'assets/images/happy_chef.svg',
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(
                                  _chefWrongAnimation.value * _width, 0, 0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SvgPicture.asset(
                                  'assets/images/sad_chef.svg',
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      _buildEnrollmentInput(),
                      _buildPasswordInput(),
                      SizedBox(height: 32),
                      _buildLoginButton(),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildHelpTextCopmonent(),
                            _buildDashComponent(),
                            _buildForgotPasswordTextComponent(),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildChannelIButton(model),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chefWrongController.dispose();
    _chefCorrectController.dispose();
  }
}
