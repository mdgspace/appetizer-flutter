import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  final PackageInfo _packageInfo;
  final defaults = <String, dynamic>{};

  static PackageInfoService _instance;

  static Future<PackageInfoService> getInstance() async {
    _instance ??= PackageInfoService(
      packageInfo: await PackageInfo.fromPlatform(),
    );

    return _instance;
  }

  PackageInfoService({PackageInfo packageInfo}) : _packageInfo = packageInfo;

  String get version => _packageInfo.version;
}
