import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/ui_define.dart';
import 'api/collection_api.dart';
import 'data/collection_reservation_response_data.dart';
import 'deposit/deposit_nft_main_view.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/list_view/collection/collection_reservation_item_view.dart';

class CollectionReservationListView extends ConsumerStatefulWidget {
  const CollectionReservationListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionReservationListViewState();
}

class _CollectionReservationListViewState
    extends ConsumerState<CollectionReservationListView>
    with BaseListInterface {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView(
        padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CollectionReservationItemView(
      collectionReservationResponseData: data,
    );
  }

  @override
  Widget? buildTopView() {
    return IconTextButtonWidget(
        height: UIDefine.getScreenWidth(10),
        btnText: tr("depositNFT"),
        iconPath: 'assets/icon/btn/btn_card_01_nor.png',
        onPressed: () {
          BaseViewModel().pushPage(context, const DepositNftMainView());
        });
  }

  @override
  Future<List> loadData(int page, int size) async {
    List<CollectionReservationResponseData> itemList = [];
    itemList.addAll(await CollectionApi()
        .getReservationResponse(page: page, size: size, type: 'ITEM'));
    itemList.addAll(await CollectionApi()
        .getReservationResponse(page: page, size: size, type: 'PRICE'));
    return itemList;
  }

  @override
  bool needSave(int page) {
    return page == 1;
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
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

  @override
  changeDataFromJson(json) {
   return CollectionReservationResponseData.fromJson(json);
  }
}
