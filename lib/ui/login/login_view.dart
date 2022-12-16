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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatefulWidget {
  static const String id = 'login_view';

  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late LoginViewModel _model;
  final _formKey = GlobalKey<FormState>();
  String? _enrollmentNo, _password;
  late AnimationController _controller;
  late LottieComposition _successComposition, _failureComposition;
  bool pass_visible = false;
  bool enrl_visible = true;
  bool nextbtn_visible = true;
  bool loginbtn_visible = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildEnrollmentInput() {
    return Visibility(
      visible: enrl_visible,
      child: AppetizerTextField(
        iconData: Icons.person,
        label: 'Enrollment No.',
        keyboardType: TextInputType.number,
        validator: (value) =>
            (value ?? '').isEmpty ? 'Enrollment No can\'t be empty' : null,
        onSaved: (value) {
          if (value != null) _enrollmentNo = value.trim();
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Visibility(
      visible: pass_visible,
      child: AppetizerPasswordField(
        iconData: Icons.lock,
        label: 'Password',
        validator: (value) {
          if (value == null || value.isEmpty) return 'Password can\'t be empty';
          return null;
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _buildLoginButton() {
    if (_model.state == ViewState.Busy) {
      return Visibility(
        visible: loginbtn_visible,
        child: AppetizerPrimaryButton(
          title: 'Authenticating..',
          onPressed: () {},
        ),
      );
    }

    if (_model.isLoggedIn) {
      return Visibility(
        visible: loginbtn_visible,
        child: AppetizerOutineButton(
          title: 'Login Successful',
          onPressed: () {},
        ),
      );
    }

    return Visibility(
      visible: loginbtn_visible,
      child: AppetizerOutineButton(
        title: 'LOGIN',
        onPressed: _validateAndSubmit,
      ),
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

  Widget _verifyEnrlNum() {
    return Visibility(
      visible: nextbtn_visible,
      child: AppetizerOutineButton(
          title: 'NEXT',
          onPressed: () {
            _verifyEnrlNum();
            setState(() {
              pass_visible = true;
              enrl_visible = false;
              nextbtn_visible = false;
              loginbtn_visible = true;
            });
          }),
    );
  }

  Widget _buildChannelIButton() {
    return AppetizerPrimaryButton(
      title: 'SIGNUP WITH CHANNEL-I',
      onPressed: () async {
        var _code = await Get.toNamed(OAuthView.id);
        if (_code is String && _code.isNotEmpty) await _model.verifyUser(_code);
      },
    );
  }

  Future<void> _validateEnrollment() async {
    if (Validators.validateAndSaveForm(_formKey)) {
      //TODO: implement enrollment number checking api
      print(1212121212);
    }
  }

  Future<void> _validateAndSubmit() async {
    if (Validators.validateAndSaveForm(_formKey)) {
      FocusScope.of(context).requestFocus(FocusNode());
      await _model.loginWithEnrollmentAndPassword(
        enrollment: _enrollmentNo!,
        password: _password!,
      );
      _controller.reset();
      _model.showLottie = true;
      if (_model.isLoggedIn) {
        _model.subscribeToFCMTopic();
        _controller
          ..duration = _successComposition.duration
          ..forward();

        _controller.addStatusListener((status) async {
          if (status == AnimationStatus.completed) {
            await Get.offAllNamed(HomeView.id);
            _model.showLottie = false;
          }
        });
      } else {
        _formKey.currentState?.reset();
        _controller
          ..duration = _failureComposition.duration
          ..forward();
        SnackBarUtils.showDark('Error', _model.errorMessage);
      }
    }
  }

  Future<void> _loadComposition() async {
    // Success Composition
    _successComposition =
        await AssetLottie('assets/lottie/success.json').load();

    // Failure Composition
    _failureComposition =
        await AssetLottie('assets/lottie/failure.json').load();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) async {
        _model = model;
        model.showLottie = false;
        await _loadComposition();

        Future.delayed(Duration(seconds: 1), () => _model.currentUser = null);
      },
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2.04,
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
                                  fontSize: 48.sp,
                                  fontFamily: 'Lobster_Two',
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            if (!model.showLottie)
                              Expanded(
                                child: SvgPicture.asset(
                                  'assets/images/fingerprint.svg',
                                  width:
                                      MediaQuery.of(context).size.width / 1.60,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (model.showLottie)
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Lottie(
                            composition: _model.isLoggedIn
                                ? _successComposition
                                : _failureComposition,
                            controller: _controller,
                          ),
                        ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2.05,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.w,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                _buildEnrollmentInput(),
                                _buildPasswordInput(),
                                SizedBox(height: 24.r),
                                Container(
                                  width: double.maxFinite,
                                  child: _verifyEnrlNum(),
                                ),
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
                                SizedBox(height: 12.r),
                                // Container(
                                //   width: double.maxFinite,
                                //   child: _buildChannelIButton(),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
