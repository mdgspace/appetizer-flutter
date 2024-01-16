import 'package:appetizer/data/constants/env_config.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixpanelManager {
  static Mixpanel? instance;

  static Future<Mixpanel> init() async {
    instance ??= await Mixpanel.init(EnvironmentConfig.MIXPANEL_PROJECT_KEY,
        trackAutomaticEvents: true);
    return instance!;
  }
}
