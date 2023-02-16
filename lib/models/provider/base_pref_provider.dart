import 'package:flutter/widgets.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';

/// for 需要暫存的Provider使用
abstract class BasePrefProvider {
  /// 定義此SharedPreferencesKey
  String setKey();

  /// 定義此provider 是否為user相關資料
  /// 如果為true，則會在使用者登出後自動清除
  bool setUserTemporaryValue();

  /// 設定初始值
  Future<void> initValue();

  /// 讀取 SharedPreferencesKey 內容並轉成對應值
  Future<void> readSharedPreferencesValue();

  /// 讀取 API值
  Future<void> readAPIValue();

  String getSharedPreferencesKey() {
    return '${setKey()}${setUserTemporaryValue() ? "_tmp" : ""}';
  }

  Future<void> init() async {
    if (await AppSharedPreferences.checkKey(getSharedPreferencesKey())) {
      await readSharedPreferencesValue();
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      await initValue();
    }
    update();
  }

  Future<void> update() async {
    await readAPIValue();
  }
}
