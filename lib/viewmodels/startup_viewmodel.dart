import 'package:appetizer/locator.dart';
import 'package:appetizer/services/local_storage_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/ui/login/login.dart';
import 'package:appetizer/ui/home_view.dart';
import 'package:appetizer/ui/on_boarding/onBoarding.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StartUpViewModel extends BaseModel {
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  static const platform = MethodChannel('app.channel.shared.data');
  String _code;

  Future getIntent() async {
    try {
      _code = await platform.invokeMethod('getCode');
    } on Exception catch (e) {
      print(e);
    }
  }

  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();

    await getIntent();

    if (_localStorageService.isFirstTimeLogin) {
      _localStorageService.isFirstTimeLogin = false;
      await Get.offAllNamed(OnBoarding.id);
    } else {
      if (_localStorageService.isLoggedIn) {
        await Get.offAllNamed(HomeView.id,
            arguments: _localStorageService.token);
      } else {
        await Get.offAllNamed(Login.id, arguments: _code);
      }
    }
  }
}
