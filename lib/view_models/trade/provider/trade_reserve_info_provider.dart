import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/utils/trade_timer_util.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_stage_provider.dart';

import '../../../models/http/parameter/check_reservation_info.dart';
import '../../../utils/app_shared_Preferences.dart';

final tradeCurrentDivisionIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final tradeCurrentRangeIndexProvider = StateProvider<int>((ref) {
  return 0;
});

///MARK: 查詢區間的預約資訊
final tradeReserveInfoProvider =
    StateNotifierProvider<TradeReserveInfoNotifier, CheckReservationInfo?>(
        (ref) {
  return TradeReserveInfoNotifier(
      currentDivision: ref.read(tradeCurrentDivisionIndexProvider),
      currentState: ref.read(tradeCurrentStageProvider));
});

class TradeReserveInfoNotifier extends StateNotifier<CheckReservationInfo?>
    with BasePrefProvider {
  TradeReserveInfoNotifier(
      {required this.currentDivision, required this.currentState})
      : super(null);
  final int currentDivision;
  final int? currentState;

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
            reserveStage: currentState);

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
    return "tradeReserveInfo_${currentState ?? '0'}_$currentDivision";
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
