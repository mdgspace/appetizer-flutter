import 'package:appetizer/locator.dart';
import 'package:appetizer/services/local_storage_service.dart';
import 'package:appetizer/services/navigation_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:flutter/services.dart';

class StartUpViewModel extends BaseModel {
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  static const platform = const MethodChannel('app.channel.shared.data');
  String _code;

  Future getIntent() async {
    try {
      _code = await platform.invokeMethod("getCode");
    } on Exception catch (e) {
      print(e);
    }
  }

  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();

    await getIntent();

    if (_localStorageService.isFirstTimeLogin) {
      _localStorageService.isFirstTimeLogin = false;
      _navigationService.pushNamedAndRemoveUntil('on_boarding');
    } else {
      if (_localStorageService.isLoggedIn) {
        _navigationService.pushNamedAndRemoveUntil(
          'home',
          arguments: _localStorageService.token,
        );
      } else {
        _navigationService.pushNamedAndRemoveUntil(
          'login',
          arguments: _code,
        );
      }
    }
  }
}
