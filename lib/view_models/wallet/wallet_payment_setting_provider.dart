import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../utils/app_shared_Preferences.dart';

final walletPaymentSettingProvider =
    StateNotifierProvider<WalletPaymentSettingNotifier, Map<String, dynamic>>(
        (ref) {
  return WalletPaymentSettingNotifier();
});

class WalletPaymentSettingNotifier extends StateNotifier<Map<String, dynamic>>
    with BasePrefProvider {
  WalletPaymentSettingNotifier() : super({});

  @override
  Future<void> initProvider() async {
    state = {};
  }

  @override
  Future<void> initValue() async {
    state = {};
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await WalletAPI(onConnectFail: onConnectFail).getPaymentInfo();
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
    return "walletPaymentSetting";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(), state);
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
    state["TRON"] = accountTRON;
    state["BSC"] = accountBSC;
    state["ROLLOUT"] = accountROLLOUT;

    setSharedPreferencesValue();
  }
}
