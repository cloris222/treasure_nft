import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
import 'api/collection_api.dart';
import 'data/collection_ticket_response_data.dart';
import 'deposit/deposit_nft_main_view.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/list_view/collection/collection_ticket_item_view.dart';

class CollectionTicketListView extends ConsumerStatefulWidget {
  const CollectionTicketListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionTicketListViewState();
}

class _CollectionTicketListViewState
    extends ConsumerState<CollectionTicketListView> with BaseListInterface {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView();
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CollectionTicketItemView(data: data, index: index);
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
    return await CollectionApi()
        .getTicketResponse(page: page, size: size, type: 'TICKET');
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
    return "collectionTypeTicket";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return CollectionTicketResponseData.fromJson(json);
  }
}
