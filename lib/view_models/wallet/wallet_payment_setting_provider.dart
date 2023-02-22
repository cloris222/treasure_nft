import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/coin_enum.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/parameter/payment_info.dart';
import '../../utils/app_shared_Preferences.dart';

final walletPaymentSettingProvider =
    StateNotifierProvider<WalletPaymentSettingNotifier, List<PaymentInfo>>(
        (ref) {
  return WalletPaymentSettingNotifier();
});

class WalletPaymentSettingNotifier extends StateNotifier<List<PaymentInfo>>
    with BasePrefProvider {
  WalletPaymentSettingNotifier() : super([]);

  @override
  Future<void> initProvider() async {
  }

  @override
  Future<void> initValue() async {
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = [...await WalletAPI(onConnectFail: onConnectFail).getPaymentInfo()];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<PaymentInfo>.from(json.map((x) => PaymentInfo.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "walletPaymentSetting";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  ///MARK: 更新資料
  void updateValue(
      {required String accountTRON,
      required String accountBSC,
      required String accountROLLOUT}) {
    for (int i = 0; i < state.length; i++) {
      if (state[i].payType == CoinEnum.TRON.name) {
        state[i].account = accountTRON;
      }
      if (state[i].payType == CoinEnum.BSC.name) {
        state[i].account = accountBSC;
      }
      if (state[i].payType == CoinEnum.ROLLOUT.name) {
        state[i].account = accountROLLOUT;
      }
    }
    setSharedPreferencesValue();
  }
}
