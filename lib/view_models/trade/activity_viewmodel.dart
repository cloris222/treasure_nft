import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:treasure_nft_project/constant/enum/trade_enum.dart';
import 'package:treasure_nft_project/models/data/activity_model_data.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_activiey_deposit.dart';
import 'package:treasure_nft_project/models/http/parameter/check_activity_reserve.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/utils/timer_util.dart';
import '../../constant/call_back_function.dart';
import '../base_view_model.dart';

class ActivityViewModel extends BaseViewModel {
  ActivityViewModel({
    required this.setState,
    required this.reservationSuccess,
    required this.bookPriceNotEnough,
    required this.notEnoughToPay,
    required this.depositNotEnough,
    required this.wrongTime,
    required this.errorMes,
    required this.accountFrozen,
    required this.activityNotFound,
    required this.tradeForbidden,
    required this.levelNotEnough,
    required this.activityReserveFull,
    required this.personalFull,
  });

  final onClickFunction setState;
  ActivityReserveInfo? canReserve;
  ActivityDeposit? checkDeposit;

  late bool isReserveTime;
  late DateTime _localTime;
  late DateTime _drawTime;
  late DateTime _startTime;
  late DateTime _endTime;
  late DateTime _showListTime;
  String countdownTime = '00:00:00:00';
  late ActivityData activityData;

  /// 計算倒數用
  CountDownTimerUtil? _sellTimer;
  CountDownTimerUtil? _drawTimer;

  /// create reservation
  VoidCallback depositNotEnough;
  VoidCallback notEnoughToPay;
  VoidCallback bookPriceNotEnough;
  VoidCallback reservationSuccess;
  VoidCallback wrongTime;
  VoidCallback accountFrozen;
  VoidCallback activityNotFound;
  VoidCallback tradeForbidden;
  VoidCallback levelNotEnough;
  VoidCallback activityReserveFull;
  VoidCallback personalFull;
  ResponseErrorFunction errorMes;

  /// 查詢活動是否開放
  bool isOpen = false;

  void initState() async {
    activityData =
        ActivityData(status: ActivityState.Activity, showButton: true);
    canReserve = await TradeAPI().getActivityReserveAPI();
    isOpen = canReserve?.isOpen ?? false;

    ///查詢預約金
    checkDeposit = await TradeAPI().getActivityDeposit('1');
    _countdownTimer(canReserve!);
  }

  void dispose() async {
    /// 清除倒數計時器
    _sellTimer?.cancelTimer();
    _drawTimer?.cancelTimer();
  }

  String getEndTimeLabel() {
    if (activityData.status == ActivityState.End) {
      return tr("over");
    } else {
      return countdownTime;
    }
  }

  _countdownTimer(ActivityReserveInfo reservationInfo) {
    /// 是否在預約時間
    isReserveTime = reservationInfo.isReServeTime;

    /// 現在時間(當地)
    _localTime = DateTime.parse(reservationInfo.localTime);

    /// 開獎時間(當地)
    _drawTime = DateTime.parse(reservationInfo.drawTime);

    /// 活動期間內才能預約
    _startTime = DateTime.parse(
        '${DateFormatUtil().getNowTimeWithDayFormat()} ${reservationInfo.startTime}');
    _endTime = DateTime.parse(
        '${DateFormatUtil().getNowTimeWithDayFormat()} ${reservationInfo.endTime}');

    /// 開賣結束後一小時，顯示中獎名單
    _showListTime = _drawTime.add(const Duration(hours: 1));

    ///MARK:可否預約
    if (isOpen) {
      if (isReserveTime) {
        activityData.status = ActivityState.Activity;
        activityData.showButton = true;
        setState();
        _countdownSellTime();
      } else {
        ///MARK: 是否可顯示開獎
        if (_localTime.compareTo(_showListTime) >= 0) {
          activityData.status = ActivityState.End;
          activityData.showButton = true;
          setState();
        } else {
          activityData.status = ActivityState.End;
          activityData.showButton = false;
          _countdownDrawResultTime();
        }
      }
    }
  }

  ///MARK: 倒數至開獎時間
  _countdownSellTime() {
    var countdownSeconds = _drawTime.difference(_localTime).inSeconds;
    _sellTimer = CountDownTimerUtil()
      ..init(
          callBackListener: MyCallBackListener(myCallBack: (duration) {
            countdownTime = duration;

            ///MARL:已到開賣時間
            if (duration.compareTo('00:00:00:00') == 0) {
              activityData.status = ActivityState.HideButton;
              activityData.showButton = false;
              _countdownDrawResultTime();
            }

            /// 開賣前一小時隱藏button
            else if (duration.compareTo('00:01:00:00') <= 0) {
              activityData.showButton = false;
              activityData.status = ActivityState.Activity;
            }
            setState();
          }),
          endTimeSeconds: countdownSeconds);
  }

  ///MARK: 倒數至中獎名單顯示
  _countdownDrawResultTime() {
    var countdownSeconds = _showListTime.difference(_localTime).inSeconds;
    _sellTimer = CountDownTimerUtil()
      ..init(
          callBackListener: MyCallBackListener(myCallBack: (duration) {
            countdownTime = duration;

            ///MARL:已到顯示中獎名單的時間
            if (duration.compareTo('00:00:00:00') == 0) {
              activityData.status = ActivityState.End;
              activityData.showButton = true;
              _countdownDrawResultTime();
            }
            setState();
          }),
          endTimeSeconds: countdownSeconds);
  }

  /// 新增活動預約
  createReservation() async {
    await TradeAPI(onConnectFail: _onAddReservationFail, showTrString: false)
        .postActivityInsert();
    reservationSuccess();
  }

  _onAddReservationFail(String errorMessage) {
    switch (errorMessage) {

      /// 預約金額不符
      case 'APP_0041':
        depositNotEnough();
        break;

      /// 預約時間錯誤
      case 'APP_0063':
        wrongTime();
        break;

      /// 餘額不足
      case 'APP_0013':
        notEnoughToPay();
        break;

      /// 預約金不足
      case 'APP_0064':
        bookPriceNotEnough();
        break;

      /// 帳號被凍結
      case 'EO_001_6':
        accountFrozen();
        break;

      /// 查無活動名稱
      case 'A_0032':
        activityNotFound();
        break;

      /// 禁止交易
      case 'APP_0054':
        tradeForbidden();
        break;

      /// 等級不足
      case 'APP_0055':
        levelNotEnough();
        break;

      /// 活動副本預約次數已滿
      case 'APP_0075':
        activityReserveFull();
        break;

      /// 活動個人預約次數已滿
      case 'APP_0076':
        personalFull();
    }
  }
}
