import 'package:firebase_remote_config/firebase_remote_config.dart';

const String APP_LINK = 'appetizer_link';
const String IS_LEAVE_ENABLED = 'is_leave_enabled';
const String IS_SWITCH_ENABLED = 'is_switch_enabled';

class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{};

  static RemoteConfigService _instance;

  static Future<RemoteConfigService> getInstance() async {
    _instance ??= RemoteConfigService(
      remoteConfig: await RemoteConfig.instance,
    );

    return _instance;
  }

  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  String get appetizerLink => _remoteConfig.getString(APP_LINK);

  bool get isLeaveEnabled =>
      _remoteConfig.getString(IS_LEAVE_ENABLED) == 'true' ? true : false;

  bool get isSwitchEnabled =>
      _remoteConfig.getString(IS_SWITCH_ENABLED) == 'true' ? true : false;

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } on FetchThrottledException catch (exception) {
      // Fetch throttled
      print('Remote config fetch throttled: $exception');
    } catch (exception) {
      print(
          'Unable to fetch remote config. Cached or default values will be used');
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await _remoteConfig.activateFetched();
  }
}
