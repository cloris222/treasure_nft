import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/home_api.dart';
import '../../../models/http/parameter/discover_collect_data.dart';
import '../../../utils/app_shared_Preferences.dart';
import '../../../views/explore/data/explore_category_response_data.dart';

///MARK: Tags
///MARK: 如果tags 有變時，要調整key值
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
  Future<void> initValue() async {
    state=[];
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await HomeAPI(onConnectFail: onConnectFail).getDiscoverTag();
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
    StateNotifierProvider.family<HomeDiscoverListNotifier, List<DiscoverCollectData>,ExploreCategoryResponseData?>(
        (ref,tag) {
          return HomeDiscoverListNotifier(tag: tag);
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
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    if (tag != null) {
      state = [...await HomeAPI(onConnectFail: onConnectFail).getDiscoverMoreNFT(category: tag!.name)];
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
