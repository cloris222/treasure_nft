import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/collection/collection_main_view_model.dart';

import '../../../constant/ui_define.dart';
import '../../../views/collection/data/collection_nft_item_response_data.dart';
import '../../../views/collection/data/collection_reservation_response_data.dart';
import '../../../views/collection/deposit/deposit_nft_main_view.dart';
import '../../button/icon_text_button_widget.dart';
import 'collection_sell_unsell_item_view.dart';
import 'collection_reservation_item_view.dart';

class GetCollectionMainListview extends StatefulWidget {
  const GetCollectionMainListview

  ({super.key, required this.list, required this.currentType});

  final List list;
  final String currentType;

  @override
  State<StatefulWidget> createState() => _GetCollectionMainListview();

}

class _GetCollectionMainListview extends State<GetCollectionMainListview> {
  String get currentType {
    return widget.currentType;
  }
  CollectionMainViewModel viewModel = CollectionMainViewModel();
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _createItemBuilder(context, index);
        },
        itemCount: _getItemCount(),
        separatorBuilder: (BuildContext context, int index) {
          return _createSeparatorBuilder(context, index);
        });
  }

  Widget _createItemBuilder(BuildContext context, int index) {
    if (currentType == 'Reservation') { // 今日預約
      return _getReservationListViewItem(widget.list[index], index);
    } else if (currentType == 'Selling') { // 上架中
      return _getSellingListViewItem(widget.list[index], index);
    } else { // 未上架
      if (index == 0) { // 充值NFT Button
        return _getDepositBtn();
      }
      return _getPendingListViewItem(widget.list[index], index);
    }
  }

  Widget _createSeparatorBuilder(BuildContext context, int index) {
    return SizedBox(height: UIDefine.getScreenWidth(4.16));
  }

  int _getItemCount() {
    return widget.list.length;
  }

  Widget _getReservationListViewItem(CollectionReservationResponseData data, int index) {
    return CollectionReservationItemView(
      collectionReservationResponseData: data,
    );
  }

  Widget _getSellingListViewItem(CollectionNftItemResponseData data, int index) {
    return CollectionSellUnSellItemView(
      collectionNftItemResponseData: data, index: index, type: 'Selling',
    );
  }

  Widget _getPendingListViewItem(CollectionNftItemResponseData data, int index) {
    return CollectionSellUnSellItemView(
      collectionNftItemResponseData: data, index: index, type: 'Pending',
    );
  }

  Widget _getDepositBtn() {
    return IconTextButtonWidget(
      btnText: '充值NFT',
      iconPath: 'assets/icon/btn/btn_card_01_nor.png',
      onPressed: () { BaseViewModel().pushPage(context, DepositNftMainView()); } // test 這要加上跳頁
      );
  }

  // updateView() async { // test 更新還沒做
  //   page += 1;
  //   List newList = await viewModel.getExploreResponse(widget.type, page, 15);
  //   widget.list.addAll(newList);
  //   setState(() {});
  // }

}