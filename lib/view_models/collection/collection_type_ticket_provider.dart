import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_list_provider.dart';

import '../../constant/call_back_function.dart';
import '../../utils/app_shared_Preferences.dart';
import '../../views/collection/api/collection_api.dart';
import '../../views/collection/data/collection_ticket_response_data.dart';

final collectionTypeTicketProvider = StateNotifierProvider<
    CollectionTypeTicketNotifier, List<CollectionTicketResponseData>>((ref) {
  return CollectionTypeTicketNotifier();
});

class CollectionTypeTicketNotifier
    extends StateNotifier<List<CollectionTicketResponseData>>
    with BaseListProvider {
  CollectionTypeTicketNotifier() : super([]);

  @override
  void addList(List data) {
    state = [...state, ...data as List<CollectionTicketResponseData>];
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
      List<CollectionTicketResponseData> list =
          List<CollectionTicketResponseData>.from(
              json.map((x) => CollectionTicketResponseData.fromJson(x)));
      state = [...list];
    }
  }

  @override
  String setKey() {
    return "collectionTypeTicket";
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
    List<CollectionTicketResponseData> itemList = [];

    itemList.addAll(await CollectionApi(onConnectFail: onConnectFail)
        .getTicketResponse(page: page, size: size, type: 'TICKET'));

    if (needSave) {
      setSharedPreferencesValue(itemList);
    }
    return itemList;
  }
}
