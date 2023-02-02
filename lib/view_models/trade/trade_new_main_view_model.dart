import 'package:easy_localization/easy_localization.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/data/trade_model_data.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_reservation_info.dart';
import 'package:treasure_nft_project/models/http/parameter/check_reserve_deposit.dart';
import 'package:treasure_nft_project/models/http/parameter/reserve_view_data.dart';
import 'package:treasure_nft_project/utils/trade_timer_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

class TradeNewMainViewModel extends BaseViewModel {
  TradeNewMainViewModel(
      {required this.onViewChange,
      required this.reservationSuccess,
      required this.errorMsgDialog});

  final onClickFunction onViewChange;
  final onClickFunction reservationSuccess;
  final void Function(String mainText, String subText) errorMsgDialog;

  List<int> division = [];
  List<ReserveRange> ranges = [];

  late TradeData currentData;

  ReserveViewData? reserveViewData;
  CheckReserveDeposit? checkReserveDeposit;
  int currentDivisionIndex = 0;
  int currentRangeIndex = 0;

  void initState() {
    ///MARK: timer監聽
    currentData = TradeTimerUtil().getCurrentTradeData();
    ranges = TradeTimerUtil().getDivisionRanges();

    onViewChange();
    TradeTimerUtil().addListener(_onUpdateTrade);

    ///取得副本區間
    TradeAPI().getDivisionAPI().then((value) {
      division = value;
      currentDivisionIndex = 0;
      getDivisionLevelInfo(division[currentDivisionIndex]);
      onViewChange();
    });

    UserInfoAPI().getCheckLevelInfoAPI().then((value) => onViewChange());
  }

  ///MARK: 切換level
  void getDivisionLevelInfo(int division, {int initIndex = 0}) {
    ///取得預約資訊
    TradeAPI().getCheckReservationInfoAPI(division).then((value) {
      TradeTimerUtil().start(setInfo: value);
      ranges = TradeTimerUtil().getDivisionRanges();

      onViewChange();

      currentRangeIndex = initIndex;
      getDivisionIndexInfo(ranges[currentRangeIndex].index);
    });
  }

  void getDivisionIndexInfo(int index) async {
    ///取得交易量
    TradeAPI().getReserveView(index).then((value) {
      reserveViewData = value;
      onViewChange();
    });

    ///查預約金
    TradeAPI()
        .getCheckReserveDepositAPI(
            ranges[currentRangeIndex].index,
            ranges[currentRangeIndex].startPrice.toDouble(),
            ranges[currentRangeIndex].endPrice.toDouble())
        .then((value) {
      checkReserveDeposit = value;
      onViewChange();
    });
  }

  /// 離開頁面後清除時間
  void disposeState() {
    TradeTimerUtil().removeListener(_onUpdateTrade);
  }

  addNewReservation(int index) async {
    /// 確認體驗帳號狀態
    await TradeAPI(onConnectFail: _experienceExpired, showTrString: false)
        .getExperienceInfoAPI()
        .then((value) {
      if (value.isExperience == true && value.status == 'EXPIRED') {
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0057'));
      } else if (value.isExperience == true && value.status == 'DISABLE') {
        errorMsgDialog(tr("reserve-failed'"), '');
      }
    });

    /// 新增預約
    await TradeAPI(onConnectFail: _onAddReservationFail, showTrString: false)
        .postAddNewReservationAPI(
            type: "PRICE",
            reserveCount: 1,
            startPrice: ranges[index].startPrice,
            endPrice: ranges[index].endPrice,
            priceIndex: ranges[index].index);

    /// 如果預約成功 會進call back function
    reservationSuccess();
  }

  /// display star ~ end price range
  String getRange() {
    dynamic min;
    dynamic max;

    min = GlobalData.userLevelInfo?.buyRangeStart;
    max = GlobalData.userLevelInfo?.buyRangeEnd;
    return '$min~$max';
  }

  void _onUpdateTrade(TradeData data) {
    currentData = data;
    onViewChange();
  }

  void _experienceExpired(String errorMessage) {
    errorMsgDialog(tr("reserve-failed'"), '');
  }

  void _onAddReservationFail(String errorMessage) {
    switch (errorMessage) {

      /// 預約金不足
      case 'APP_0064':
        errorMsgDialog(tr("reserve-failed'"), '');
        break;

      /// 餘額不足
      case 'APP_0013':
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0013'));
        break;

      /// 預約金額不符
      case 'APP_0041':
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0041'));
        break;

      /// 新手帳號交易天數到期
      case 'APP_0069':
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0069'));
        break;
      default:
        errorMsgDialog(tr("reserve-failed'"), tr(errorMessage));
        break;
    }
  }
}
