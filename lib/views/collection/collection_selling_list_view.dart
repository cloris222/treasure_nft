import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/collection/collection_type_selling_provider.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
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
    ref.read(collectionTypeSellingProvider.notifier).init(onFinish: () {
      initListView();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView(
        crossAxisCount: 2,
        spaceWidget: SizedBox(width: UIDefine.getScreenWidth(2.7)),
        padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding));
  }

  @override
  void addCurrentList(List data) {
    ref.read(collectionTypeSellingProvider.notifier).addList(data);
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
    ref.read(collectionTypeSellingProvider).removeAt(index);
    ref
        .read(collectionTypeSellingProvider.notifier)
        .setSharedPreferencesValue(ref.read(collectionTypeSellingProvider));
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
  void clearCurrentList() {
    ref.read(collectionTypeSellingProvider.notifier).clearList();
  }

  @override
  List getCurrentList() {
    return ref.read(collectionTypeSellingProvider);
  }

  @override
  Future<List> loadData(int page, int size) {
    return ref
        .read(collectionTypeSellingProvider.notifier)
        .loadData(page: page, size: size, needSave: needSave(page, size));
  }

  bool needSave(int page, int size) {
    return page == 1;
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }
}
