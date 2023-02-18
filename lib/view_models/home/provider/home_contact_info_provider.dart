import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/home_api.dart';
import '../../../utils/app_shared_Preferences.dart';

///MARK: 首頁 APP聯絡資訊
final homeContactInfoProvider =
    StateNotifierProvider<HomeContactInfoNotifier, Map<String, dynamic>>((ref) {
  return HomeContactInfoNotifier();
});

class HomeContactInfoNotifier extends StateNotifier<Map<String, dynamic>>
    with BasePrefProvider {
  HomeContactInfoNotifier() : super({});
  @override
  Future<void> initProvider() async{
  }
  @override
  Future<void> initValue() async {}

  @override
  Future<void> readAPIValue() async {
    state = await HomeAPI().getFooterSetting();
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
    return "homeContactInfo";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(), state);
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
