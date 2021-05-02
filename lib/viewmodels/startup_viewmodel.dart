import 'dart:async';

import 'package:appetizer/locator.dart';
import 'package:appetizer/services/local_storage_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/services/remote_config_service.dart';
import 'package:appetizer/ui/home_view.dart';
import 'package:appetizer/ui/login/login_view.dart';
import 'package:appetizer/ui/on_boarding/on_boarding_view.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class StartUpViewModel extends BaseModel {
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final RemoteConfigService _remoteConfigService =
      locator<RemoteConfigService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  StreamSubscription _uniLinksSubscription;

  Future initUniLinks() async {
    // check initialUri
    try {
      var _uri = await getInitialUri();
      await _handleUniLink(_uri);
    } on Exception {
      return;
    }

    // Attach a listener to the stream
    _uniLinksSubscription = getUriLinksStream().listen(
      (Uri uri) => _handleUniLink(uri),
      onError: (err) {
        return;
      },
    );
  }

  Future<void> _handleUniLink(Uri uri) async {
    if (uri != null) {
      var _params = uri.toString().split('?').last.split('&');
      if (_params.first.contains('code')) {
        var _code = _params.first.split('=').last;
        await Get.offAllNamed(LoginView.id, arguments: _code);
      }
    }
  }

  void cancelUniLinksSubscription() {
    _uniLinksSubscription.cancel();
  }

  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();
    await _remoteConfigService.initialise();

    if (_localStorageService.isFirstTimeLogin) {
      _localStorageService.isFirstTimeLogin = false;
      await Get.offAllNamed(OnBoardingView.id);
    } else if (_localStorageService.isLoggedIn) {
      await Get.offAllNamed(HomeView.id, arguments: _localStorageService.token);
    } else {
      await Get.offAllNamed(LoginView.id);
    }
  }
}
