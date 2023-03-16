import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/mine_api.dart';
import '../../../utils/app_shared_Preferences.dart';

///MARK: 鑄造手續費
final userCreateRateProvider =
    StateNotifierProvider.autoDispose<UserCreateRateNotifier, double>((ref) {
  return UserCreateRateNotifier();
});

class UserCreateRateNotifier extends StateNotifier<double>
    with BasePrefProvider {
  UserCreateRateNotifier() : super(0);

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
    state = await MineAPI().getRoyaltyRate();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    state = await AppSharedPreferences.getDouble(getSharedPreferencesKey());
  }

  @override
  String setKey() {
    return "userCreateRate";
  }

  @override
  Future<void> setSharedPreferencesValue() async{
    await AppSharedPreferences.setDouble(getSharedPreferencesKey(), state);
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
