import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../utils/app_shared_Preferences.dart';

///MARK: 使用者資訊
final userInfoProvider =
    StateNotifierProvider<UserInfoNotifier, UserInfoData>((ref) {
  return UserInfoNotifier();
});

class UserInfoNotifier extends StateNotifier<UserInfoData>
    with BasePrefProvider {
  UserInfoNotifier() : super(UserInfoData());

  @override
  Future<void> initProvider() async {}

  @override
  Future<void> initValue() async {}

  @override
  Future<void> readAPIValue() async {
    state = await UserInfoAPI().getPersonInfo();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = UserInfoData.fromJson(json);
    } else {
      ///MARK: 沒預設值就該讀API
      await readAPIValue();
    }
  }

  @override
  String setKey() {
    return "userInfo";
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
