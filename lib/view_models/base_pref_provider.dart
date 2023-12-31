import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';

/// for 需要暫存的Provider使用
abstract class BasePrefProvider {
  DateTime? _updateTime;
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
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail});

  void printLog(String log) {
    if (false) {
      GlobalData.printLog('BasePrefProvider_${setKey()}:$log');
    }
  }

  String getSharedPreferencesKey() {
    return '${setKey()}${setUserTemporaryValue() ? "_tmp" : ""}';
  }

  ///MARK: 先讀暫存或預設值 後讀api更新值
  Future<void> init(
      {onClickFunction? onFinish,
      onClickFunction? onUpdateFinish,
      ResponseErrorFunction? onConnectFail,
      bool needFocusUpdate = false,
      }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    printLog("initProvider");
    await initProvider();

    if (await AppSharedPreferences.checkKey(getSharedPreferencesKey())) {
      printLog("readSharedPreferencesValue");
      await readSharedPreferencesValue();
    } else {
      printLog("initValue");
      await initValue();
    }
    if (onFinish != null) {
      onFinish();
    }
    printLog("update");
    update(
        onFinish: onFinish,
        onUpdateFinish: onUpdateFinish,
        onConnectFail: onConnectFail,
        needFocusUpdate:needFocusUpdate,
    );
  }
  Future<void> update(
      {onClickFunction? onFinish,
      onClickFunction? onUpdateFinish,
      ResponseErrorFunction? onConnectFail,
      bool needFocusUpdate = false,
      }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    printLog("readAPIValue");

    if (_checkUpdateTime(needFocusUpdate)) {
      await readAPIValue(onConnectFail: onConnectFail);
      if (onFinish != null) {
        onFinish();
      }
      if (onUpdateFinish != null) {
        onUpdateFinish();
      }
      printLog("setSharedPreferencesValue");
      setSharedPreferencesValue();
    }
  }

  /// 判斷是否要更新
  bool _checkUpdateTime(bool needFocusUpdate) {
    /// 使用者相關資訊 不受一分鐘限制
    if (setUserTemporaryValue()) {
      printLog("_checkUpdateTime: is user data");
      return true;
    } else {
      /// 需過一分鐘後才更新
      DateTime now = DateTime.now();
      if (_updateTime == null) {
        _updateTime = now;
        printLog("_checkUpdateTime: is null");
        return true;
      } else {
        Duration duration = now.difference(_updateTime!);
        printLog("_checkUpdateTime: duration ${duration.inSeconds}s");
        if (duration.inSeconds > 60 || needFocusUpdate) {
          _updateTime = now;
          printLog("_checkUpdateTime: update time true");
          return true;
        } else {
          printLog("_checkUpdateTime: update time false");
          return false;
        }
      }
    }
  }
}
