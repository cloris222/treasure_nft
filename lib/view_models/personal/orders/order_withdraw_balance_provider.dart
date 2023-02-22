import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/withdraw_api.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../constant/enum/coin_enum.dart';
import '../../../utils/app_shared_Preferences.dart';
import '../../../views/personal/orders/withdraw/data/withdraw_balance_response_data.dart';

final orderCurrentChainProvider = StateProvider.autoDispose<CoinEnum>((ref) {
  return CoinEnum.TRON;
});

final orderWithdrawBalanceProvider = StateNotifierProvider.family<
    OrderWithdrawBalanceNotifier,
    WithdrawBalanceResponseData,
    String?>((ref, chain) {
  return OrderWithdrawBalanceNotifier(chain: chain);
});

class OrderWithdrawBalanceNotifier
    extends StateNotifier<WithdrawBalanceResponseData> with BasePrefProvider {
  OrderWithdrawBalanceNotifier({required this.chain})
      : super(WithdrawBalanceResponseData());
  final String? chain;

  @override
  Future<void> initProvider() async {
    state = WithdrawBalanceResponseData();
  }

  @override
  Future<void> initValue() async {
    state = WithdrawBalanceResponseData();
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await WithdrawApi(onConnectFail: onConnectFail)
        .getWithdrawBalance(chain);
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = WithdrawBalanceResponseData.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "orderWithdrawBalance_${chain ?? ''}";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(), state.toJson());
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
