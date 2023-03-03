import 'dart:async';
import 'dart:math';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';

import '../constant/call_back_function.dart';
import '../constant/enum/trade_enum.dart';
import '../models/data/trade_model_data.dart';
import '../models/http/api/trade_api.dart';
import '../models/http/parameter/check_experience_info.dart';
import '../models/http/parameter/check_reservation_info.dart';
import '../models/http/parameter/user_info_data.dart';
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

  ///MARK: 查詢預約資訊
  CheckReservationInfo? _reservationInfo;

  ///MARK: 要判斷 天數
  late DateTime _dateCurrentTime;
  late DateTime _dateSellStartTime;
  late DateTime _dateSellEndTime;

  ///MARK: 計算出來的結果
  TradeData _currentTradeData = TradeData(
      duration: const Duration(seconds: 0), status: SellingState.NotYet);
  List<GetTradDate> listeners = [];

  ///MARK: 隨機更新時間
  String _updateTime = '00:00';

  ///MARK: 可放更新的值進來
  void start({CheckReservationInfo? setInfo}) async {
    ///MARK: 取得開賣時間
    if (setInfo == null) {
      ///如果在這裡就壞了 就不會進到下一步
      _reservationInfo = await TradeAPI().getCheckReservationInfoAPI(0);
    } else {
      _reservationInfo = setInfo;
    }

    GlobalData.printLog('$key init timer');

    ///MARK: 判斷有拿到值才做更新
    if (_reservationInfo != null) {
      _closeTimer();
      _setTime(_reservationInfo!);
      _startTimer();
    }
  }

  void stop() {
    _closeTimer();
  }

  TradeData getCurrentTradeData() {
    return _currentTradeData;
  }

  ///可通用
  DateTime getSellStartTime() {
    return _dateSellStartTime;
  }

  CheckReservationInfo? getReservationInfo() {
    return _reservationInfo;
  }

  List<ReserveRange> getDivisionRanges(
      ExperienceInfo experienceInfo, UserInfoData userInfo) {
    if (_reservationInfo != null) {
      var ranges = _reservationInfo!.reserveRanges;

      /// 如果是體驗帳號 且 level 1 副本顯示內容不同
      if (experienceInfo.isExperience == true && userInfo.level == 1) {
        ranges[0].startPrice = 1;
        ranges[0].endPrice = 50;
        ranges[1].startPrice = 50;
        ranges[1].endPrice = 150;
      }
      return ranges;
    }
    return [];
  }

  String getReservationTime() {
    if (_reservationInfo != null) {
      return '${_reservationInfo?.reserveStartTime.substring(0, 5)} - ${_reservationInfo?.reserveEndTime.substring(0, 5)}';
    }
    return '';
  }

  String getResultTime() {
    if (_reservationInfo != null) {
      return '${_reservationInfo?.startTime.substring(0, 5)} - ${_reservationInfo?.endTime.substring(0, 5)}';
    }
    return '';
  }

  String getTradeZone(UserInfoData userInfo) {
    if (userInfo.zone.isNotEmpty) {
      return '(${userInfo.zone.substring(0, 4)}${NumberFormatUtil().integerTwoFormat(userInfo.zone.substring(4))}:00)';
    }
    return '';
  }

  void addListener(GetTradDate listener) {
    listeners.add(listener);
  }

  void removeListener(GetTradDate listener) {
    listeners.remove(listener);
  }

  ///可通用

  void _startTimer() {
    GlobalData.printLog('$key start timer');

    /// 區間為 01:01~59:31
    _updateTime =
        '${NumberFormatUtil().integerTwoFormat(Random().nextInt(58) + 1)}:${NumberFormatUtil().integerTwoFormat(Random().nextInt(30) + 1)}';
    GlobalData.printLog('$key random time $_updateTime');
    _countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => _setCountDown());
  }

  void _closeTimer() {
    GlobalData.printLog('$key close timer');
    _countdownTimer?.cancel();
  }

  void _setCountDown() async {
    if (_countdownTimer!.isActive) {
      _dateCurrentTime = _dateCurrentTime.add(const Duration(seconds: 1));

      ///MARK: 每小時更新狀態
      if (DateFormatUtil()
              .buildFormat(strFormat: 'mm:ss', time: _dateCurrentTime) ==
          _updateTime) {
        GlobalData.printLog('$key restart Timer');
        start();
      } else {
        _currentTradeData = _countSellDate();
        for (var element in listeners) {
          element(_currentTradeData);
        }
        if (printTimeLog) {
          GlobalData.printLog('$key status:${_currentTradeData.status.name}');
          GlobalData.printLog(
              '$key time:${_printDuration(_currentTradeData.duration)}');
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
    if (reservationInfo.sellDate.isEmpty) {
      reservationInfo.sellDate = DateFormatUtil().getNowTimeWithDayFormat();
    }

    /// 現在時間（會員當地時間）
    _dateCurrentTime = DateTime.parse(
        '${DateFormatUtil().getNowTimeWithDayFormat()} ${reservationInfo.localTime}');

    /// 預約日期＋預約時間 就是sellDate
    /// 開始預約時間(當地)
    _dateSellStartTime = DateTime.parse(
        '${reservationInfo.sellDate} ${reservationInfo.reserveStartTime}');

    ///關閉預約時間(當地)
    _dateSellEndTime = DateTime.parse(
        '${reservationInfo.sellDate} ${reservationInfo.reserveStartTime}');
    // 先不放
    // ///如果預約開始時間>預約結束時間 代表跨日
    // if (reservationInfo.reserveStartTime
    //         .compareTo(reservationInfo.reserveStartTime) >
    //     0) {
    //   _dateSellEndTime.add(const Duration(days: 1));
    // }
  }

  TradeData _countSellDate() {
    var duration = const Duration();

    if (printTimeLog) {
      GlobalData.printLog(
          "$key _dateCurrentTime:${DateFormatUtil().getFullWithDateFormat(_dateCurrentTime)}");
      GlobalData.printLog(
          "$key _dateCurrentTime:${DateFormatUtil().getFullWithDateFormat(_dateSellStartTime)}");
      GlobalData.printLog(
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
      return TradeData(duration: duration, status: SellingState.Reserving);

      /// 開賣結束
    } else {
      // duration = _dateSellEndTime
      //     .add(const Duration(days: 1))
      //     .difference(_dateCurrentTime);
      return TradeData(duration: const Duration(), status: SellingState.End);
    }
  }
}
