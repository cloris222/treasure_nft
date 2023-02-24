import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/enum/collection_enum.dart';
import '../../view_models/collection/collection_main_view_model.dart';
import '../../widgets/list_view/collection/get_collection_main_list_view.dart';
import '../../widgets/loading_future_builder.dart';
import 'data/collection_nft_item_response_data.dart';
import 'data/collection_reservation_response_data.dart';
import 'data/collection_ticket_response_data.dart';

class CollectionTypePage extends StatefulWidget {
  const CollectionTypePage({super.key, required this.currentType});

  final CollectionTag currentType;

  @override
  State<StatefulWidget> createState() => _CollectionTypePage();
}

class _CollectionTypePage extends State<CollectionTypePage> {
  CollectionMainViewModel viewModel = CollectionMainViewModel();

  CollectionTag get currentType {
    return widget.currentType;
  }

  List<CollectionReservationResponseData> reserveList = [];
  List<CollectionNftItemResponseData> itemsList = [];
  List<CollectionTicketResponseData> ticketList = [];

  @override
  Widget build(BuildContext context) {
    return LoadingFutureBuilder.createLoadingWidget(
        futureFunction: _initView());
  }

  Future<GetCollectionMainListview> _initView() async {
    switch (currentType) {
      case CollectionTag.Reservation:
        reserveList = await viewModel.getReservationResponse('ITEM', 1, 10);
        var tempList = await viewModel.getReservationResponse('PRICE', 1, 10);
        reserveList.addAll(tempList);
        return GetCollectionMainListview(
            reserveList: reserveList,
            itemsList: [],
            ticketList: [],
            currentType: currentType);
      case CollectionTag.Pending:
        itemsList = await viewModel.getNFTItemResponse('PENDING', 1, 10);
        return GetCollectionMainListview(
            reserveList: [],
            itemsList: itemsList,
            ticketList: [],
            currentType: currentType);
      case CollectionTag.Selling:
        itemsList = await viewModel.getNFTItemResponse('SELLING', 1, 10);
        return GetCollectionMainListview(
            reserveList: [],
            itemsList: itemsList,
            ticketList: [],
            currentType: currentType);
      case CollectionTag.Ticket:
        ticketList = await viewModel.getTicketResponse('TICKET', 1, 10);
        return GetCollectionMainListview(
            reserveList: [],
            itemsList: [],
            ticketList: ticketList,
            currentType: currentType);
    }
  }
}
