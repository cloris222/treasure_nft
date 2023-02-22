import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';

import '../../../utils/app_shared_Preferences.dart';
import '../../base_pref_provider.dart';


final tradeReserveDivisionProvider =
    StateNotifierProvider<TradeReserveDivisionNotifier, List<int>>((ref) {
  return TradeReserveDivisionNotifier();
});

class TradeReserveDivisionNotifier extends StateNotifier<List<int>>
    with BasePrefProvider {
  TradeReserveDivisionNotifier() : super([]);

  @override
  Future<void> initProvider() async {
    state = [];
  }

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = [...await TradeAPI(onConnectFail: onConnectFail).getDivisionAPI()];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [...List<int>.from(json.map((x) => x))];
    }
  }

  @override
  String setKey() {
    return "tradeReserveDivision";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(
        getSharedPreferencesKey(), List<int>.from(state.map((x) => x)));
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
