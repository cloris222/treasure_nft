import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../widgets/list_view/collection/collection_medal_item_view.dart';
import '../personal/orders/orderinfo/data/order_message_list_response_data.dart';
import 'api/collection_api.dart';

class CollectionMedalListView extends ConsumerStatefulWidget {
  const CollectionMedalListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionMedalListViewState();
}

class _CollectionMedalListViewState
    extends ConsumerState<CollectionMedalListView> with BaseListInterface {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView(
        crossAxisCount: 2,
        spaceWidget: SizedBox(width: UIDefine.getPixelWidth(10)));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CollectionMedalItemView(record: data.changeBoxRecord());
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getPixelWidth(10));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return OrderMessageListResponseData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await CollectionApi().getMedalResponse(page: page, size: size);
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool needSave(int page) {
    return page == 1;
  }

  @override
  String setKey() {
    return "collectionTypeMedal";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
