import 'package:appetizer/config/environment_config.dart';
import 'package:appetizer/viewmodels/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends StatelessWidget {
  LoginWebView({@required this.model});
  final LoginViewModel model;

  static const id = 'login_webview';
  final String omniportSignUpURL =
      'https://channeli.in/oauth/authorise/?client_id=${EnvironmentConfig.OAUTH_CLIENT_ID}&redirect_uri=https://appetizer-mdg.herokuapp.com/oauth/';

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: omniportSignUpURL,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: model.navigationRequest,
    );
  }
}
