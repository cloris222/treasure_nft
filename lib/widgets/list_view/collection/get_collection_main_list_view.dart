import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/view_models/collection/collection_main_view_model.dart';

import '../../../constant/ui_define.dart';
import '../../../views/collection/data/collection_nft_item_response_data.dart';
import '../../../views/collection/data/collection_reservation_response_data.dart';
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
      return _getReservationListViewItem(widget.list[index], index);

    } else if (currentType == 'Selling') { // 上架中
      return _getSellingListViewItem(widget.list[index], index);

    } else { // 未上架
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
        callBack: (index) => _removeItem(index)
    );
  }

  Widget _getPendingListViewItem(CollectionNftItemResponseData data, int index) {
    return CollectionSellUnSellItemView(
      collectionNftItemResponseData: data, index: index, type: 'Pending',
        callBack: (index) => _removeItem(index)
    );
  }

  void _removeItem(int index) {
    widget.list.removeAt(index);
    setState(() {});
  }

  updateView() async {
    page += 1;
    if(currentType == 'Reservation') {
      List newListItem = await viewModel.getReservationResponse('ITEM', page, 10);
      List newListPrice = await viewModel.getReservationResponse('PRICE', page, 10);
      widget.list.addAll(newListItem);
      widget.list.addAll(newListPrice);

    } else if (currentType == 'Selling') {
      List newList = await viewModel.getNFTItemResponse('SELLING', page, 10);
      widget.list.addAll(newList);

    } else {
      List newList = await viewModel.getNFTItemResponse('PENDING', page, 10);
      widget.list.addAll(newList);

    }
    setState(() {});
  }

}