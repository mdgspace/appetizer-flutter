import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  final PackageInfo _packageInfo;
  final defaults = <String, dynamic>{};

  static late PackageInfoService _instance;
  static bool _instantiated = false;

  static Future<PackageInfoService> getInstance() async {
    if (!_instantiated) {
      _instance = PackageInfoService(
        packageInfo: await PackageInfo.fromPlatform(),
      );
      _instantiated = true;
    }

    return _instance;
  }

  PackageInfoService({required PackageInfo packageInfo})
      : _packageInfo = packageInfo;

  String get version => _packageInfo.version;
}
