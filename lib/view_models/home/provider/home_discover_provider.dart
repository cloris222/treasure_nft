import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/home_api.dart';
import '../../../models/http/parameter/discover_collect_data.dart';
import '../../../utils/app_shared_Preferences.dart';
import '../../../views/explore/data/explore_category_response_data.dart';

///MARK: Tags

final homeDisCoverTagsProvider = StateNotifierProvider<HomeDisCoverTagNotifier,
    List<ExploreCategoryResponseData>>((ref) {
  return HomeDisCoverTagNotifier();
});

class HomeDisCoverTagNotifier
    extends StateNotifier<List<ExploreCategoryResponseData>>
    with BasePrefProvider {
  HomeDisCoverTagNotifier() : super([]);

  @override
  Future<void> initProvider() async {}

  @override
  Future<void> initValue() async {}

  @override
  Future<void> readAPIValue() async {
    state = await HomeAPI().getDiscoverTag();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<ExploreCategoryResponseData>.from(
            json.map((x) => ExploreCategoryResponseData.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "homeDiscoverTags";
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

///MARK: 選擇的tag
final homeDiscoverCurrentTagProvider =
    StateProvider<ExploreCategoryResponseData?>((ref) {
  return null;
});

///MARK: Discover 清單
final homeDiscoverListProvider =
    StateNotifierProvider<HomeDiscoverListNotifier, List<DiscoverCollectData>>(
        (ref) {
  return HomeDiscoverListNotifier(
      tag: ref.watch(homeDiscoverCurrentTagProvider));
});

class HomeDiscoverListNotifier extends StateNotifier<List<DiscoverCollectData>>
    with BasePrefProvider {
  HomeDiscoverListNotifier({this.tag}) : super([]);
  ExploreCategoryResponseData? tag;

  @override
  Future<void> initProvider() async {}

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue() async {
    if (tag != null) {
      state = [...await HomeAPI().getDiscoverMoreNFT(category: tag!.name)];
    }
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    if (tag != null) {
      var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
      if (json != null) {
        state = [
          ...List<DiscoverCollectData>.from(
              json.map((x) => DiscoverCollectData.fromJson(x)))
        ];
      }
    }
  }

  @override
  String setKey() {
    return "homeDiscoverList_${tag?.name ?? ''}";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (tag != null) {
      AppSharedPreferences.setJson(getSharedPreferencesKey(),
          List<dynamic>.from(state.map((x) => x.toJson())));
    }
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
