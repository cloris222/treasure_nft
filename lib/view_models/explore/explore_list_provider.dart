import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_list_provider.dart';

import '../../constant/call_back_function.dart';
import '../../utils/app_shared_Preferences.dart';
import '../../views/explore/api/explore_api.dart';
import '../../views/explore/data/explore_category_response_data.dart';
import '../../views/explore/data/explore_main_response_data.dart';

final exploreListProvider = StateNotifierProvider.family<ExploreListNotifier,
    List<ExploreMainResponseData>, ExploreCategoryResponseData>((ref, tag) {
  return ExploreListNotifier(tag: tag);
});

class ExploreListNotifier extends StateNotifier<List<ExploreMainResponseData>>
    with BaseListProvider {
  ExploreListNotifier({required this.tag}) : super([]);
  ExploreCategoryResponseData tag;

  @override
  void addList(List data) {
    state = [...state, ...data as List<ExploreMainResponseData>];
  }

  @override
  void clearList() {
    state = [];
  }

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      List<ExploreMainResponseData> list = List<ExploreMainResponseData>.from(
          json.map((x) => ExploreMainResponseData.fromJson(x)));
      state = [...list];
    }
  }

  @override
  String setKey() {
    return "exploreList_${tag.name}";
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }

  Future<List> loadData(
      {required int page,
      required int size,
      required bool needSave,
      ResponseErrorFunction? onConnectFail}) async {
    List<ExploreMainResponseData> itemList = [];

    try {
      itemList.addAll(await ExploreApi(onConnectFail: onConnectFail)
          .getExploreArtists(page: page, size: size, category: tag.name));
    } catch (e) {}

    if (needSave) {
      setSharedPreferencesValue(itemList);
    }
    return itemList;
  }
}
