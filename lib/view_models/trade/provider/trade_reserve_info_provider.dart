import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/utils/trade_timer_util.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/parameter/check_reservation_info.dart';
import '../../../utils/app_shared_Preferences.dart';

/// division index for dropdownButton use
final tradeCurrentDivisionIndexProvider = StateProvider<int>((ref) {
  return 0;
});

/// range index for dropdownButton use
final tradeCurrentRangeIndexProvider = StateProvider<int>((ref) {
  return 0;
});

///MARK: 查詢區間的預約資訊
final tradeReserveInfoProvider =
    StateNotifierProvider<TradeReserveInfoNotifier, CheckReservationInfo?>(
        (ref) {
  return TradeReserveInfoNotifier();
});

class TradeReserveInfoNotifier extends StateNotifier<CheckReservationInfo?>
    with BasePrefProvider {
  TradeReserveInfoNotifier() : super(null);
  int currentDivision = 0;
  int? currentState;
  String? reserveDate;

  void setCurrentChoose(
      int currentDivision, int? currentState, String? reserveDate) {
    this.currentDivision = currentDivision;
    this.currentState = currentState;
    this.reserveDate = reserveDate;
  }

  @override
  Future<void> initProvider() async {
    state = null;
  }

  @override
  Future<void> initValue() async {
    state = null;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await TradeAPI(onConnectFail: onConnectFail)
        .getCheckReservationInfoAPI(currentDivision,
            reserveStage: currentState, reserveDate: reserveDate);

    ///MARK: 更新交易資料時間
    TradeTimerUtil().start(setInfo: state);
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = CheckReservationInfo.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "tradeReserveInfo_$currentDivision";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state != null) {
      AppSharedPreferences.setJson(getSharedPreferencesKey(), state!.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
