import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/trade_api.dart';
import '../../../models/http/parameter/reserve_view_data.dart';
import '../../../utils/app_shared_Preferences.dart';
import 'trade_reserve_info_provider.dart';

///MARK: 交易量相關
final tradeReserveVolumeProvider =
    StateNotifierProvider<TradeReserveVolumeNotifier, ReserveViewData?>((ref) {
  return TradeReserveVolumeNotifier(
      divisionIndex: ref.read(tradeCurrentDivisionIndexProvider));
});

class TradeReserveVolumeNotifier extends StateNotifier<ReserveViewData?>
    with BasePrefProvider {
  TradeReserveVolumeNotifier({required this.divisionIndex}) : super(null);
  final int divisionIndex;

  @override
  Future<void> initProvider() async {}

  @override
  Future<void> initValue() async {
    state = null;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await TradeAPI().getReserveView(divisionIndex);
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = ReserveViewData.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "tradeReserveVolume_$divisionIndex}";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state != null) {
      AppSharedPreferences.setJson(getSharedPreferencesKey(), state!.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
