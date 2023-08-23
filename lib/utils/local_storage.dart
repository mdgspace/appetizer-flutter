import 'package:appetizer/data/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static late final Box _localStorage;

  static Future<void> init() async {
    if (!kIsWeb) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }

    await Hive.openBox(AppConstants.localDb);
    _localStorage = Hive.box(AppConstants.localDb);
  }

  static setValue({required String key, required dynamic value}) {
    _localStorage.put(key, value);
  }

  static T? getValue<T>(String key) {
    return Hive.isBoxOpen(AppConstants.localDb)
        ? _localStorage.get(key) as T
        : null;
  }
}
