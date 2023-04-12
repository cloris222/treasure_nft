import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/api/airdrop_box_api.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
import '../../utils/app_shared_Preferences.dart';

final airdropDailyBoxInfoProvider =
    StateNotifierProvider<AirDropDailyBoxInfoNotifier, AirdropRewardInfo?>(
        (ref) {
  return AirDropDailyBoxInfoNotifier();
});

class AirDropDailyBoxInfoNotifier extends StateNotifier<AirdropRewardInfo?>
    with BasePrefProvider {
  AirDropDailyBoxInfoNotifier() : super(null);

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
    state = await AirdropBoxAPI(onConnectFail: onConnectFail).getReserveBoxInfo();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = AirdropRewardInfo.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "airdropDailyBoxInfo_2";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state != null) {
      await AppSharedPreferences.setJson(getSharedPreferencesKey(), state!.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
