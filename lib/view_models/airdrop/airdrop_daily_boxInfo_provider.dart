import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/api/airdrop_box_api.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
import '../../utils/app_shared_Preferences.dart';

final airdropDailyBoxInfoProvider =
    StateNotifierProvider<AirDropDailyBoxInfoNotifier, List<AirdropRewardInfo>>(
        (ref) {
  return AirDropDailyBoxInfoNotifier();
});

class AirDropDailyBoxInfoNotifier extends StateNotifier<List<AirdropRewardInfo>>
    with BasePrefProvider {
  AirDropDailyBoxInfoNotifier() : super([]);

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
      ...await AirdropBoxAPI(onConnectFail: onConnectFail).getReserveBoxInfo()
    ];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<AirdropRewardInfo>.from(
            json.map((x) => AirdropRewardInfo.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "airdropDailyBoxInfo";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    await AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
