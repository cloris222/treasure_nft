import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// UI/字體 自適應
class UIDefine {
  static bool _isFirst = false; // 第一次初始化

  static double _statusBarHeight = 0.0; // 狀態列高度
  static double _navigationBarHeight = 0.0; // 導航列高度
  static double _screenWidth = 0.0; // 螢幕寬度
  static double _screenHeight = 0.0; // 螢幕高度
  static double _screenWidthUnit = 0.0; // 螢幕寬度單位
  static double _screenHeightUnit = 0.0; // 螢幕高度單位
  static double _fontUnit = 0.0; // 字型單位

  /// 字型大小
  static double fontSize36 = 0.0;
  static double fontSize34 = 0.0; // 34sp
  static double fontSize32 = 0.0; // 34sp
  static double fontSize30 = 0.0; // 30sp
  static double fontSize28 = 0.0; // 28sp
  static double fontSize26 = 0.0; // 26sp
  static double fontSize24 = 0.0; // 24sp
  static double fontSize22 = 0.0; // 22sp
  static double fontSize20 = 0.0; // 20sp
  static double fontSize18 = 0.0; // 18sp
  static double fontSize16 = 0.0; // 16sp
  static double fontSize14 = 0.0; // 14sp
  static double fontSize12 = 0.0; // 12sp
  static double fontSize10 = 0.0; // 10sp
  static double fontSize8 = 0.0; // 8sp

  /// 初始化
  static void initial(MediaQueryData mediaQueryData) {
    if (_isFirst) {
      return;
    }
    _isFirst = true;
    _statusBarHeight = mediaQueryData.padding.top;
    _navigationBarHeight = mediaQueryData.padding.bottom;
    _screenWidth = mediaQueryData.size.width;
    _screenHeight = mediaQueryData.size.height;

    _screenWidthUnit = _screenWidth / 100;
    _screenHeightUnit =
        (_screenHeight - _statusBarHeight - _navigationBarHeight) / 100;

    _fontUnit = _screenWidthUnit < _screenHeightUnit
        ? _screenWidthUnit
        : _screenHeightUnit;

    /// 算法約為：字體sp / 360 * 100%
    fontSize36 = _getFontSize(10);
    fontSize34 = _getFontSize(9.44);
    fontSize32 = _getFontSize(8.88);
    fontSize30 = _getFontSize(8.33);
    fontSize28 = _getFontSize(7.78);
    fontSize26 = _getFontSize(7.22);
    fontSize24 = _getFontSize(6.67);
    fontSize22 = _getFontSize(6.11);
    fontSize20 = _getFontSize(5.5);
    fontSize18 = _getFontSize(5.0);
    fontSize16 = _getFontSize(4.5);
    fontSize14 = _getFontSize(3.88);
    fontSize12 = _getFontSize(3.33);
    fontSize10 = _getFontSize(3.0);
    fontSize8 = _getFontSize(2.23);

    if (kDebugMode) {
      // Release不顯示
      print("狀態列高度:${_statusBarHeight.toString()}");
      print("導航列高度:${_navigationBarHeight.toString()}");
      print("螢幕寬度:${_screenWidth.toString()}");
      print("螢幕高度:${_screenHeight.toString()}");
      print("螢幕寬度單位:${_screenWidthUnit.toString()}");
      print("螢幕高度單位:${_screenHeightUnit.toString()}");
      print("字型單位:${_fontUnit.toString()}");
    }
  }

  /// 取得狀態列高度
  static double getStatusBarHeight() {
    return _statusBarHeight;
  }

  /// 取得導航列高度
  static double getNavigationBarHeight() {
    return _navigationBarHeight;
  }

  /// 取得螢幕寬度的百分之P, P: 像素 / UI出圖之寬度依據 * 100%
  static double getScreenWidth(double p) {
    double temp = _screenWidthUnit * p;
    return temp;
  }

  /// 取得螢幕高度的百分之P, P: 像素 / UI出圖之高度依據 * 100%
  static double getScreenHeight(double p) {
    double temp = _screenHeightUnit * p;
    return temp;
  }

//  一個除375. 一個除720.
//  getScreenWidth / getScreenHeight.
  static double getPixelWidth(double pixel) {
    return getScreenWidth(pixel / 375 * 100);
  }

  static double getPixelHeight(double pixel) {
    return getScreenHeight(pixel / 720 * 100);
  }

  /// 取得字型大小
  static double _getFontSize(double fontSizeDefine) {
    double temp = _fontUnit * fontSizeDefine;
    return temp;
  }

  /// get screen width
  static double getWidth() {
    return _screenWidth;
  }

  /// get screen height
  static double getHeight() {
    return _screenHeight;
  }
}
