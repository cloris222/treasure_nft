import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/trade_api.dart';
import '../../models/http/parameter/check_experience_info.dart';
import '../../utils/app_shared_Preferences.dart';

final userExperienceInfoProvider =
    StateNotifierProvider<USerExperienceInfoNotifier, ExperienceInfo>((ref) {
  return USerExperienceInfoNotifier();
});

class USerExperienceInfoNotifier extends StateNotifier<ExperienceInfo>
    with BasePrefProvider {
  USerExperienceInfoNotifier() : super(ExperienceInfo());

  @override
  Future<void> initProvider() async {}

  @override
  Future<void> initValue() async {}

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await TradeAPI(onConnectFail: onConnectFail).getExperienceInfoAPI();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = ExperienceInfo.fromJson(json);
    } else {
      ///MARK: 沒預設值就該讀API
      await readAPIValue();
    }
  }

  @override
  String setKey() {
    return "userExperienceInfo";
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
