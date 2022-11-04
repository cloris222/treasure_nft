import 'dart:async';

import '../models/data/trade_model_data.dart';
import '../models/http/api/trade_api.dart';
import '../models/http/parameter/check_reservation_info.dart';

class TradeTimerUtil {
  /// 單例
  static TradeTimerUtil? _self;

  TradeTimerUtil._();

  /// 獲取單例内部方法
  factory TradeTimerUtil() {
    /// 只能有一个實例
    return _self ??= TradeTimerUtil._();
  }

  Timer? _countdownTimer;
  ///MARK: 要判斷 天數
  DateTime? _dateSellStartTime;
  DateTime? _dateCurrentTime;

  void start() async {
    if (_countdownTimer != null) {
      _closeTimer();
    }
    ///MARK: 取得開賣時間
    CheckReservationInfo reservationInfo =
    await TradeAPI().getCheckReservationInfoAPI(0);
    // _dateSellStartTime = reservationInfo.systemStartTime;
    // _dateCurrentTime = reservationInfo.systemTime;
  }

  void stop() {
    _closeTimer();
  }

  void _startTimer() {
    _countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void _closeTimer() {
    _countdownTimer!.cancel();
  }

  void setCountDown() async {
    ///MARK: 如果到了開賣結束時間 要重新讀
    // if (_countdownTimer!.isActive) {
    //   second += 1;
    // }
  }

  // TradeData countSellDate() {
  //   var duration = const Duration();
  //
  //   /// 如果還沒拿到值 先給空資料
  //   if (reservationInfo == null) {
  //     return TradeData(duration: duration, status: SellingState.NotYet);
  //   }
  //
  //   /// if sellDate == null , sell day is today
  //   if (reservationInfo?.sellDate == "") {
  //     reservationInfo?.sellDate = DateFormatUtil().getNowTimeWithDayFormat();
  //   }
  //
  //   /// 現在時間（會員當地時間）
  //   localTime = DateTime.parse(
  //           '${reservationInfo?.sellDate} ${reservationInfo?.localTime}')
  //       .add(Duration(seconds: second));
  //   // var localTime =DateTime.now();
  //
  //   /// 開賣日期＋開賣時間 就是sellDate
  //   /// 開賣時間(當地)
  //   startTime = DateTime.parse(
  //       '${reservationInfo?.sellDate} ${reservationInfo?.startTime}');
  //
  //   ///關閉時間(當地)
  //   endTime = DateTime.parse(
  //       '${reservationInfo?.sellDate} ${reservationInfo?.endTime}');
  //
  //   // print("localTime:" + DateFormatUtil().getFullWithDateFormat(localTime));
  //   // print("startTime:" + DateFormatUtil().getFullWithDateFormat(startTime));
  //   // print("endTime:" + DateFormatUtil().getFullWithDateFormat(endTime));
  //
  //   /// 尚未開賣 現在時間小於開賣時間
  //   if (localTime!.compareTo(startTime!) < 0) {
  //     duration = startTime!.difference(localTime!);
  //     return TradeData(duration: duration, status: SellingState.NotYet);
  //
  //     /// 開賣中
  //   } else if (localTime!.compareTo(endTime!) <= 0 &&
  //       localTime!.compareTo(startTime!) >= 0) {
  //     duration = endTime!.difference(localTime!);
  //     return TradeData(duration: duration, status: SellingState.Selling);
  //
  //     /// 開賣結束
  //   } else {
  //     duration = endTime!.add(const Duration(days: 1)).difference(localTime!);
  //     return TradeData(duration: duration, status: SellingState.NotYet);
  //   }
  // }
}
