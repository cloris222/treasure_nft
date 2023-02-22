import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../utils/app_shared_Preferences.dart';
import '../../views/wallet/data/BalanceRecordResponseData.dart';

///MARK: 錢包首頁 底下的紀錄
final walletMainRecordProvider = StateNotifierProvider<WalletMainRecordNotifier,
    List<BalanceRecordResponseData>>((ref) {
  return WalletMainRecordNotifier();
});

class WalletMainRecordNotifier
    extends StateNotifier<List<BalanceRecordResponseData>>
    with BasePrefProvider {
  WalletMainRecordNotifier() : super([]);

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
    state = [
      ...await WalletAPI(onConnectFail: onConnectFail).getBalanceRecord()
    ];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<BalanceRecordResponseData>.from(
            json.map((x) => BalanceRecordResponseData.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "walletMainRecord";
  }

  @override
  Future<void> setSharedPreferencesValue() async{
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
