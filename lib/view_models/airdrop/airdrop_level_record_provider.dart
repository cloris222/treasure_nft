import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../models/http/api/airdrop_box_api.dart';
import '../../models/http/parameter/airdrop_box_info.dart';
import '../../utils/app_shared_Preferences.dart';

final airdropLevelRecordProvider = StateNotifierProvider.autoDispose
    .family<AirdropLevelRecordNotifier, List<AirdropBoxInfo>, int>(
        (ref, level) {
  return AirdropLevelRecordNotifier(level);
});

class AirdropLevelRecordNotifier extends StateNotifier<List<AirdropBoxInfo>>
    with BasePrefProvider {
  AirdropLevelRecordNotifier(this.level) : super([]);
  final int level;

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
      ...await AirdropBoxAPI(onConnectFail: onConnectFail)
          .getAirdropBoxLevelRecord(level)
    ];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<AirdropBoxInfo>.from(
            json.map((x) => AirdropBoxInfo.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "airdropDailyRecord";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    await AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
