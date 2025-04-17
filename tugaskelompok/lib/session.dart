// session.dart
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _isLoggedIn = 'is_logged_in';

  static Future<void> saveLoginSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedIn, true);
  }

  static Future<void> clearLoginSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedIn);
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedIn) ?? false;
  }
}
