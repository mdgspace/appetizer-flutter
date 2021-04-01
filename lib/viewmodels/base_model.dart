import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/user/user.dart';
import 'package:appetizer/services/local_storage_service.dart';
import 'package:appetizer/services/remote_config_service.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  final RemoteConfigService _remoteConfigService =
      locator<RemoteConfigService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  User get currentUser => _localStorageService.currentUser;

  set currentUser(User currentUser) {
    _localStorageService.currentUser = currentUser;
    notifyListeners();
  }

  bool get isLoggedIn => _localStorageService.isLoggedIn;

  set isLoggedIn(bool isLoggedIn) {
    _localStorageService.isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  String get token => _localStorageService.token;

  set token(String token) {
    _localStorageService.token = token;
    notifyListeners();
  }

  String get appetizerVersion => _remoteConfigService.appetizerVersion;

  String get googlePlayLink => _remoteConfigService.googlePlayLink;

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
