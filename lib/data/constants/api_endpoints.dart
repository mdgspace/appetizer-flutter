import 'package:appetizer/data/constants/env_config.dart';

class ApiEnpoints {
  static const String baseUrl = EnvironmentConfig.BASE_URL;

  static const String checkVersion =
      '/panel/version/expire/{platform}/{versionNumber}';
}
