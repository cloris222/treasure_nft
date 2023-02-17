import '../constant/call_back_function.dart';
import '../utils/app_shared_Preferences.dart';

abstract class BaseListProvider {
  /// 定義此SharedPreferencesKey
  String setKey();

  /// 定義此provider 是否為user相關資料
  /// 如果為true，則會在使用者登出後自動清除
  bool setUserTemporaryValue();

  /// 設定初始值
  Future<void> initValue();

  /// 讀取 SharedPreferencesKey 內容並轉成對應值
  Future<void> readSharedPreferencesValue();

  /// 將 內容 存入 SharedPreferencesKey
  Future<void> setSharedPreferencesValue(List list) async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(list.map((x) => x.toJson())));
  }

  void addList(List data);
  void clearList();

  String getSharedPreferencesKey() {
    return '${setKey()}${setUserTemporaryValue() ? "_tmp" : ""}';
  }

  Future<void> init({onClickFunction? onFinish}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (await AppSharedPreferences.checkKey(getSharedPreferencesKey())) {
      await readSharedPreferencesValue();
    } else {
      await initValue();
    }
    if (onFinish != null) {
      onFinish();
    }
  }
}
