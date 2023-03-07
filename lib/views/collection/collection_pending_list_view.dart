import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/collection/collection_type_pending_provider.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
import '../../view_models/collection/collection_main_view_model.dart';
import 'deposit/deposit_nft_main_view.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/list_view/collection/collection_blind_box_item_view.dart';
import '../../widgets/list_view/collection/collection_sell_unsell_item_view.dart';

class CollectionPendingListView extends ConsumerStatefulWidget {
  const CollectionPendingListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionPendingListViewState();
}

class _CollectionPendingListViewState
    extends ConsumerState<CollectionPendingListView> with BaseListInterface {
  @override
  void initState() {
    ref.read(collectionTypePendingProvider.notifier).init(onFinish: () {
      initListView();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView(
        crossAxisCount: 2,
        spaceWidget: SizedBox(width: UIDefine.getScreenWidth(2.7)));
  }

  @override
  void addCurrentList(List data) {
    ref.read(collectionTypePendingProvider.notifier).addList(data);
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getScreenWidth(4));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    // data.status = 'GIVE'; // test 已開未解鎖 測試用
    // data.boxOpen = 'TRUE'; // test 已開未解鎖 測試用

    // data.boxOpen = 'FALSE'; // test 盲盒 測試用

    if (data.boxOpen == 'FALSE') {
      // 盲盒未開
      return CollectionBlindBoxItemView(
          data: data,
          index: index,
          openBlind: () {
            // 開盲盒
            CollectionMainViewModel()
                .getOpenBoxResponse(action: 'openBox', itemId: data.itemId);
          },
          unlock: (int value) {});
    } else if (data.status == 'GIVE' && data.boxOpen == 'TRUE') {
      // 盲盒已開但未解鎖
      return CollectionBlindBoxItemView(
          data: data,
          index: index,
          openBlind: () {},
          unlock: (index) {
            // 解鎖
            CollectionMainViewModel()
                .getOpenBoxResponse(action: 'unlock', itemId: data.itemId);
            _updateItem(index);
          });
    } else {
      return CollectionSellUnSellItemView(
          // 一般圖
          collectionNftItemResponseData: data,
          index: index,
          type: 'Pending',
          callBack: (index) => _removeItem(index));
    }
  }

  void _updateItem(int index) {
    // 解鎖
    ref.read(collectionTypePendingProvider)[index].status = 'PENDING';
    ref
        .read(collectionTypePendingProvider.notifier)
        .setSharedPreferencesValue(ref.read(collectionTypePendingProvider));
    loadingFinish();
  }

  void _removeItem(int index) {
    // 上架,轉出
    ref.read(collectionTypePendingProvider).removeAt(index);
    ref
        .read(collectionTypePendingProvider.notifier)
        .setSharedPreferencesValue(ref.read(collectionTypePendingProvider));
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
    ref.read(collectionTypePendingProvider.notifier).clearList();
  }

  @override
  List getCurrentList() {
    return ref.read(collectionTypePendingProvider);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return ref
        .read(collectionTypePendingProvider.notifier)
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
