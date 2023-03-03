import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_list_provider.dart';

import '../../constant/call_back_function.dart';
import '../../utils/app_shared_Preferences.dart';
import '../../views/collection/api/collection_api.dart';
import '../../views/collection/data/collection_reservation_response_data.dart';

///MARK: 收藏_今日預約
final collectionTypeReservationProvider = StateNotifierProvider<
    CollectionTypeReservationNotifier,
    List<CollectionReservationResponseData>>((ref) {
  return CollectionTypeReservationNotifier();
});

class CollectionTypeReservationNotifier
    extends StateNotifier<List<CollectionReservationResponseData>>
    with BaseListProvider {
  CollectionTypeReservationNotifier() : super([]);

  @override
  void addList(List data) {
    state = [...state, ...data as List<CollectionReservationResponseData>];
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
      List<CollectionReservationResponseData> list =
          List<CollectionReservationResponseData>.from(
              json.map((x) => CollectionReservationResponseData.fromJson(x)));
      state = [...list];
    }
  }

  @override
  String setKey() {
    return "collectionTypeReservation";
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
    List<CollectionReservationResponseData> itemList = [];

    itemList.addAll(await CollectionApi(onConnectFail: onConnectFail)
        .getReservationResponse(page: page, size: size, type: 'ITEM'));
    itemList.addAll(await CollectionApi(onConnectFail: onConnectFail)
        .getReservationResponse(page: page, size: size, type: 'PRICE'));

    if (needSave) {
      setSharedPreferencesValue(itemList);
    }
    return itemList;
  }
}
