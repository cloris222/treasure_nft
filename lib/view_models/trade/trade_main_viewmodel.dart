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

class TradeMainViewModel extends BaseViewModel {
  TradeMainViewModel({required this.setState});

  final ViewChange setState;
  CheckReservationInfo? reservationInfo;
  CheckLevelInfo? userLevelInfo;
  Timer? countdownTimer;
  Duration duration = Duration(days: 5);

  Future<void> initState() async {
    reservationInfo = await TradeAPI().getCheckReservationInfoAPI();
    userLevelInfo = await UserInfoAPI().getCheckLevelInfoAPI();
    startTimer();
    setState(() {});
  }
  /// 每秒呼叫api更改時間狀態
  Future<void> apiInitState() async {
    reservationInfo = await TradeAPI().getCheckReservationInfoAPI();
    setState(() {});
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
    setState(() => duration = Duration(days: 5));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = duration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

}
