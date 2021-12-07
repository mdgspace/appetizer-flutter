import 'dart:io';

import 'package:appetizer/config/environment_config.dart';
import 'package:appetizer/viewmodels/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends StatefulWidget {
  LoginWebView({@required this.model});
  final LoginViewModel model;

  static const id = 'login_webview';

  @override
  State<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  final String omniportSignUpURL =
      'https://channeli.in/oauth/authorise/?client_id=${EnvironmentConfig.OAUTH_CLIENT_ID}&redirect_uri=https://appetizer-mdg.herokuapp.com/oauth/';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return WebView(
            initialUrl: omniportSignUpURL,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: widget.model.navigationRequest,
          );
        }),
      ),
    );
  }
}
