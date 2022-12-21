import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/models/http/parameter/check_level_info.dart';

import '../models/http/parameter/check_experience_info.dart';
import '../models/http/parameter/country_phone_data.dart';
import '../models/http/parameter/sign_in_data.dart';
import '../models/http/parameter/user_info_data.dart';
import '../models/http/parameter/user_order_info.dart';
import '../models/http/parameter/user_property.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import '../widgets/changenotifiers/bottom_navigation_notifier.dart';

class GlobalData {
  GlobalData._();

  static String urlPrefix = 'https://treasurenft.xyz/';

  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static bool firstLaunch = true;
  static const double navigationBarPadding = kBottomNavigationBarHeight * 1.1;
  static List<CountryPhoneData> country = [];

  static printLog(String? logMessage) {
    if (HttpSetting.debugMode) {
      debugPrint(logMessage);
    }
  }

  ///MARK: 判斷是否為要顯示登入動畫
  static bool showLoginAnimate = false;

  ///MARK: 如果有值就顯示簽到畫面
  static SignInData? signInInfo;

  ///MARK: 使用者相關資料
  static UserInfoData userInfo = UserInfoData();
  static ExperienceInfo experienceInfo = ExperienceInfo();
  static String userToken = '';
  static String userMemberId = '';

  ///MARK: 控管bar的圖案顯示
  static AppNavigationBarType mainBottomType = AppNavigationBarType.typeMain;

  ///MARK: 提供給選擇日期使用
  static String strDataPickerStart = '';
  static String strDataPickerEnd = '';

  ///MARK: 暫存區
  static CheckLevelInfo? userLevelInfo; //查詢等級資訊
  static UserProperty? userProperty; //查詢資產
  static UserOrderInfo? userOrderInfo; //取得訂單記數資訊
  static double? totalIncome; // 查詢收益明細 “裡面的總收入”
  static Map<String, dynamic>? userWalletInfo;

  ///MARK: Notifier監聽
  static BottomNavigationNotifier bottomNavigationNotifier =
      BottomNavigationNotifier();

  ///MARK: Stomp 控管用
  static bool bShowBuySuccessAnimate = false; //控管目前是否有顯示中獎
}
