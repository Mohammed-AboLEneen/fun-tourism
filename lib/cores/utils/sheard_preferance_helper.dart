import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences prefs;

  static Future<void> initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  String s = 'momomomo';
  bool? getBool({required String key}) {
    return prefs.getBool(key);
  }

  Future<void> setBool({required String key, required bool value}) async {
    await prefs.setBool(key, value);
  }
}
