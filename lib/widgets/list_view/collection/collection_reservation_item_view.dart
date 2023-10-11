import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/card/data/card_showing_data.dart';
import 'package:treasure_nft_project/widgets/card/item_info_card.dart';
import 'package:treasure_nft_project/widgets/card/order_info_card.dart';

import '../../../constant/call_back_function.dart';
import '../../../views/collection/data/collection_reservation_response_data.dart';

/// 收藏 今日預約 ItemView
class CollectionReservationItemView extends StatefulWidget {
  const CollectionReservationItemView({
    super.key,
    required this.collectionReservationResponseData,
  });

  final CollectionReservationResponseData collectionReservationResponseData;

  @override
  State<StatefulWidget> createState() => _CollectionReservationItemView();
}

class _CollectionReservationItemView
    extends State<CollectionReservationItemView> {
  CollectionReservationResponseData get data {
    return widget.collectionReservationResponseData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          UIDefine.getScreenWidth(3), 0, UIDefine.getScreenWidth(3), 0),
      child: _getViewByType(),
    );
  }

  Widget _getViewByType() {
    if (data.type == 'ITEM') {
      return ItemInfoCard(
          drewAt: data.drewAt,
          status: data.status,
          itemName: data.itemName,
          dateTime:
              BaseViewModel().changeTimeZone(data.createdAt, isShowGmt: true),
          imageUrl: data.imgUrl,
          price: '',
          dataList: _getItemData(data.price.toString(), data.orderNo));
    } else if (data.type == 'PRICE') {
      return OrderInfoCard(
        drewAt: data.drewAt,
        status: data.status,
        isPaying: data.isPaying,
        orderNumber: data.orderNo,
        itemName: data.itemName,
        imageUrl: data.imgUrl,
        price: data.price.toString(),
        dateTime:
            BaseViewModel().changeTimeZone(data.createdAt, isShowGmt: true),
        dataList: _getOrderData(
          data.startPrice.toString() + ' ~ ' + data.endPrice.toString(),
          data.deposit.toString(),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  List<CardShowingData> _getItemData(String itemPrice, String orderNo) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('price');
    data.content = itemPrice;
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('orderNo');
    data.content = orderNo;
    dataList.add(data);

    return dataList;
  }

  List<CardShowingData> _getOrderData(String estimatedAmount, String deposit) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('reservationAmount');
    data.content = estimatedAmount;
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('reservationFee');
    data.content = deposit;
    data.bIcon = true;
    dataList.add(data);

    return dataList;
  }
}
