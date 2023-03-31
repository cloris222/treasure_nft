import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/common_api.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../utils/app_shared_Preferences.dart';
import '../../models/http/parameter/country_phone_data.dart';

final registerCurrentIndexProvider = StateProvider.autoDispose<int?>((ref) {
  return null;
});

final registerCountryProvider = StateNotifierProvider.autoDispose<
    RegisterCountryNotifier, List<CountryPhoneData>>((ref) {
  return RegisterCountryNotifier();
});

class RegisterCountryNotifier extends StateNotifier<List<CountryPhoneData>>
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
    state = [...await CommonAPI(onConnectFail: onConnectFail).getCountryList()];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<CountryPhoneData>.from(
            json.map((x) => CountryPhoneData.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "registerCountryPhone";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state.isNotEmpty) {
      await AppSharedPreferences.setJson(getSharedPreferencesKey(),
          List<dynamic>.from(state.map((x) => x.toJson())));
    }
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
