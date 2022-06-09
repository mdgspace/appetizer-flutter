import 'package:appetizer/config/environment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../utils/snackbar_utils.dart';

class OAuthView extends StatelessWidget {
  static const id = 'oauth_view';
  const OAuthView({Key key}) : super(key: key);
  final String omniportSignUpURL =
      'https://channeli.in/oauth/authorise/?client_id=${EnvironmentConfig.OAUTH_CLIENT_ID}&redirect_uri=${EnvironmentConfig.OAUTH_REDIRECT_URI}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(omniportSignUpURL),
          ),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
            ),
          ),
          onUpdateVisitedHistory: (_, uri, __) {
            if (uri != null) {
              if (uri.toString().contains('https://channeli.in/feed')) {
                Get.back();
                SnackBarUtils.showDark('Error', 'Permission Denied!');
              }
            }
          },
          shouldOverrideUrlLoading: (_, navigationAction) async {
            final url = navigationAction.request.url.toString();
            if (url.contains('https://channeli.in/')) {
              return NavigationActionPolicy.ALLOW;
            }

            var _params = url.split('?').last.split('&');
            if (_params.first.contains('code')) {
              var _code = _params.first.split('=').last;
              Get.back(result: _code);
            }

            return NavigationActionPolicy.CANCEL;
          },
        ),
      ),
    );
  }
}
