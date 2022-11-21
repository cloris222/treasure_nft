// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:format/format.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/models/data/trade_model_data.dart';
import 'package:treasure_nft_project/models/http/api/order_api.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/views/full_animation_page.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/notify/notify_level_up_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/image_dialog.dart';

import '../constant/call_back_function.dart';
import '../constant/enum/setting_enum.dart';
import '../constant/global_data.dart';
import '../constant/theme/app_animation_path.dart';
import '../constant/theme/app_colors.dart';
import '../models/http/api/common_api.dart';
import '../models/http/api/trade_api.dart';
import '../models/http/api/wallet_api.dart';
import '../models/http/http_setting.dart';
import '../models/http/parameter/api_response.dart';
import '../models/http/parameter/sign_in_data.dart';
import '../utils/app_shared_Preferences.dart';
import '../utils/date_format_util.dart';
import '../utils/stomp_socket_util.dart';
import '../utils/trade_timer_util.dart';
import '../widgets/dialog/simple_custom_dialog.dart';

class BaseViewModel {
  BuildContext getGlobalContext() {
    return GlobalData.globalKey.currentContext!;
  }

  void showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void buildHttpOnFail(BuildContext context, String errorMessage) {
    showToast(context, tr(errorMessage));
  }

  void copyText({required String copyText}) {
    Clipboard.setData(ClipboardData(text: copyText));
  }

  void clearAllFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  ///MARK: 推頁面 偷懶用
  void popPage(BuildContext context) {
    Navigator.pop(context);
  }

  ///MARK: 推新的一頁
  Future<void> pushPage(BuildContext context, Widget page) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  ///MARK: 取代當前頁面
  Future<void> pushReplacement(BuildContext context, Widget page) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  ///MARK: 將前面的頁面全部清除只剩此頁面
  Future<void> pushAndRemoveUntil(BuildContext context, Widget page) async {
    await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => page),
      (route) => false,
    );
  }

  ///MARK: 全域切頁面
  Future<void> globalPushAndRemoveUntil(Widget page) async {
    GlobalData.globalKey.currentState?.pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (BuildContext context) => page),
      (route) => false,
    );
  }

  Future<void> pushOtherPersonalInfo(
      BuildContext context, String userId) async {
    // test
    // await pushPage(context, OtherPersonInfoPage(userId: userId));
  }

  ///MARK: 推透明的頁面
  Future<void> pushOpacityPage(BuildContext context, Widget page) async {
    await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        },
        opaque: false));
  }

  ///MARK: 更新使用者資料
  Future<void> saveUserLoginInfo({required ApiResponse response}) async {
    await AppSharedPreferences.setLogIn(true);
    await AppSharedPreferences.setMemberID(response.data['id']);
    await AppSharedPreferences.setToken(response.data['token']);
    GlobalData.userToken = response.data['token'];
    GlobalData.userMemberId = response.data['id'];

    await uploadPersonalInfo();
    await uploadSignInInfo();
    uploadTemporaryData();

    AppSharedPreferences.printAll();
  }

  ///MARK: 使用者資料
  Future<bool> uploadPersonalInfo() async {
    ///MARK: 判斷有無讀取失敗
    bool connectFail = false;
    onFail(message) => connectFail = true;

    List<bool> checkList = List<bool>.generate(2, (index) => false);

    UserInfoAPI(onConnectFail: onFail)
        .getPersonInfo()
        .then((value) => checkList[0] = true);
    TradeAPI(onConnectFail: onFail)
        .getExperienceInfoAPI()
        .then((value) => checkList[1] = true);

    await checkFutureTime(
        logKey: 'uploadPersonalInfo',
        onCheckFinish: () => !checkList.contains(false) || connectFail);

    ///MARK: 判斷有無讀取失敗
    return !connectFail;
  }

  ///MARK: 更新簽到資料
  Future<bool> uploadSignInInfo() async {
    ///MARK: 判斷有無讀取失敗
    bool connectFail = false;
    onFail(message) => connectFail = true;

    if (GlobalData.userInfo.level == 0 ||
        GlobalData.experienceInfo.isExperience) {
      GlobalData.signInInfo = null;
      return !connectFail;
    }
    SignInData signInInfo =
        await UserInfoAPI(onConnectFail: onFail).getSignInInfo();
    if (!signInInfo.isFinished) {
      GlobalData.signInInfo = signInInfo;
    } else {
      GlobalData.signInInfo = null;
    }
    return !connectFail;
  }

  ///MARK: 更新簽到資料
  Future<void> setSignIn(BuildContext context) async {
    await UserInfoAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .setSignIn();
    SimpleCustomDialog(context,
            mainText: tr('signSuccessfully'), isSuccess: true)
        .show();
  }

  ///MARK: 登出使用者資料
  Future<void> clearUserLoginInfo() async {
    await AppSharedPreferences.setLogIn(false);
    await AppSharedPreferences.setMemberID('');
    await AppSharedPreferences.setToken('');
    await clearTemporaryData();
    GlobalData.userToken = '';
    GlobalData.userMemberId = '';
    GlobalData.userInfo = UserInfoData();
    GlobalData.showLoginAnimate = false;
    GlobalData.signInInfo = null;
    stopUserListener();
  }

  ///MARK: 登入後-更新暫存資料
  Future<bool> uploadTemporaryData() async {
    ///MARK: 判斷有無讀取失敗
    bool connectFail = false;
    onFail(message) => connectFail = true;

    ///MARK: 需檢查的項目數量
    List<bool> checkList = List<bool>.generate(7, (index) => false);

    ///MARK: 同步更新
    UserInfoAPI(onConnectFail: onFail)
        .getCheckLevelInfoAPI()
        .then((value) => checkList[0] = true);
    UserInfoAPI(onConnectFail: onFail)
        .getUserPropertyInfo()
        .then((value) => checkList[1] = true);
    UserInfoAPI(onConnectFail: onFail)
        .getUserOrderInfo()
        .then((value) => checkList[2] = true);
    OrderAPI(onConnectFail: onFail)
        .saveTempTotalIncome()
        .then((value) => checkList[3] = true);
    WalletAPI(onConnectFail: onFail)
        .getBalanceRecharge()
        .then((value) => checkList[4] = true);
    WalletAPI(onConnectFail: onFail)
        .getBalanceRecord()
        .then((value) => checkList[5] = true);
    OrderAPI(onConnectFail: onFail)
        .saveTempRecord()
        .then((value) => checkList[6] = true);

    ///MARK: 等待更新完成
    await checkFutureTime(
        logKey: 'uploadTemporaryData',
        onCheckFinish: () => !checkList.contains(false) || connectFail);
    return !connectFail;
  }

  ///MARK: 登出後-清除暫存資料
  Future<void> clearTemporaryData() async {
    GlobalData.userLevelInfo = null;
    GlobalData.userProperty = null;
    GlobalData.userOrderInfo = null;
    GlobalData.totalIncome = 0.0;
    GlobalData.userWalletInfo = null;
    AppSharedPreferences.setProfitRecord([]);
    AppSharedPreferences.setWalletRecord([]);
  }

  ///MARK: 當token 為空時，代表未登入
  bool isLogin() {
    return GlobalData.userToken.isNotEmpty;
  }

  String getLoginTimeAnimationPath() {
    /*
    * 5:00 -12:00   早
      12:00 - 18:00 午
      18:00 - 5:00  晚
    * */
    String time = DateFormatUtil().getNowTimeWith24HourFormat();
    if (time.compareTo("05:00") >= 0 && time.compareTo("12:00") < 0) {
      return AppAnimationPath.loginMorning;
    } else if (time.compareTo("12:00") >= 0 && time.compareTo("18:00") < 0) {
      return AppAnimationPath.loginAfternoon;
    }
    return AppAnimationPath.loginNight;
  }

  ///MARK: 通用的 單一彈錯視窗
  onBaseConnectFail(BuildContext context, String message) {
    SimpleCustomDialog(context, mainText: message, isSuccess: false).show();
  }

  /// 自動轉換數字為 K & M
  String numberCompatFormat(String value, {int decimalDigits = 2}) {
    if (value == '') {
      return '';
    }
    var formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      locale: 'en_US',
      symbol: '',
    ).format(double.parse(value));

    return formattedNumber;
  }

  ///MARK: 使用者監聽
  void startUserListener() {
    debugPrint('---startUserListener');
    StompSocketUtil().connect(onConnect: _onStompConnect);
    TradeTimerUtil().addListener(_onTradeTimerListener);
    TradeTimerUtil().start();
  }

  ///MARK: 關閉使用者監聽
  void stopUserListener() {
    debugPrint('---stopUserListener');
    StompSocketUtil().disconnect();
    TradeTimerUtil().removeListener(_onTradeTimerListener);
    TradeTimerUtil().stop();
  }

  void _onStompConnect(StompFrame frame) {
    ///MARK: 顯示購買成功
    StompSocketUtil().stompClient!.subscribe(
          destination: '/user/notify/${GlobalData.userMemberId}',
          callback: (frame) {
            debugPrint('${StompSocketUtil().key} ${frame.body}');
            var result = json.decode(frame.body!);
            if (result['toUserId'] == GlobalData.userMemberId) {
              showBuySuccessAnimate();
            }
          },
        );

    ///MARK: 升等通知
    StompSocketUtil().stompClient!.subscribe(
          destination: '/user/levelUp/${GlobalData.userMemberId}',
          callback: (frame) {
            debugPrint('${StompSocketUtil().key} ${frame.body}');
            var result = json.decode(frame.body!);
            if (result['toUserId'] == GlobalData.userMemberId) {
              showLevelUpAnimate(result['oldLevel'], result['newLevel']);
            }
          },
        );
  }

  void showBuySuccessAnimate() async {
    await pushOpacityPage(
        getGlobalContext(),
        const FullAnimationPage(
            animationPath: AppAnimationPath.buyNFTSuccess, limitTimer: 4));
    ImageDialog(
      getGlobalContext(),
      mainText: tr('buy_remind_title'),
      subText: tr('buy_remind_content'),
      buttonText: tr('gotoPost'),
      assetImagePath: AppImagePath.notifyGift,
      callOkFunction: () {
        pushAndRemoveUntil(getGlobalContext(),
            const MainPage(type: AppNavigationBarType.typeCollection));
      },
    ).show();
  }

  void showLevelUpAnimate(int oldLevel, int newLevel) async {
    await pushOpacityPage(getGlobalContext(),
        NotifyLevelUpPage(oldLevel: oldLevel, newLevel: newLevel));

    ///MARK: 顯示彈窗
    if (oldLevel == 0 && newLevel == 1) {
      ImageDialog(
        getGlobalContext(),
        mainText: tr('lv_remind_title'),
        subText: tr('lv_remind_content'),
        buttonText: tr('gotoUse'),
        assetImagePath: AppImagePath.notifyGift,
        callOkFunction: () {
          pushAndRemoveUntil(getGlobalContext(),
              const MainPage(type: AppNavigationBarType.typeTrade));
        },
      ).show();
    }

    ///MARK: 儲金罐動畫
    else {
      pushOpacityPage(
          getGlobalContext(),
          FullAnimationPage(
              animationPath: AppAnimationPath.showCoinJar,
              limitTimer: 3,
              backgroundColor: AppColors.jarCoinBg.withOpacity(0.8)));
    }
  }

  ///MARK: 倒數五分鐘顯示開賣中動畫
  void _onTradeTimerListener(TradeData data) {
    if (data.duration == const Duration(minutes: 5)) {
      pushOpacityPage(
          getGlobalContext(),
          const FullAnimationPage(
              animationPath: AppAnimationPath.showWaitSell, limitTimer: 4));
    }
  }

  String getStartTime(String startDate) {
    return startDate.isNotEmpty
        ? changeTimeZone('$startDate 00:00:00',
            isSystemTime: false, isApiValue: true)
        : '';
  }

  String getEndTime(String endDate) {
    return endDate.isNotEmpty
        ? changeTimeZone('$endDate 23:59:59',
            isSystemTime: false, isApiValue: true)
        : '';
  }

  /// 2022-08-30 14:43:22
  /// changeLocalTime:true -> system time to local time
  /// changeLocalTime:false -> local time to system time
  /// isShowGmt control (+XX:XX)
  /// isApiValue :true ->2022-08-30 14:43:22
  String changeTimeZone(
    String strTime, {
    String? setSystemZone,
    bool isSystemTime = true,
    bool isApiValue = false,
    bool isShowGmt = false,
    String strGmtFormat = '(GMT{}{:02d}:00) ',
    String strFormat = '',
  }) {
    if(strTime.isEmpty){
      return "";
    }
    var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime time = dateFormat.parse(strTime);

    ///MARK: 計算
    int systemZone = getZone(setSystemZone ?? HttpSetting.systemTimeZone);
    int localZone = getZone(GlobalData.userInfo.zone);
    if (isSystemTime) {
      ///MARK: 把時間轉成 GMT+0
      time = time.subtract(Duration(hours: systemZone));

      ///MARK: 把時間轉成 使用者時區
      time = time.add(Duration(hours: localZone));
    } else {
      ///MARK: 把時間轉成 GMT+0
      time = time.subtract(Duration(hours: localZone));

      ///MARK: 把時間轉成 系統時區
      time = time.add(Duration(hours: systemZone));
    }

    return isApiValue
        ? DateFormatUtil().getFullWithDateFormat(time)
        : '${isShowGmt ? format(strGmtFormat, localZone > 0 ? '+' : '', localZone) : ''}${strFormat.isEmpty ? DateFormatUtil().getFullWithDateFormat2(time) : DateFormatUtil().buildFormat(strFormat: strFormat, time: time)}';
  }

  int getZone(String gmt) {
    return (gmt.contains('GMT+') ? 1 : -1) *
        int.parse(gmt.substring(4, (gmt.length > 6) ? 6 : null));
  }

  ///查詢國家列表
  Future<void> getCountry() async {
    await CommonAPI().getCountryList().then((value) {
      GlobalData.country.clear();
      GlobalData.country.addAll(value);
    });
  }

  /// 簡易timer
  Future<void> checkFutureTime(
      {required onReturnBoolFunction onCheckFinish,
      Duration timeOut = const Duration(seconds: 30),
      String logKey = 'checkFutureTime',
      bool printLog = true}) async {
    if (printLog) debugPrint('$logKey: ---timeStart!!!!');
    while (timeOut.inSeconds > 0) {
      await Future.delayed(const Duration(milliseconds: 500));
      timeOut = timeOut - const Duration(microseconds: 500);
      if (onCheckFinish()) {
        if (printLog) debugPrint('$logKey: ---timeFinish!!!!');
        return;
      }
    }
    if (printLog) debugPrint('$logKey: ---timeOut!!!!');
  }
}
