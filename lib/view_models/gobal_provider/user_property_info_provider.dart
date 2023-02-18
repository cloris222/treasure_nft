import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/user_property.dart';
import '../../utils/app_shared_Preferences.dart';

final userPropertyInfoProvider =
    StateNotifierProvider<UserPropertyInfoNotifier, UserProperty?>((ref) {
  return UserPropertyInfoNotifier();
});

class UserPropertyInfoNotifier extends StateNotifier<UserProperty?>
    with BasePrefProvider {
  UserPropertyInfoNotifier() : super(null);

  @override
  Future<void> initProvider() async {}

  @override
  Future<void> initValue() async {
    state = null;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state =
        await UserInfoAPI(onConnectFail: onConnectFail).getUserPropertyInfo();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = UserProperty.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "userPropertyInfo";
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
