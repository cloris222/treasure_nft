// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:treasure_nft_project/models/data/trade_model_data.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/utils/animation_download_util.dart';
import 'package:treasure_nft_project/views/airdrop/airdrop_get_box_page.dart';
import 'package:treasure_nft_project/views/collection/api/collection_api.dart';
import 'package:treasure_nft_project/views/full_animation_page.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/notify/notify_level_up_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/level_up_one_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

import '../constant/call_back_function.dart';
import '../constant/enum/airdrop_enum.dart';
import '../constant/global_data.dart';
import '../constant/theme/app_animation_path.dart';
import '../constant/theme/app_colors.dart';
import '../models/http/api/common_api.dart';
import '../models/http/api/wallet_connect_api.dart';
import '../models/http/http_setting.dart';
import '../models/http/parameter/airdrop_box_reward.dart';
import '../models/http/parameter/api_response.dart';
import '../models/http/parameter/sign_in_data.dart';
import '../utils/app_shared_Preferences.dart';
import '../utils/date_format_util.dart';
import '../utils/stomp_socket_util.dart';
import '../utils/trade_timer_util.dart';
import '../views/airdrop/airdrop_open_page.dart';
import '../widgets/dialog/reward_notify_dialog.dart';
import '../widgets/dialog/simple_custom_dialog.dart';
import 'control_router_viem_model.dart';
import 'gobal_provider/user_experience_info_provider.dart';
import 'gobal_provider/user_info_provider.dart';
import 'gobal_provider/user_trade_status_provider.dart';

class BaseViewModel with ControlRouterViewModel {
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

  ///MARK: 更新使用者資料
  Future<void> saveUserLoginInfo(
      {required bool isLogin,
      required ApiResponse response,
      required WidgetRef ref}) async {
    await AppSharedPreferences.setLogIn(true);
    await AppSharedPreferences.setMemberID(response.data['id']);
    await AppSharedPreferences.setToken(response.data['token']);
    GlobalData.userToken = response.data['token'];
    GlobalData.userMemberId = response.data['id'];

    await uploadPersonalInfo(isLogin: isLogin, ref: ref);
    await uploadSignInInfo(ref: ref);

    AppSharedPreferences.printAll();
  }

  ///MARK: 使用者資料
  Future<bool> uploadPersonalInfo(
      {required bool isLogin, required WidgetRef ref}) async {
    ///MARK: 判斷有無讀取失敗
    bool connectFail = false;
    onFail(message) => connectFail = true;

    List<bool> checkList = List<bool>.generate(3, (index) => false);

    if (isLogin) {
      ///MARK: 直接強迫API更新
      ref
          .watch(userInfoProvider.notifier)
          .update(onConnectFail: onFail, onFinish: () => checkList[0] = true);
      ref
          .watch(userExperienceInfoProvider.notifier)
          .update(onConnectFail: onFail, onFinish: () => checkList[1] = true);
      ref
          .watch(userTradeStatusProvider.notifier)
          .update(onConnectFail: onFail, onFinish: () => checkList[2] = true);

      await checkFutureTime(
          logKey: 'uploadPersonalInfo',
          onCheckFinish: () => !checkList.contains(false) || connectFail);

      ///MARK: 判斷有無讀取失敗
      return !connectFail;
    } else {
      ///MARK: 後更新 頁面自動更新資料
      ref.watch(userInfoProvider.notifier).init(onConnectFail: onFail);
      ref
          .watch(userExperienceInfoProvider.notifier)
          .init(onConnectFail: onFail);
      ref.watch(userTradeStatusProvider.notifier).init(onConnectFail: onFail);
      return true;
    }
  }

  ///MARK: 更新簽到資料
  Future<bool> uploadSignInInfo({required WidgetRef ref}) async {
    ///MARK: 判斷有無讀取失敗
    bool connectFail = false;
    onFail(message) => connectFail = true;

    if (ref.read(userInfoProvider).level == 0 ||
        ref.read(userExperienceInfoProvider).isExperience) {
      GlobalData.signInInfo = null;
      return !connectFail;
    }
    try {
      SignInData signInInfo =
          await UserInfoAPI(onConnectFail: onFail).getSignInInfo();
      if (!signInInfo.isFinished) {
        GlobalData.signInInfo = signInInfo;
      } else {
        GlobalData.signInInfo = null;
      }
    } catch (e) {
      GlobalData.signInInfo = null;
    }
    return !connectFail;
  }

  ///MARK: 更新簽到資料
  Future<void> setSignIn(BuildContext context) async {
    await UserInfoAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .setSignIn();
    await SimpleCustomDialog(context,
            mainText: tr('signSuccessfully'), isSuccess: true)
        .show();
  }

  ///MARK: 取得收藏未讀通知數(需要補餘額的count)
  Future<num> requestUnreadCollection() async {
    ///MARK: 偷偷把log關閉
    return await CollectionApi(
            printLog: false,
            onConnectFail: (errorMessage) {
              ///MARK: 偷偷把讀取失敗藏起來 避免一直彈窗
            })
        .requestUnreadCollection();
  }

  ///MARK: 登出使用者資料
  Future<void> clearUserLoginInfo() async {
    await AppSharedPreferences.setLogIn(false);
    await AppSharedPreferences.setMemberID('');
    await AppSharedPreferences.setToken('');
    await clearTemporaryData();
    GlobalData.userToken = '';
    GlobalData.userMemberId = '';
    GlobalData.showLoginAnimate = false;
    GlobalData.signInInfo = null;
    stopUserListener();
  }

  ///MARK: 登出後-清除暫存資料
  Future<void> clearTemporaryData() async {
    ///清除使用者相關的暫存資料
    AppSharedPreferences.clearUserTmpValue();
  }

  ///MARK: 當token 為空時，代表未登入
  bool isLogin() {
    return GlobalData.userToken.isNotEmpty;
  }

  String getLoginTimeAnimationPath() {
    return AppAnimationPath.loginAnimation;
    /*
    * 5:00 -12:00   早
      12:00 - 18:00 午
      18:00 - 5:00  晚
    * */
    // String time = DateFormatUtil().getNowTimeWith24HourFormat();
    // if (time.compareTo("05:00") >= 0 && time.compareTo("12:00") < 0) {
    //   return AppAnimationPath.loginMorning;
    // } else if (time.compareTo("12:00") >= 0 && time.compareTo("18:00") < 0) {
    //   return AppAnimationPath.loginAfternoon;
    // }
    // return AppAnimationPath.loginNight;
  }

  ///MARK: 通用的 單一彈錯視窗
  onBaseConnectFail(BuildContext context, String message) {
    SimpleCustomDialog(context, mainText: message, isSuccess: false).show();
  }

  /// 自動轉換數字為 K & M (小數點後去0)
  String numberCompatFormat(String value, {int decimalDigits = 2}) {
    if (value == '') {
      return '';
    }

    RegExp regex = RegExp(r'([.]*0+)(?!.*\d)'); // 小數點後 去除尾數0
    if (value.contains('.')) {
      value.replaceAll(regex, '');
    }

    String formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      locale: 'en_US',
      symbol: '',
    ).format(double.parse(value));

    if (formattedNumber.contains('.')) {
      String result = formattedNumber.replaceAll(regex, '');
      return result;
    }

    return formattedNumber;
  }

  /// 指定小數點後幾位，且是無條件捨去
  double truncateToDecimalPlaces(num value, int fractionalDigits) {
    return (value * pow(10, fractionalDigits)).truncate() /
        pow(10, fractionalDigits);
  }

  /// 保留小數點後兩位，且去零，還有仟位符號
  String numberFormat(String value, {int decimalDigits = 2}) {
    if (value == '') {
      return '';
    }
    // 小數點後 去除尾數0
    RegExp regex = RegExp(r'([.]*0+)(?!.*\d)');
    double number = truncateToDecimalPlaces(double.parse(value), decimalDigits);

    if (double.parse(value) >= 1000) {
      List<String> num = number.toString().split('.');
      var format = NumberFormat('0,000');
      String test = format.format(int.parse(num[0]));
      String finalNum = '$test.${num[1]}';
      return finalNum.replaceAll(regex, '');
    }
    return number.toString().replaceAll(regex, '');
  }

  ///MARK: 使用者監聽
  void startUserListener() {
    GlobalData.printLog('---startUserListener');
    StompSocketUtil().connect(onConnect: _onStompConnect);

    ///MARK: v2.1.2 ※因交易多時段，故移除開賣動畫
    // TradeTimerUtil().addListener(_onTradeTimerListener);
    TradeTimerUtil().start();
  }

  ///MARK: 關閉使用者監聽
  void stopUserListener() {
    GlobalData.printLog('---stopUserListener');
    StompSocketUtil().disconnect();
    // TradeTimerUtil().removeListener(_onTradeTimerListener);
    TradeTimerUtil().stop();
  }

  void _onStompConnect(StompFrame frame) {
    ///MARK: 顯示購買成功
    StompSocketUtil().stompClient!.subscribe(
          destination: '/user/notify/${GlobalData.userMemberId}',
          callback: (frame) {
            GlobalData.printLog('${StompSocketUtil().key} ${frame.body}');
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
            GlobalData.printLog('${StompSocketUtil().key} ${frame.body}');
            var result = json.decode(frame.body!);
            if (result['toUserId'] == GlobalData.userMemberId) {
              showLevelUpAnimate(result['oldLevel'], result['newLevel']);
            }
          },
        );

    ///MARK: 獎勵通知
    StompSocketUtil().stompClient!.subscribe(
          destination: '/user/reward/${GlobalData.userMemberId}',
          callback: (frame) {
            GlobalData.printLog('${StompSocketUtil().key} ${frame.body}');
            var result = json.decode(frame.body!);
            if (result['toUserId'] == GlobalData.userMemberId) {
              showRewardDialog(
                  amount: result['amount'] ?? 0,
                  expireDays: result['expireDays'] ?? '0');
            }
          },
        );

    ///MARK: 寶箱通知
    StompSocketUtil().stompClient!.subscribe(
          destination: '/user/treasureBox/${GlobalData.userMemberId}',
          callback: (frame) {
            GlobalData.printLog('${StompSocketUtil().key} ${frame.body}');
            var result = json.decode(frame.body!);
            if (result['toUserId'] == GlobalData.userMemberId) {
              showBoxDialog();
            }
          },
        );
  }

  void showBuySuccessAnimate() async {
    if (!GlobalData.bShowBuySuccessAnimate) {
      GlobalData.bShowBuySuccessAnimate = true;
      String? path = AnimationDownloadUtil()
          .getAnimationFilePath(AppAnimationPath.buyNFTSuccess);
      if (path != null) {
        await pushOpacityPage(
            getGlobalContext(),
            FullAnimationPage(
                isFile: true, animationPath: path, limitTimer: 4));
      }
      await CommonCustomDialog(
        getGlobalContext(),
        title: tr('buy_remind_title'),
        content: tr('buy_remind_content'),
        rightBtnText: tr('gotoPost'),
        type: DialogImageType.success,
        onLeftPress: () {},
        onRightPress: () {
          pushAndRemoveUntil(getGlobalContext(),
              const MainPage(type: AppNavigationBarType.typeCollection));
        },
      ).show();
      GlobalData.bShowBuySuccessAnimate = false;
    }
  }

  void showLevelUpAnimate(int oldLevel, int newLevel) async {
    await pushOpacityPage(getGlobalContext(),
        NotifyLevelUpPage(oldLevel: oldLevel, newLevel: newLevel));

    ///MARK: 顯示彈窗
    if (oldLevel == 0 && newLevel == 1) {
      pushOpacityPage(getGlobalContext(), const LevelUpOneDialog());
    }

    ///MARK: 儲金罐動畫
    else {
      String? jarPath = AnimationDownloadUtil()
          .getAnimationFilePath(AppAnimationPath.showCoinJar);
      if (jarPath != null) {
        pushOpacityPage(
            getGlobalContext(),
            FullAnimationPage(
                isFile: true,
                animationPath: jarPath,
                limitTimer: 3,
                backgroundColor: AppColors.jarCoinBg.withOpacity(0.8)));
      }
    }
  }

  ///MARK: 倒數五分鐘顯示開賣中動畫
  void _onTradeTimerListener(TradeData data) {
    if (data.duration == const Duration(minutes: 5)) {
      String? path = AnimationDownloadUtil()
          .getAnimationFilePath(AppAnimationPath.showWaitSell);
      if (path != null) {
        pushOpacityPage(
            getGlobalContext(),
            FullAnimationPage(
                isFile: true, animationPath: path, limitTimer: 4));
      }
    }
  }

  void showRewardDialog({num amount = 0, String expireDays = '0'}) {
    pushOpacityPage(
        getGlobalContext(),
        RewardNotifyDialog(
          amount: amount,
          expireDays: expireDays,
        ));
  }

  void showBoxDialog() {
    pushOpacityPage(getGlobalContext(), const AirdropGetBoxPage());
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

  String getCurrentDayWithUtcZone() {
    return changeTimeZone(
        DateFormatUtil().getFullWithDateFormat(DateTime.now().toUtc()),
        setSystemZone: "GMT+0",
        strFormat: "yyyy-MM-dd");
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
    String strGmtFormat = '(GMT{}{:02d}:{:02d}) ',
    String strFormat = '',
  }) {
    if (strTime.isEmpty) {
      return "";
    }
    var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime time = dateFormat.parse(strTime);

    ///MARK: 計算
    int systemZone = getZone(setSystemZone ?? HttpSetting.systemTimeZone);
    int systemZoneMin = getZoneMin(setSystemZone ?? HttpSetting.systemTimeZone);
    int localZone = getZone(GlobalData.userZone);
    int localZoneMin = getZoneMin(GlobalData.userZone);

    ///MARK: 測試code
    // int systemZone = getZone("GMT+00:00");
    // int systemZoneMin = getZoneMin("GMT+00:00");
    // int localZone = getZone("GMT-05:30");
    // int localZoneMin = getZoneMin("GMT-05:30");

    if (isSystemTime) {
      ///MARK: 把時間轉成 GMT+0
      time = time.subtract(Duration(hours: systemZone, minutes: systemZoneMin));

      ///MARK: 把時間轉成 使用者時區
      time = time.add(Duration(hours: localZone, minutes: localZoneMin));
    } else {
      ///MARK: 把時間轉成 GMT+0
      time = time.subtract(Duration(hours: localZone, minutes: localZoneMin));

      ///MARK: 把時間轉成 系統時區
      time = time.add(Duration(hours: systemZone, minutes: systemZoneMin));
    }

    return isApiValue
        ? DateFormatUtil().getFullWithDateFormat(time)
        : '${isShowGmt ? format(strGmtFormat, localZone > 0 ? '+' : '', localZone, localZoneMin) : ''}${strFormat.isEmpty ? DateFormatUtil().getFullWithDateFormat2(time) : DateFormatUtil().buildFormat(strFormat: strFormat, time: time)}';
  }

  int getZone(String gmt) {
    return (gmt.contains('GMT+') ? 1 : -1) *
        int.parse(gmt.substring(4, (gmt.length > 6) ? 6 : null));
  }

  int getZoneMin(String gmt) {
    if (gmt.contains(':')) {
      return int.parse(gmt.substring(gmt.indexOf(':') + 1));
    }
    return 0;
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
      Duration timeOut =
          const Duration(milliseconds: HttpSetting.connectionTimeout),
      String logKey = 'checkFutureTime',
      bool printLog = true}) async {
    if (printLog) GlobalData.printLog('$logKey: ---timeStart!!!!');
    while (timeOut.inSeconds > 0) {
      await Future.delayed(const Duration(milliseconds: 500));
      timeOut = timeOut - const Duration(microseconds: 500);
      if (onCheckFinish()) {
        if (printLog) GlobalData.printLog('$logKey: ---timeFinish!!!!');
        return;
      }
    }
    if (printLog) GlobalData.printLog('$logKey: ---timeOut!!!!');
  }

  Future<void> checkAppVersion() async {
    String version = await CommonAPI().checkAppVersion();
    GlobalData.needUpdateApp = version.isNotEmpty;
  }

  /// 外部連結
  Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<bool> checkWalletAddress(WalletInfo walletInfo,
      void Function(String errorMessage) bindFailDialog) async {
    try {
      return await WalletConnectAPI(
              onConnectFail: (errorMessage) => bindFailDialog(errorMessage))
          .getCheckWalletAddress(walletInfo.address);
    } catch (e) {
      GlobalData.printLog('驗證錢包失敗');
      return false;
    }
  }

  void testAirDrop(BuildContext context){
    AirdropBoxReward reward = AirdropBoxReward(
        type: 'TREASURE_BOX',
        orderNo: '',
        createdAt: '',
        updatedAt: '',
        boxType: "RESERVE_BOX",
        rewardType: AirdropRewardType.ITEM.name,
        medal: "https://devimage-dan.treasurenft.xyz/CoolAPE/CoolAPE_9978.png",
        medalName: "030",
        itemName: "CoolAPE_9978",
        itemPrice: 83.1,
        imgUrl: "https://devimage-dan.treasurenft.xyz/CoolAPE/CoolAPE_9978.png",
        reward: 200,
        status: "OPENED");

    BaseViewModel()
        .pushPage(context, AirdropOpenPage(level: 0, reward: reward));
  }
}
