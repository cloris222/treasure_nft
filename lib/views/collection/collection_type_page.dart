import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/enum/collection_enum.dart';
import '../../view_models/collection/collection_main_view_model.dart';
import '../../widgets/list_view/collection/collection_pending_list_view.dart';
import '../../widgets/list_view/collection/collection_reservation_list_view.dart';
import '../../widgets/list_view/collection/collection_selling_list_view.dart';
import '../../widgets/list_view/collection/collection_ticket_list_view.dart';
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
    switch (currentType) {
      case CollectionTag.Reservation:
        return const CollectionReservationListView();
      case CollectionTag.Pending:
        return const CollectionPendingListView();
      case CollectionTag.Selling:
        return const CollectionSellingListView();
      case CollectionTag.Ticket:
        return const CollectionTicketListView();
    }
  }
}
