import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/http/api/home_api.dart';
import '../../../models/http/parameter/random_collect_info.dart';
import '../../../utils/app_shared_Preferences.dart';
import '../../base_pref_provider.dart';

final homeCollectRandomProvider =
    StateNotifierProvider<HomeCollectRandomNotifier, List<RandomCollectInfo>>(
        (ref) {
  return HomeCollectRandomNotifier();
});

class HomeCollectRandomNotifier extends StateNotifier<List<RandomCollectInfo>>
    with BasePrefProvider {
  HomeCollectRandomNotifier() : super([]);

  @override
  Future<void> initProvider() async {}

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue() async {
    state = [...await HomeAPI().getRandomCollectList()];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<RandomCollectInfo>.from(
            json.map((x) => RandomCollectInfo.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "homeCollectRandom";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
