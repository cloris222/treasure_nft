import 'package:treasure_nft_project/constant/call_back_function.dart';
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

  /// 初始化Provider
  Future<void> initProvider();

  /// 讀取 SharedPreferencesKey 內容並轉成對應值
  Future<void> readSharedPreferencesValue();

  /// 將 內容 存入 SharedPreferencesKey
  Future<void> setSharedPreferencesValue();

  /// 讀取 API值
  Future<void> readAPIValue();

  String getSharedPreferencesKey() {
    return '${setKey()}${setUserTemporaryValue() ? "_tmp" : ""}';
  }

  Future<void> init({onClickFunction? onFinish}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    await initProvider();
    if (await AppSharedPreferences.checkKey(getSharedPreferencesKey())) {
      await readSharedPreferencesValue();
    } else {
      await initValue();
    }
    if (onFinish != null) {
      onFinish();
    }
    update(onFinish: onFinish);
  }

  Future<void> update({onClickFunction? onFinish}) async {
    await readAPIValue();
    if (onFinish != null) {
      onFinish();
    }
    setSharedPreferencesValue();
  }
}
