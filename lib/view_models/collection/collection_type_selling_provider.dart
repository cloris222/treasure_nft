import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_list_provider.dart';

import '../../constant/call_back_function.dart';
import '../../utils/app_shared_Preferences.dart';
import '../../views/collection/api/collection_api.dart';
import '../../views/collection/data/collection_nft_item_response_data.dart';

///MARK: 收藏_開賣中
final collectionTypeSellingProvider = StateNotifierProvider<
    CollectionTYpeSellingNotifier, List<CollectionNftItemResponseData>>((ref) {
  return CollectionTYpeSellingNotifier();
});

class CollectionTYpeSellingNotifier
    extends StateNotifier<List<CollectionNftItemResponseData>>
    with BaseListProvider {
  CollectionTYpeSellingNotifier() : super([]);

  @override
  void addList(List data) {
    state = [...state, ...data as List<CollectionNftItemResponseData>];
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
      List<CollectionNftItemResponseData> list =
          List<CollectionNftItemResponseData>.from(
              json.map((x) => CollectionNftItemResponseData.fromJson(x)));
      state = [...list];
    }
  }

  @override
  String setKey() {
    return "collectionTypeSelling";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  Future<List> loadData(
      {required int page,
        required int size,
        required bool needSave,
        ResponseErrorFunction? onConnectFail}) async {
    List<CollectionNftItemResponseData> itemList = [];

    itemList.addAll(await CollectionApi(onConnectFail: onConnectFail)
        .getNFTItemResponse(page: page, size: size, status: 'SELLING'));

    if (needSave) {
      setSharedPreferencesValue(itemList);
    }
    return itemList;
  }
}
