import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
import 'api/collection_api.dart';
import 'data/collection_nft_item_response_data.dart';
import 'deposit/deposit_nft_main_view.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/list_view/collection/collection_sell_unsell_item_view.dart';

class CollectionSellingListView extends ConsumerStatefulWidget {
  const CollectionSellingListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionSellingListViewState();
}

class _CollectionSellingListViewState
    extends ConsumerState<CollectionSellingListView> with BaseListInterface {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView(
      crossAxisCount: 2,
      spaceWidget: SizedBox(width: UIDefine.getScreenWidth(2.7)),
    );
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CollectionSellUnSellItemView(
        collectionNftItemResponseData: data,
        index: index,
        type: 'Selling',
        callBack: (index) => _removeItem(index));
  }

  void _removeItem(int index) {
    // 上架,轉出
    currentItems.removeAt(index);
    setSharedPreferencesValue(maxSize: maxLoad());
    loadingFinish();
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
        .getNFTItemResponse(page: page, size: size, status: 'SELLING');
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
    return "collectionTypeSelling";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return CollectionNftItemResponseData.fromJson(json);
  }
}
