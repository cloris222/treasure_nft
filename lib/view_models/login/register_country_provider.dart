import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/common_api.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../utils/app_shared_Preferences.dart';

final registerCountryProvider =
    StateNotifierProvider.autoDispose<RegisterCountryNotifier, List<String>>(
        (ref) {
  return RegisterCountryNotifier();
});

class RegisterCountryNotifier extends StateNotifier<List<String>>
    with BasePrefProvider {
  RegisterCountryNotifier() : super([]);

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
      ...await CommonAPI(onConnectFail: onConnectFail).getRegisterCountryInfo()
    ];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json =
        await AppSharedPreferences.getStringList(getSharedPreferencesKey());
    if (json.isNotEmpty) {
      state = [...json];
    }
  }

  @override
  String setKey() {
    return "registerCountry";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state.isNotEmpty) {
      await AppSharedPreferences.setStringList(
          getSharedPreferencesKey(), state);
    }
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
