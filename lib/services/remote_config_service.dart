import 'package:firebase_remote_config/firebase_remote_config.dart';

const String APPI_VERSION = 'appetizer_flutter_version';
const String GOOGLE_PLAY_LINK = 'appetizer_flutter_play_link';

class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{
    APPI_VERSION: '2.0.0',
    GOOGLE_PLAY_LINK: ''
  };

  static RemoteConfigService _instance;

  static Future<RemoteConfigService> getInstance() async {
    _instance ??= RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );

    return _instance;
  }

  RemoteConfigService({RemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  String get appetizerVersion => _remoteConfig.getString(APPI_VERSION);

  String get googlePlayLink => _remoteConfig.getString(GOOGLE_PLAY_LINK);

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
