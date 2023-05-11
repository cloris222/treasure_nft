import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/widgets/card/event_info_card.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/base_view_model.dart';
import '../../../views/collection/data/collection_ticket_response_data.dart';
import '../../card/data/card_showing_data.dart';

class CollectionTicketItemView extends StatefulWidget {
  const CollectionTicketItemView({super.key,
  required this.data,
  required this.index
  });

  final CollectionTicketResponseData data;
  final int index;

  @override
  State<StatefulWidget> createState() => _CollectionTicketItemView();

}

class _CollectionTicketItemView extends State<CollectionTicketItemView> {
  CollectionTicketResponseData get data {
    return widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: EventInfoCard(
          itemStatus: data.itemStatus,
          prizeStatus: data.winPrizeStatus,
          itemName: data.itemName,
          imageUrl: data.imgUrl,
          price: data.itemPrice.toString(),
          prizeAmount: data.winPrizeAmount.toString(),
          prizeLevel: data.winPrize,
          lotteryNo: data.lotteryNo,
          createdAt: BaseViewModel().changeTimeZone(data.createdAt, isShowGmt: false),
          dataList: _getItemData(data.orderNo, data.deposit.toString(), data.ticketValue.toString()))
    );
  }

  List<CardShowingData> _getItemData(String orderNo, String deposit, String ticketValue) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('orderNo');
    data.content = orderNo;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('reservationFee');
    data.content = deposit;
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('ticketValue');
    data.content = ticketValue;
    data.bIcon = true;
    dataList.add(data);

    return dataList;
  }

}