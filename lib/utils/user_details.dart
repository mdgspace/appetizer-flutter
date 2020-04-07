import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsUtils {
  static Future<SharedPreferences> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
