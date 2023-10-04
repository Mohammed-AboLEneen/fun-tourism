import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences prefs;

  static Future<void> initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool? getBool({required String key}) {
    return prefs.getBool(key);
  }

  static Future<void> setBool(
      {required String key, required bool value}) async {
    await prefs.setBool(key, value);
  }

  static Future<void> setString(
      {required String key, required String value}) async {
    await prefs.setString(key, value);
  }

  static String? getString({required String key}) {
    return prefs.getString(key);
  }
}
