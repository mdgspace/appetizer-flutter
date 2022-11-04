import 'dart:convert';

import 'package:appetizer/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late LocalStorageService _instance;
  static late SharedPreferences _preferences;

  static bool _instantiated = false;

  static const String userKey = 'logged_in_user';
  static const String tokenKey = 'token';
  static const String isLoggedInKey = 'is_logged_in';
  static const String isFirstTimeLoginKey = 'is_first_time_login';
  static const String fcmTokenKey = 'fcm_token_key';

  static Future<LocalStorageService> getInstance() async {
    if (_instantiated == false){
      _instance = LocalStorageService();
      _preferences = await SharedPreferences.getInstance();
      _instantiated = true;
    }
    return _instance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  User? get currentUser {
    var userJson = _getFromDisk(userKey);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

  set currentUser(User? userToSave) {
    _saveToDisk(userKey, json.encode(userToSave?.toJson()));
  }

  String get token => _getFromDisk(tokenKey);

  set token(String? token) {
    _saveToDisk(tokenKey, token);
  }

  bool get isLoggedIn => _getFromDisk(isLoggedInKey) ?? false;

  set isLoggedIn(bool isLoggedIn) {
    _saveToDisk(isLoggedInKey, isLoggedIn);
  }

  bool get isFirstTimeLogin => _getFromDisk(isFirstTimeLoginKey) ?? true;

  set isFirstTimeLogin(bool isLoggedIn) {
    _saveToDisk(isFirstTimeLoginKey, isLoggedIn);
  }

  String get fcmToken => _getFromDisk(fcmTokenKey);

  set fcmToken(String _fcmToken) {
    _saveToDisk(fcmTokenKey, _fcmToken);
  }
}
