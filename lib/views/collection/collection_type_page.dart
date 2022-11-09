import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view_models/collection/collection_main_view_model.dart';
import '../../widgets/list_view/collection/get_collection_main_list_view.dart';
import '../../widgets/loading_future_builder.dart';

class CollectionTypePage extends StatefulWidget {
  const CollectionTypePage({super.key, required this.currentType});

  final String currentType;

  @override
  State<StatefulWidget> createState() => _CollectionTypePage();
}

class _CollectionTypePage extends State<CollectionTypePage> {
  String get currentType {
    return widget.currentType;
  }

  CollectionMainViewModel viewModel = CollectionMainViewModel();
  List responseList = [];

  @override
  Widget build(BuildContext context) {
    return LoadingFutureBuilder.createLoadingWidget(
        futureFunction: _initView());
  }

  Future<GetCollectionMainListview> _initView() async {
    if (currentType == 'Reservation') {
      responseList = await viewModel.getReservationResponse('ITEM', 1, 10);
      List tempList = await viewModel.getReservationResponse('PRICE', 1, 10);
      responseList.addAll(tempList);
      return GetCollectionMainListview(list: responseList, currentType: currentType);

    } else if (currentType == 'Selling') {
      responseList = await viewModel.getNFTItemResponse('SELLING', 1, 10);
      return GetCollectionMainListview(list: responseList, currentType: currentType);

    } else {
      responseList = await viewModel.getNFTItemResponse('PENDING', 1, 10);
      return GetCollectionMainListview(list: responseList, currentType: currentType);
    }
  }
}