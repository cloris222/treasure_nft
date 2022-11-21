import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_activiey_deposit.dart';
import 'package:treasure_nft_project/models/http/parameter/check_activity_reserve.dart';
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
  });

  final onClickFunction setState;
  ActivityReserveInfo? canReserve;
  ActivityDeposit? checkDeposit;
  bool isOpen = true;

  late DateTime _localTime;
  late DateTime _drawTime;
  String countdownTime = '00:00:00:00';

  /// 計算倒數用
  CountDownTimerUtil? _timer;

  /// create reservation
  VoidCallback depositNotEnough;
  VoidCallback notEnoughToPay;
  VoidCallback bookPriceNotEnough;
  VoidCallback reservationSuccess;
  VoidCallback wrongTime;
  ResponseErrorFunction errorMes;

  void initState() async {
    canReserve = await TradeAPI().getActivityReserveAPI();

    ///查詢預約金
    checkDeposit = await TradeAPI().getActivityDeposit('1');
    _countdownTimer(canReserve!);
  }

  void dispose() async {
    /// 清除倒數計時器
    _timer?.cancelTimer();
  }

  String getEndTimeLabel() {
    if (isOpen == false) {
      return tr("over");
    } else {
      return countdownTime;
    }
  }

  _countdownTimer(ActivityReserveInfo reservationInfo) {
    /// 現在時間(當地)
    _localTime = DateTime.parse(reservationInfo.localTime);

    /// 開獎時間(當地)
     _drawTime = DateTime.parse(reservationInfo.drawTime);
    /// 測試用
    // _drawTime = DateTime.parse('2022-11-21 18:35:00');

    if (_localTime.compareTo(_drawTime) > 0) {
      isOpen = false;
      setState();
      return;
    }

    var countdownSeconds = _drawTime.difference(_localTime).inSeconds;

    _timer = CountDownTimerUtil()
      ..init(
          callBackListener: MyCallBackListener(myCallBack: (duration) {
            countdownTime = duration;
            if (duration == '00:00:00:00') {
              isOpen = false;
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
    }
  }
}
