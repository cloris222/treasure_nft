import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/parameter/wallet_payment_type.dart';

final currentWithdrawPaymentProvider = StateProvider.autoDispose<int?>((ref) {
  return null;
});

/// 查詢提領方式
final walletWithdrawPaymentProvider = StateNotifierProvider<
    WalletWithdrawPaymentNotifier, List<WalletPaymentType>>((ref) {
  return WalletWithdrawPaymentNotifier();
});

class WalletWithdrawPaymentNotifier
    extends StateNotifier<List<WalletPaymentType>> with BasePrefProvider {
  WalletWithdrawPaymentNotifier() : super([]);

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
    state = [...await WalletAPI().queryPaymentType(false)];
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
    return "WithdrawPayment";
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
