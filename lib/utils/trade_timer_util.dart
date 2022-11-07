import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';

import '../constant/call_back_function.dart';
import '../constant/enum/trade_enum.dart';
import '../models/data/trade_model_data.dart';
import '../models/http/api/trade_api.dart';
import '../models/http/parameter/check_reservation_info.dart';
import 'date_format_util.dart';

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
  final String key = '-TradeTimer:';
  final bool printTimeLog = false;

  ///MARK: 要判斷 天數
  late DateTime _dateCurrentTime;
  late DateTime _dateSellStartTime;
  late DateTime _dateSellEndTime;

  ///MARK: 計算出來的結果
  late TradeData currentTradeData;
  List<GetTradDate> listeners = [];

  ///MARK: 隨機更新時間
  String _updateTime = '00:00';

  ///MARK: 可放更新的值進來
  void start({CheckReservationInfo? setInfo}) async {
    if (_countdownTimer != null) {
      _closeTimer();
    }

    debugPrint('$key init timer');

    ///MARK: 取得開賣時間
    CheckReservationInfo reservationInfo;
    if (setInfo == null) {
      reservationInfo = await TradeAPI().getCheckReservationInfoAPI(0);
    } else {
      reservationInfo = setInfo;
    }
    _setTime(reservationInfo);
    _startTimer();
  }

  void stop() {
    _closeTimer();
  }

  TradeData getCurrentTradeData() {
    return currentTradeData;
  }

  void addListener(GetTradDate tradDate) {
    listeners.add(tradDate);
  }

  void removeListener(GetTradDate tradDate) {
    listeners.remove(tradDate);
  }

  void _startTimer() {
    debugPrint('$key start timer');

    /// 區間為 01:01~59:31
    _updateTime =
        '${NumberFormatUtil().integerTwoFormat(Random().nextInt(58) + 1)}:${NumberFormatUtil().integerTwoFormat(Random().nextInt(30) + 1)}';
    debugPrint('$key random time $_updateTime');
    _countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => _setCountDown());
  }

  void _closeTimer() {
    debugPrint('$key close timer');
    _countdownTimer!.cancel();
  }

  void _setCountDown() async {
    if (_countdownTimer!.isActive) {
      _dateCurrentTime = _dateCurrentTime.add(const Duration(seconds: 1));

      ///MARK: 每小時更新狀態
      if (DateFormatUtil()
              .buildFormat(strFormat: 'mm:ss', time: _dateCurrentTime) ==
          _updateTime) {
        debugPrint('$key restart Timer');
        start();
      } else {
        currentTradeData = _countSellDate();
        for (var element in listeners) {
          element(currentTradeData);
        }
        if (printTimeLog) {
          debugPrint('$key status:${currentTradeData.status.name}');
          debugPrint('$key time:${_printDuration(currentTradeData.duration)}');
        }
      }
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _setTime(CheckReservationInfo reservationInfo) {
    /// if sellDate == null , sell day is today
    if (reservationInfo.sellDate == "") {
      reservationInfo.sellDate = DateFormatUtil().getNowTimeWithDayFormat();
    }

    /// 現在時間（會員當地時間）
    _dateCurrentTime = DateTime.parse(
        '${reservationInfo.sellDate} ${reservationInfo.localTime}');

    /// 開賣日期＋開賣時間 就是sellDate
    /// 開賣時間(當地)
    _dateSellStartTime = DateTime.parse(
        '${reservationInfo.sellDate} ${reservationInfo.startTime}');

    ///關閉時間(當地)
    _dateSellEndTime = DateTime.parse(
        '${reservationInfo.sellDate} ${reservationInfo.endTime}');
  }

  TradeData _countSellDate() {
    var duration = const Duration();

    if (printTimeLog) {
      debugPrint(
          "$key _dateCurrentTime:${DateFormatUtil().getFullWithDateFormat(_dateCurrentTime)}");
      debugPrint(
          "$key _dateCurrentTime:${DateFormatUtil().getFullWithDateFormat(_dateSellStartTime)}");
      debugPrint(
          "$key _dateSellEndTime:${DateFormatUtil().getFullWithDateFormat(_dateSellEndTime)}");
    }

    /// 尚未開賣 現在時間小於開賣時間
    if (_dateCurrentTime.compareTo(_dateSellStartTime) < 0) {
      duration = _dateSellStartTime.difference(_dateCurrentTime);
      return TradeData(duration: duration, status: SellingState.NotYet);

      /// 開賣中
    } else if (_dateCurrentTime.compareTo(_dateSellEndTime) <= 0 &&
        _dateCurrentTime.compareTo(_dateSellStartTime) >= 0) {
      duration = _dateSellEndTime.difference(_dateCurrentTime);
      return TradeData(duration: duration, status: SellingState.Selling);

      /// 開賣結束
    } else {
      duration = _dateSellEndTime
          .add(const Duration(days: 1))
          .difference(_dateCurrentTime);
      return TradeData(duration: duration, status: SellingState.NotYet);
    }
  }
}
