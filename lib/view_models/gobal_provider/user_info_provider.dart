import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
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
  Future<void> initProvider() async {
    state = UserInfoData();
  }

  @override
  Future<void> initValue() async {
    state = UserInfoData();
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await UserInfoAPI(onConnectFail: onConnectFail).getPersonInfo();
    GlobalData.userZone = state.zone;
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = UserInfoData.fromJson(json);
      GlobalData.userZone = state.zone;
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

  void setAvatarMedal(BuildContext context, String url) async {
    UserInfoAPI().setUserAvtar(url).then((value) {
      update();
      BaseViewModel().showToast(context, tr("success"));
    });
  }
}
