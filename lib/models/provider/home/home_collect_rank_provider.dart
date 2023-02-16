import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/provider/base_pref_provider.dart';

import '../../../utils/app_shared_Preferences.dart';
import '../../http/api/home_api.dart';
import '../../http/parameter/collect_top_info.dart';

///畫家排行榜
final homeCollectRankProvider =
    StateNotifierProvider<HomeCollectRankNotifier, List<CollectTopInfo>>((ref) {
  return HomeCollectRankNotifier();
});

class HomeCollectRankNotifier extends StateNotifier<List<CollectTopInfo>>
    with BasePrefProvider {
  HomeCollectRankNotifier() : super([]);

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue() async {
    state = await HomeAPI().getCollectRank();
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = List<CollectTopInfo>.from(
          json.map((x) => CollectTopInfo.fromJson(x)));
    }
  }

  @override
  String setKey() {
    return "homeCollectRank";
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
