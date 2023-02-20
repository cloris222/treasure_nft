import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/trade_api.dart';
import '../../../models/http/parameter/trade_reserve_stage__info.dart';
import '../../../utils/app_shared_Preferences.dart';

///MARK: 目前交易場次
final tradeCurrentStageProvider = StateProvider<int?>((ref) {
  return null;
});

///MARK: 交易場次
final tradeReserveStageProvider = StateNotifierProvider<
    TradeReserveStageNotifier, List<TradeReserveStageInfo>>((ref) {
  return TradeReserveStageNotifier();
});

class TradeReserveStageNotifier
    extends StateNotifier<List<TradeReserveStageInfo>> with BasePrefProvider {
  TradeReserveStageNotifier() : super([]);

  @override
  Future<void> initProvider() async {
    state = [];
  }

  @override
  Future<void> initValue() async {}

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = [
      ...await TradeAPI(onConnectFail: onConnectFail).getTradeCanReserveStage()
    ];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<TradeReserveStageInfo>.from(
            json.map((x) => TradeReserveStageInfo.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "tradeTradeReserveStage";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
