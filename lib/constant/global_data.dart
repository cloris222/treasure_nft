import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/utils/observer_pattern/subject.dart';

import '../models/http/parameter/announce_data.dart';
import '../models/http/parameter/country_phone_data.dart';
import '../models/http/parameter/sign_in_data.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import '../widgets/changenotifiers/bottom_navigation_notifier.dart';
import '../widgets/changenotifiers/reserve_success_notifier.dart';
import '../widgets/changenotifiers/sell_success_notifier.dart';
import 'enum/server_route_enum.dart';

class GlobalData {
  GlobalData._();

  static String urlPrefix = 'https://treasurenft.xyz/';

  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static bool firstLaunch = true;
  static List<CountryPhoneData> country = [];

  static printLog(String? logMessage) {
    if (HttpSetting.printDebugLog) {
      debugPrint(logMessage);
    }
  }

  static isDebugMode() {
    return HttpSetting.debugMode;
  }

  ///MARK: APP所使用的線路
  static ServerRoute appServerRoute = ServerRoute.routeXyz;

  ///MARK: 判斷是否為要顯示登入動畫
  static bool showLoginAnimate = false;

  ///MARK: 如果有值就顯示簽到畫面
  static SignInData? signInInfo;
  static bool needUpdateApp = false;

  ///MARK: 使用者相關資料
  // static UserInfoData userInfo = UserInfoData();
  // static ExperienceInfo experienceInfo = ExperienceInfo();
  static String userToken = '';
  static String userMemberId = '';
  static String userZone = 'GMT+8';
  static bool isAirDrop=false;

  ///MARK: 控管bar的圖案顯示
  static bool isPrePage = false;
  static AppNavigationBarType mainBottomType = AppNavigationBarType.typeMain;
  static List<AppNavigationBarType> preTypeList = [];

  ///MARK: 提供給選擇日期使用
  static String strDataPickerStart = '';
  static String strDataPickerEnd = '';

  ///MARK: 暫存區


  ///MARK: Notifier監聽
  static BottomNavigationNotifier bottomNavigationNotifier =
      BottomNavigationNotifier();

  static SellSuccessNotifier sellSuccessNotifier =
  SellSuccessNotifier();

  static ReserveSuccessNotifier reserveSuccessNotifier =
  ReserveSuccessNotifier();

  ///MARK: Stomp 控管用
  static bool bShowBuySuccessAnimate = false; //控管目前是否有顯示中獎

  /// 交易頁的Enter按鈕是否顯示
  static bool appTradeEnterButtonStatus = false;

  ///MARK: 控管語言切換的
  static Subject languageSubject = Subject();

  /// MARK: 控管讀取頁面的
  static Subject loadingSubject = Subject();

  ///MARK: 判斷是否有進行綁定動作
  static bool passBindWalletAction = false;

  ///MARK: 最新公告
  static AnnounceData lastAnnounce = AnnounceData();

}
