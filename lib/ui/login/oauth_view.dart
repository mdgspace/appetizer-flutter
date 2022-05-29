import 'dart:io';

import 'package:appetizer/config/environment_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OAuthView extends StatefulWidget {
  static const id = 'oauth_view';

  @override
  State<OAuthView> createState() => _OAuthViewState();
}

class _OAuthViewState extends State<OAuthView> {
  final String omniportSignUpURL =
      'https://channeli.in/oauth/authorise/?client_id=${EnvironmentConfig.OAUTH_CLIENT_ID}&redirect_uri=${EnvironmentConfig.OAUTH_REDIRECT_URI}';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: omniportSignUpURL,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (request) {
            if (request.url.contains('https://channeli.in/oauth/')) {
              return NavigationDecision.navigate;
            }

            var _params = request.url.split('?').last.split('&');
            if (_params.first.contains('code')) {
              var _code = _params.first.split('=').last;
              Get.back(result: _code);
            }
            return NavigationDecision.prevent;
          },
        ),
      ),
    );
  }
}
