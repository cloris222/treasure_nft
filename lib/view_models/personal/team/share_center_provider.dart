import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/check_share_center.dart';
import '../../../utils/app_shared_Preferences.dart';

final shareCenterProvider = StateNotifierProvider.autoDispose<ShareCenterNotifier,CheckShareCenter? >((ref) {
  return ShareCenterNotifier();
});

class ShareCenterNotifier extends StateNotifier<CheckShareCenter?> with BasePrefProvider{
  ShareCenterNotifier() : super(null);

  @override
  Future<void> initProvider() async{
    state = null;
  }

  @override
  Future<void> initValue()async {
    state = null;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async{
    state = await GroupAPI().getShareCenter();
  }

  @override
  Future<void> readSharedPreferencesValue() async{
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = CheckShareCenter.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "shareCenter";
  }

  @override
  Future<void> setSharedPreferencesValue() async{
    if (state != null) {
    await  AppSharedPreferences.setJson(getSharedPreferencesKey(), state!.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
   return true;
  }


}