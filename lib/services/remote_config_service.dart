import 'package:firebase_remote_config/firebase_remote_config.dart';

const String APP_LINK = 'appetizer_link';
const String IS_LEAVE_ENABLED = 'is_leave_enabled';
const String IS_SWITCH_ENABLED = 'is_switch_enabled';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{};

  static late RemoteConfigService _instance;
  static bool _instantiated = false;

  static Future<RemoteConfigService> getInstance() async {
    if (!_instantiated) {
      _instance = RemoteConfigService(
        remoteConfig: FirebaseRemoteConfig.instance,
      );
      _instantiated = true;
    }

    return _instance;
  }

  RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  String get appetizerLink => _remoteConfig.getString(APP_LINK);

  bool get isLeaveEnabled =>
      _remoteConfig.getString(IS_LEAVE_ENABLED) == 'true' ? true : false;

  bool get isSwitchEnabled =>
      _remoteConfig.getString(IS_SWITCH_ENABLED) == 'true' ? true : false;

  Future initialise() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 60),
        minimumFetchInterval: Duration(seconds: 0),
      ));
      await _remoteConfig.setDefaults(defaults);
      await _remoteConfig.fetchAndActivate();
    } catch (exception) {
      print(
          'Unable to fetch remote config. Cached or default values will be used');
      print('error : $exception');
    }
  }
}
