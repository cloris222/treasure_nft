import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/view_models/collection/collection_main_view_model.dart';

import '../../../constant/ui_define.dart';
import '../../../views/collection/data/collection_nft_item_response_data.dart';
import '../../../views/collection/data/collection_reservation_response_data.dart';
import 'collection_blind_box_item_view.dart';
import 'collection_sell_unsell_item_view.dart';
import 'collection_reservation_item_view.dart';

class GetCollectionMainListview extends StatefulWidget {
  const GetCollectionMainListview({super.key,
  required this.reserveList,
  required this.itemsList,
  required this.currentType
  });

  final List<CollectionReservationResponseData> reserveList;
  final List<CollectionNftItemResponseData> itemsList;
  final String currentType;

  @override
  State<StatefulWidget> createState() => _GetCollectionMainListview();
}

class _GetCollectionMainListview extends State<GetCollectionMainListview> {
  String get currentType {
    return widget.currentType;
  }

  List<CollectionReservationResponseData> get reserveList {
    return widget.reserveList;
  }

  List<CollectionNftItemResponseData> get itemsList {
    return widget.itemsList;
  }

  CollectionMainViewModel viewModel = CollectionMainViewModel();
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          bool isTop = metrics.pixels == 0;
          if (isTop) {
            debugPrint('At the top');
          } else {
            debugPrint('At the bottom');
            updateView();
          }
        }
        return true;
      },
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _createItemBuilder(context, index);
          },
          itemCount: _getItemCount(),
          separatorBuilder: (BuildContext context, int index) {
            return _createSeparatorBuilder(context, index);
          })
    );
  }

  Widget _createItemBuilder(BuildContext context, int index) {
    if (currentType == 'Reservation') { // 今日預約
      return _getReservationListViewItem(reserveList[index], index);

    } else if (currentType == 'Selling') { // 上架中
      return _getSellingListViewItem(itemsList[index], index);

    } else { // 未上架
      return _getPendingListViewItem(itemsList[index], index);
    }
  }

  Widget _createSeparatorBuilder(BuildContext context, int index) {
    return SizedBox(height: UIDefine.getScreenWidth(4.16));
  }

  int _getItemCount() {
    if (currentType == 'Reservation') {
      return reserveList.length;
    }
    return itemsList.length;
  }

  Widget _getReservationListViewItem(CollectionReservationResponseData data, int index) {
    return CollectionReservationItemView(
      collectionReservationResponseData: data,
    );
  }

  Widget _getSellingListViewItem(CollectionNftItemResponseData data, int index) {
    return CollectionSellUnSellItemView(
      collectionNftItemResponseData: data, index: index, type: 'Selling',
        callBack: (index) => _removeItem(index)
    );
  }

  Widget _getPendingListViewItem(CollectionNftItemResponseData data, int index) {
    // data.status = 'GIVE'; // test 已開未解鎖 測試用 目前後端都沒資料
    // data.boxOpen = 'TRUE'; // test 已開未解鎖 測試用 目前後端都沒資料

    // data.boxOpen = 'FALSE'; // test 盲盒測試用 目前後端都沒資料

    if (data.boxOpen == 'FALSE') { // 盲盒未開
      return CollectionBlindBoxItemView(data: data, index: index,
        openBlind: () { // 開盲盒
          viewModel.getOpenBoxResponse(action: 'openBox', itemId: data.itemId);
        },
        unlock: (int value) {});

    } else if (data.status == 'GIVE' && data.boxOpen == 'TRUE') { // 盲盒已開但未解鎖
      return CollectionBlindBoxItemView(data: data, index: index,
        openBlind: () {},
        unlock: (index) { // 解鎖
          viewModel.getOpenBoxResponse(action: 'unlock', itemId: data.itemId);
          _updateItem(index);
        });

    } else {
      return CollectionSellUnSellItemView( // 一般圖
          collectionNftItemResponseData: data, index: index, type: 'Pending',
          callBack: (index) => _removeItem(index)
      );
    }
  }

  void _removeItem(int index) { // 上架,轉出
    itemsList.removeAt(index);
    setState(() {});
  }

  void _updateItem(int index) { // 解鎖
    itemsList[index].status == 'PENDING';
    setState(() {});
  }

  updateView() async {
    page += 1;
    if(currentType == 'Reservation') {
      var newListItem = await viewModel.getReservationResponse('ITEM', page, 10);
      var newListPrice = await viewModel.getReservationResponse('PRICE', page, 10);
      reserveList.addAll(newListItem);
      reserveList.addAll(newListPrice);

    } else if (currentType == 'Selling') {
      var newList = await viewModel.getNFTItemResponse('SELLING', page, 10);
      itemsList.addAll(newList);

    } else {
      var newList = await viewModel.getNFTItemResponse('PENDING', page, 10);
      itemsList.addAll(newList);

    }
    setState(() {});
  }

}