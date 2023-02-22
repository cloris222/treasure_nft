import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../utils/app_shared_Preferences.dart';

final userLevelInfoProvider =
    StateNotifierProvider<UserLevelInfoNotifier, CheckLevelInfo?>((ref) {
  return UserLevelInfoNotifier();
});

class UserLevelInfoNotifier extends StateNotifier<CheckLevelInfo?>
    with BasePrefProvider {
  UserLevelInfoNotifier() : super(null);

  @override
  Future<void> initProvider() async {
    state = null;
  }

  @override
  Future<void> initValue() async {
    state = null;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state =
        await UserInfoAPI(onConnectFail: onConnectFail).getCheckLevelInfoAPI();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = CheckLevelInfo.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "userLevelInfo";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state != null) {
      AppSharedPreferences.setJson(getSharedPreferencesKey(), state!.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
