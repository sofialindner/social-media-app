import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/data/models/user_model.dart';

class SharedPreferencesHelper {
  static const String _authKey = 'isAuthenticated';
  static const String _userKey = 'user';

  static Future<bool> isAuthenticated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_authKey) ?? false;
  }

  static Future<void> setAuthenticated(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authKey, status);
  }

  static Future<void> setUserData(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, dataJson);
  }

  static Future<User?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(_userKey);

    if (userDataJson != null) {
      // Converte o JSON de volta para Map<String, dynamic>
      Map<String, dynamic> userDataMap = jsonDecode(userDataJson);

      // Cria um objeto User a partir do Map
      return User.fromJson(userDataMap);
    } else {
      return null;
    }
  }

  static Future<void> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
