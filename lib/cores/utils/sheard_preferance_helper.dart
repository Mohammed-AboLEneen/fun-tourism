import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences prefs;

  static Future<void> initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool? getBool({required String key}) {
    return prefs.getBool(key);
  }

  Future<void> setBool({required String key, required bool value}) async {
    await prefs.setBool(key, value);
  }

  Future<void> setString({required String key, required String value}) async {
    await prefs.setString(key, value);
  }

  String? getString({required String key}) {
    return prefs.getString(key);
  }
}
