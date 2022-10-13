import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';


class AppSharedPreferences {
  AppSharedPreferences._();

  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> _setString(String key, String value) async {
    SharedPreferences pref = await _getPreferences();
    await pref.setString(key, value);
  }

  static Future<String> _getString(String key,
      {String defaultValue = ''}) async {
    SharedPreferences pref = await _getPreferences();
    if (pref.containsKey(key)) {
      return pref.getString(key)!;
    } else {
      return defaultValue;
    }
  }

  static Future<void> _setBool(String key, bool value) async {
    SharedPreferences pref = await _getPreferences();
    await pref.setBool(key, value);
  }

  static Future<bool> _getBool(String key, {bool defaultValue = false}) async {
    SharedPreferences pref = await _getPreferences();
    if (pref.containsKey(key)) {
      return pref.getBool(key)!;
    } else {
      return defaultValue;
    }
  }

  static Future<void> setLanguage(String lang) async {
    await _setString("Lang", lang);
  }

  static Future<String> getLanguage() async {
    return await _getString("Lang");
  }

  static Future<void> setMemberID(String id) async {
    await _setString("MemberID", id);
  }

  static Future<String> getMemberID() async {
    return await _getString("MemberID");
  }

  static Future<void> setToken(String token) async {
    await _setString('Token', token);
  }

  static Future<String> getToken() async {
    return await _getString("Token");
  }

  static Future<void> printAll() async {
    debugPrint('pref_ printAll------');
    debugPrint('pref_getLanguage:${await getLanguage()}');
    debugPrint('pref_getMemberID:${await getMemberID()}');
    debugPrint('pref_getToken:${await getToken()}');
  }

}
