import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/api/airdrop_box_api.dart';

final airdropCountProvider =
    StateNotifierProvider.family<AirdropCountNotifier, int, bool>(
        (ref, isLogin) {
  return AirdropCountNotifier(isLogin);
});

class AirdropCountNotifier extends StateNotifier<int> with BasePrefProvider {
  AirdropCountNotifier(this.isLogin) : super(0);
  final bool isLogin;

  @override
  Future<void> initProvider() async {
    state = 0;
  }

  @override
  Future<void> initValue() async {
    state = 0;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    if (isLogin) {
      state = await AirdropBoxAPI(onConnectFail: onConnectFail)
          .checkReserveBoxCount();
    }
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    if (isLogin) {
      AppSharedPreferences.getDouble(getSharedPreferencesKey()).then((value) {
        state = value.toInt();
      });
    }
  }

  @override
  String setKey() {
    return "airdropCounts";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (isLogin) {
      await AppSharedPreferences.setDouble(
          getSharedPreferencesKey(), state.toDouble());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
