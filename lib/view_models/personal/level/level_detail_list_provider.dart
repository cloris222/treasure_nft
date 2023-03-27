import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/level_api.dart';
import '../../../models/http/parameter/level_info_data.dart';
import '../../../utils/app_shared_Preferences.dart';

final levelDetailListProvider =
    StateNotifierProvider.autoDispose<LevelDetailListNotifier, List<LevelInfoData>>((ref) {
  return LevelDetailListNotifier();
});

class LevelDetailListNotifier extends StateNotifier<List<LevelInfoData>>
    with BasePrefProvider {
  LevelDetailListNotifier() : super([]);

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
    state = [...await LevelAPI().getAllLevelInfo()];
  }

  @override
  Future<void> readSharedPreferencesValue() async{
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<LevelInfoData>.from(
            json.map((x) => LevelInfoData.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "levelDetailList";
  }

  @override
  Future<void> setSharedPreferencesValue() async{
  await  AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
   return true;
  }
}
