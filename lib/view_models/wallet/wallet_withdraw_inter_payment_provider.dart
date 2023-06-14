import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/parameter/wallet_payment_type.dart';

/// 查詢內部轉帳提領方式
final walletWithdrawInterPaymentProvider = StateNotifierProvider<
    WalletWithdrawInterPaymentNotifier, List<WalletPaymentType>>((ref) {
  return WalletWithdrawInterPaymentNotifier();
});

class WalletWithdrawInterPaymentNotifier
    extends StateNotifier<List<WalletPaymentType>> with BasePrefProvider {
  WalletWithdrawInterPaymentNotifier() : super([]);

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
    state = [...await WalletAPI().queryInterPaymentType()];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      List<dynamic> list =
          List<dynamic>.from(json.map((x) => WalletPaymentType.fromJson(x)));
      state = [...list];
    } else {
      state = [];
    }
  }

  @override
  String setKey() {
    return "WithdrawInterPayment";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    await AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
