import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/card/data/card_showing_data.dart';
import 'package:treasure_nft_project/widgets/card/item_info_card.dart';
import 'package:treasure_nft_project/widgets/card/order_info_card.dart';

import '../../../views/collection/data/collection_reservation_response_data.dart';

/// 收藏 今日預約 ItemView
class CollectionReservationItemView extends StatefulWidget {
  const CollectionReservationItemView({super.key, required this.collectionReservationResponseData});

  final CollectionReservationResponseData collectionReservationResponseData;

  @override
  State<StatefulWidget> createState() => _CollectionReservationItemView();

}

class _CollectionReservationItemView extends State<CollectionReservationItemView> {

  CollectionReservationResponseData get data {
    return widget.collectionReservationResponseData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(5), 0),
      child: _getViewByType(),
    );
  }


  Widget _getViewByType() {
    if (data.type == 'ITEM') {
      return ItemInfoCard(status: data.status, itemName: data.itemName, dateTime: data.createdAt,
          imageUrl: data.imgUrl, price: '', dataList: _getItemData(data.price.toString(), data.orderNo));

    } else if (data.type == 'PRICE') {
      return OrderInfoCard(status: data.status, orderNumber: data.orderNo, dateTime: data.createdAt,
          dataList: _getOrderData(
            data.startPrice.toString() + ' ~ ' + data.endPrice.toString(),
            data.deposit.toString(),
            data.reserveCount.toString()
          ));

    } else {
      return const SizedBox();
    }
  }

  List<CardShowingData> _getItemData(String itemPrice, String orderNo) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = 'itemPrice';
    data.content = itemPrice;
    dataList.add(data);

    data = CardShowingData();
    data.title = 'orderNo';
    data.content = orderNo;
    dataList.add(data);

    return dataList;
  }

  List<CardShowingData> _getOrderData(String estimatedAmount, String deposit, String estimatedNumber) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = 'estimatedAmount';
    data.content = estimatedAmount;
    dataList.add(data);

    data = CardShowingData();
    data.title = 'deposit';
    data.content = deposit;
    dataList.add(data);

    data = CardShowingData();
    data.title = 'estimatedNumber';
    data.content = estimatedNumber;
    dataList.add(data);

    return dataList;
  }


}