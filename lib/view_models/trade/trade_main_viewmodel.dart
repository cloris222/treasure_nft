import 'dart:async';

import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_level_info.dart';
import 'package:treasure_nft_project/models/http/parameter/check_reservation_info.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/api/trade_api.dart';
import '../../utils/date_format_util.dart';

class TradeMainViewModel extends BaseViewModel {
  TradeMainViewModel({required this.setState});

  final ViewChange setState;
  CheckReservationInfo? reservationInfo;
  CheckLevelInfo? userLevelInfo;
  Timer? countdownTimer;

  Future<void> initState() async {
    reservationInfo = await TradeAPI().getCheckReservationInfoAPI();
    userLevelInfo = await UserInfoAPI().getCheckLevelInfoAPI();
    startTimer();
    setState(() {});
  }

  /// 每秒呼叫api更改時間狀態
  Future<void> apiInitState() async {
    reservationInfo = await TradeAPI().getCheckReservationInfoAPI();
  }

  /// 離開頁面後清除時間
  Future<void> disposeState() async {
    stopTimer();
  }

  /// display star ~ end price range
  String getRange() {
    dynamic? min;
    dynamic? max;

    min = userLevelInfo?.buyRangeStart;
    max = userLevelInfo?.buyRangeEnd;
    return '$min~$max';
  }

  /// display level image
  String getLevelImg() {
    return format(AppImagePath.level, ({'level': GlobalData.userInfo.level}));
  }

  /// Timer related methods ///
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
  }

  void setCountDown() async {
    /// 倒數每秒呼叫api
    await apiInitState();
    if(countdownTimer!.isActive) {
      setState(() {});
    }
  }

  Duration countSellDate() {
    var duration = Duration();

    /// if sellDate == null , sell day is today
    if (reservationInfo?.sellDate == "") {
      reservationInfo?.sellDate = DateFormatUtil().getNowTimeWithDayFormat();
    }

    /// 現在時間（會員當地時間）
    var localTime = DateTime.parse(
        '${reservationInfo?.sellDate} ${reservationInfo?.localTime}');

    /// 開賣日期＋開賣時間 就是sellDate
    /// 開賣時間(當地)
    var startTime = DateTime.parse(
        '${reservationInfo?.sellDate} ${reservationInfo?.startTime}');

    ///關閉時間(當地)
    var endTime = DateTime.parse(
        '${reservationInfo?.sellDate} ${reservationInfo?.endTime}');

    // print("localTime:" + DateFormatUtil().getDateWith12HourFormat2(localTime));
    // print("startTime:" + DateFormatUtil().getDateWith12HourFormat2(startTime));
    // print("endTime:" + DateFormatUtil().getDateWith12HourFormat2(endTime));

    /// 尚未開賣 現在時間小於開賣時間
    if (localTime.compareTo(startTime) < 0) {
      duration = localTime.difference(startTime);
      return duration;

      /// 開賣中
    } else if (localTime.compareTo(endTime) <= 0 &&
        localTime.compareTo(startTime) >= 0) {
      duration = endTime.difference(localTime);
      return duration;

      /// 開賣結束
    } else {
      duration = localTime.difference(endTime.add(const Duration(days: 1)));
      return duration;
    }
  }
}
