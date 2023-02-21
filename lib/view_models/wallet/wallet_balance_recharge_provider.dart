import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';

import '../../constant/enum/coin_enum.dart';
import '../../utils/app_shared_Preferences.dart';
import '../base_pref_provider.dart';

final walletCurrentChainProvider = StateProvider<CoinEnum>((ref) {
  return CoinEnum.TRON;
});

final walletBalanceRechargeProvider =
    StateNotifierProvider<WalletBalanceRechargeNotifier, Map<String, dynamic>>(
        (ref) {
  return WalletBalanceRechargeNotifier();
});

class WalletBalanceRechargeNotifier extends StateNotifier<Map<String, dynamic>>
    with BasePrefProvider {
  WalletBalanceRechargeNotifier()
      : super({CoinEnum.TRON.name: '', CoinEnum.BSC.name: ''});

  @override
  Future<void> initProvider() async {
    state = {CoinEnum.TRON.name: '', CoinEnum.BSC.name: ''};
  }

  @override
  Future<void> initValue() async {
    state = {CoinEnum.TRON.name: '', CoinEnum.BSC.name: ''};
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await WalletAPI(onConnectFail: onConnectFail).getBalanceRecharge();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = json;
    }
  }

  @override
  String setKey() {
    return "walletBalanceRecharge";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(), state);
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
