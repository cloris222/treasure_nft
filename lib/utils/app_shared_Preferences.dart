import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';

import '../models/http/parameter/check_earning_income.dart';
import '../views/wallet/data/BalanceRecordResponseData.dart';

class AppSharedPreferences {
  AppSharedPreferences._();

  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> checkKey(String key, {SharedPreferences? pref}) async {
    pref ??= await _getPreferences();
    return pref.containsKey(key);
  }

  static Future<void> _setString(String key, String value) async {
    SharedPreferences pref = await _getPreferences();
    await pref.setString(key, value);
  }

  static Future<String> _getString(String key,
      {String defaultValue = ''}) async {
    SharedPreferences pref = await _getPreferences();
    if (await checkKey(key, pref: pref)) {
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
    if (await checkKey(key, pref: pref)) {
      return pref.getBool(key)!;
    } else {
      return defaultValue;
    }
  }

  static Future<void> _setJson(String key, dynamic value) async {
    await _setString(key, json.encode(value).toString());
  }

  static Future<dynamic> _getJson(String key) async {
    SharedPreferences pref = await _getPreferences();
    if (await checkKey(key, pref: pref)) {
      return json.decode(pref.getString(key)!);
    } else {
      return null;
    }
  }

  ///MARK: ----使用者設定 start ----

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

  /// MARK: 判斷是否登入過
  static Future<void> setLogIn(bool isLogIn) async {
    await _setBool("LogIn", isLogIn);
  }

  static Future<bool> getLogIn() async {
    return await _getBool("LogIn");
  }

  static Future<void> printAll() async {
    debugPrint('pref_ printAll------');
    debugPrint('pref_getLanguage:${await getLanguage()}');
    debugPrint('pref_getMemberID:${await getMemberID()}');
    debugPrint('pref_getToken:${await getToken()}');
    debugPrint('pref_getLogIn:${await getLogIn()}');
  }

  ///MARK: ----使用者設定 end ----

  ///MARK: ----暫存相關 start ----

  ///MARK: 錢包紀錄 WalletRecord
  static Future<void> setWalletRecord(
      List<BalanceRecordResponseData> list) async {
    await _setJson(
        "WalletRecord", List<dynamic>.from(list.map((x) => x.toJson())));
  }

  static Future<List<BalanceRecordResponseData>> getWalletRecord() async {
    var json = await _getJson("WalletRecord");
    if (json == null) {
      return [];
    }
    return List<BalanceRecordResponseData>.from(
        json.map((x) => BalanceRecordResponseData.fromJson(x)));
  }

  ///MARK: 收益明細 ProfitRecord
  static Future<void> setProfitRecord(List<CheckEarningIncomeData> list) async {
    await _setJson(
        "ProfitRecord", List<dynamic>.from(list.map((x) => x.toJson())));
  }

  static Future<List<CheckEarningIncomeData>> getProfitRecord() async {
    var json = await _getJson("ProfitRecord");
    if (json == null) {
      return [];
    }
    return List<CheckEarningIncomeData>.from(
        json.map((x) => CheckEarningIncomeData.fromJson(x)));
  }

  ///MARK: ----暫存相關 end ----
}
