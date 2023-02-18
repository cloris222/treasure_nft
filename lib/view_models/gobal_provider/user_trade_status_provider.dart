import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/trade_api.dart';

/// app交易頁面Enter按鈕是否顯示
final userTradeStatusProvider =
    StateNotifierProvider<UserTradeStatusNotifier, bool>((ref) {
  return UserTradeStatusNotifier();
});

class UserTradeStatusNotifier extends StateNotifier<bool>
    with BasePrefProvider {
  UserTradeStatusNotifier() : super(false);

  @override
  Future<void> initProvider() async {}

  @override
  Future<void> initValue() async {}

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await TradeAPI(onConnectFail:onConnectFail).getTradeEnterButtonStatus();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    state = await AppSharedPreferences.getBool(getSharedPreferencesKey());
  }

  @override
  String setKey() {
    return "userTradeStatus";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setBool(getSharedPreferencesKey(), state);
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
