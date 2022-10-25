import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/data/trade_model_data.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_level_info.dart';
import 'package:treasure_nft_project/models/http/parameter/check_reservation_info.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import '../../constant/call_back_function.dart';
import '../../constant/enum/trade_enum.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/api/trade_api.dart';
import '../../models/http/parameter/add_new_reservation.dart';
import '../../utils/date_format_util.dart';

class TradeDivisionViewModel extends BaseViewModel {
  TradeDivisionViewModel(
      {required this.setState,
      required this.reservationSuccess,
      required this.bookPriceNotEnough,
      required this.notEnoughToPay,
      required this.depositNotEnough,
      required this.errorMes,
      required this.experienceExpired,
      required this.beginnerExpired,
      required this.experienceDisable});

  final onClickFunction setState;
  List<int>? division;
  CheckReservationInfo? reservationInfo;
  CheckLevelInfo? userLevelInfo;
  AddNewReservation? newReservation;
  late List<ReserveRange> ranges;
  Timer? countdownTimer;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? localTime;
  int second = 0;
  VoidCallback notEnoughToPay;
  VoidCallback bookPriceNotEnough;
  VoidCallback reservationSuccess;
  VoidCallback depositNotEnough;
  VoidCallback beginnerExpired;
  VoidCallback experienceExpired;
  VoidCallback experienceDisable;
  ResponseErrorFunction errorMes;

  Future<void> initState() async {
    division = await TradeAPI().getDivisionAPI();
    reservationInfo =
        await TradeAPI().getCheckReservationInfoAPI(division!.first);
    userLevelInfo = await UserInfoAPI().getCheckLevelInfoAPI();
    ranges = reservationInfo!.reserveRanges;
    startTimer();
    setState();
  }

  /// 新增預約
  addNewReservation(int index) async {
    /// 確認體驗帳號狀態
    await TradeAPI(onConnectFail: _experienceExpired, showTrString: false)
        .getExperienceInfoAPI()
        .then((value) {
      if (value.isExperience == true && value.status == 'EXPIRED') {
        experienceExpired();
      } else if(value.isExperience == true && value.status == 'DISABLE'){
        experienceDisable();
      }
    });

    /// 新增預約
    await TradeAPI(onConnectFail: _onAddReservationFail, showTrString: false)
        .postAddNewReservationAPI(
            type: "PRICE",
            startPrice: ranges[index].startPrice,
            endPrice: ranges[index].endPrice,
            priceIndex: ranges[index].index);

    /// 如果預約成功 會進call back function
    reservationSuccess();
  }

  /// 離開頁面後清除時間
  void disposeState() {
    stopTimer();
  }

  /// display star ~ end price range
  String getRange() {
    dynamic min;
    dynamic max;

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
    countdownTimer!.cancel();
  }

  void resetTimer() {
    stopTimer();
  }

  void setCountDown() async {
    /// 如果timer在運行才會逕行狀態更新
    if (countdownTimer!.isActive) {
      second += 1;
      setState();
    }
  }

  TradeData countSellDate() {
    var duration = const Duration();

    /// 如果還沒拿到值 先給空資料
    if (reservationInfo == null) {
      return TradeData(duration: duration, status: SellingState.NotYet);
    }

    /// if sellDate == null , sell day is today
    if (reservationInfo?.sellDate == "") {
      reservationInfo?.sellDate = DateFormatUtil().getNowTimeWithDayFormat();
    }

    /// 現在時間（會員當地時間）
    localTime = DateTime.parse(
            '${reservationInfo?.sellDate} ${reservationInfo?.localTime}')
        .add(Duration(seconds: second));
    // var localTime =DateTime.now();

    /// 開賣日期＋開賣時間 就是sellDate
    /// 開賣時間(當地)
    startTime = DateTime.parse(
        '${reservationInfo?.sellDate} ${reservationInfo?.startTime}');

    ///關閉時間(當地)
    endTime = DateTime.parse(
        '${reservationInfo?.sellDate} ${reservationInfo?.endTime}');

    // print("localTime:" + DateFormatUtil().getFullWithDateFormat(localTime));
    // print("startTime:" + DateFormatUtil().getFullWithDateFormat(startTime));
    // print("endTime:" + DateFormatUtil().getFullWithDateFormat(endTime));

    /// 尚未開賣 現在時間小於開賣時間
    if (localTime!.compareTo(startTime!) < 0) {
      duration = startTime!.difference(localTime!);
      return TradeData(duration: duration, status: SellingState.NotYet);

      /// 開賣中
    } else if (localTime!.compareTo(endTime!) <= 0 &&
        localTime!.compareTo(startTime!) >= 0) {
      duration = endTime!.difference(localTime!);
      return TradeData(duration: duration, status: SellingState.Selling);

      /// 開賣結束
    } else {
      duration = endTime!.add(const Duration(days: 1)).difference(localTime!);
      return TradeData(duration: duration, status: SellingState.NotYet);
    }
  }

  /// 預約失敗顯示彈窗
  void _onAddReservationFail(String errorMessage) {
    switch (errorMessage) {

      /// 預約金不足
      case 'APP_0064':
        bookPriceNotEnough();
        break;

      /// 餘額不足
      case 'APP_0013':
        notEnoughToPay();
        break;

      /// 預約金額不符
      case 'APP_0041':
        depositNotEnough();
        break;

      /// 新手帳號交易天數到期
      case 'APP_0069':
        beginnerExpired();
        break;
      default:
        errorMes(errorMessage);
        break;
    }
  }

  /// 體驗帳號狀態失效
  void _experienceExpired(String errorMessage) {
    experienceExpired();
    experienceDisable();
  }
}
