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
  TradeNewMainViewModel({required this.onViewChange});

  final onClickFunction onViewChange;

  List<int> division = [0];
  List<ReserveRange> ranges = [];

  late TradeData currentData;

  ReserveViewData? reserveViewData;
  CheckReserveDeposit? checkReserveDeposit;
  int currentDivision = 0;
  int currentIndex = 0;

  void initState() {
    ///MARK: timer監聽
    currentData = TradeTimerUtil().getCurrentTradeData();
    onViewChange();
    TradeTimerUtil().addListener(_onUpdateTrade);

    ///取得副本區間
    if (GlobalData.userInfo.level > 0) {
      TradeAPI().getDivisionAPI().then((value) {
        division = value;
        currentDivision = division.first;
        getDivisionLevelInfo(currentDivision);
        onViewChange();
      });
    } else {
      getDivisionLevelInfo(0);
    }

    UserInfoAPI().getCheckLevelInfoAPI().then((value) => onViewChange());
  }

  ///MARK: 切換level
  void getDivisionLevelInfo(int division) {
    ///取得預約資訊
    TradeAPI().getCheckReservationInfoAPI(division).then((value) {
      TradeTimerUtil().start(setInfo: value);
      ranges = value.reserveRanges;

      /// 如果是體驗帳號 且 level 1 副本顯示內容不同
      if (GlobalData.experienceInfo.isExperience == true &&
          GlobalData.userInfo.level == 1) {
        ranges[0].startPrice = 1;
        ranges[0].endPrice = 50;
        ranges[1].startPrice = 50;
        ranges[1].endPrice = 150;
      }
      onViewChange();

      currentIndex = 0;
      getDivisionIndexInfo(ranges.first.index);
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
            ranges[currentIndex].index,
            ranges[currentIndex].startPrice.toDouble(),
            ranges[currentIndex].endPrice.toDouble())
        .then((value) {
      checkReserveDeposit = value;
      onViewChange();
    });
  }

  /// 離開頁面後清除時間
  void disposeState() {
    TradeTimerUtil().removeListener(_onUpdateTrade);
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
}
