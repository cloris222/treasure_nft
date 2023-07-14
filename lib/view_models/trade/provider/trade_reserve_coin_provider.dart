import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/trade_api.dart';
import '../../../models/http/parameter/check_reserve_deposit.dart';
import '../../../utils/app_shared_Preferences.dart';

///MARK: 查詢交易金
final tradeReserveCoinProvider =
    StateNotifierProvider<TradeReserveCoinNotifier, CheckReserveDeposit?>(
        (ref) {
  return TradeReserveCoinNotifier();
});

class TradeReserveCoinNotifier extends StateNotifier<CheckReserveDeposit?>
    with BasePrefProvider {
  TradeReserveCoinNotifier() : super(null);
  int index = 0;
  num startPrice = 0;
  num endPrice = 0;
  num rewardRate = 0;

  void setSelectValue(int index, num startPrice, num endPrice, num rewardRate) {
    this.index = index;
    this.startPrice = startPrice;
    this.endPrice = endPrice;
    this.rewardRate = rewardRate;
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
    state = await TradeAPI().getCheckReserveDepositAPI(
        index, startPrice.toDouble(), endPrice.toDouble());
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = CheckReserveDeposit.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "tradeReserveCoin_${index}_${startPrice}_$endPrice";
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
