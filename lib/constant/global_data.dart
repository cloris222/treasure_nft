import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/check_level_info.dart';

import '../models/http/parameter/check_experience_info.dart';
import '../models/http/parameter/country_phone_data.dart';
import '../models/http/parameter/sign_in_data.dart';
import '../models/http/parameter/user_info_data.dart';
import '../widgets/app_bottom_navigation_bar.dart';

class GlobalData {
  GlobalData._();

  static String urlPrefix = 'https://treasurenft.xyz/';

  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static bool firstLaunch = true;
  static const double navigationBarPadding = kBottomNavigationBarHeight * 1.1;
  static List<CountryPhoneData> country = [];

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
}
