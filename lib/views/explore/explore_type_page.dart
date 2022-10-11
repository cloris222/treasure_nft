import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/views/explore/explore_type.dart';

import '../../view_models/explore/explore_main_view_model.dart';
import '../../widgets/list_view/explore/get_explore_main_list_view.dart';
import '../../widgets/loading_future_builder.dart';

class ExploreTypePage extends StatefulWidget {
  const ExploreTypePage(
      {super.key, required this.currentType});

  final ExploreType currentType;

  @override
  State<StatefulWidget> createState() => _ExploreTypePage();
}

class _ExploreTypePage extends State<ExploreTypePage> {
  ExploreMainViewModel viewModel = ExploreMainViewModel();
  List list = [];

  @override
  Widget build(BuildContext context) {
    return LoadingFutureBuilder.createLoadingWidget(
        futureFunction: initView());
  }

  Future<GetExploreMainListView> initView() async {
    list = await viewModel.getExploreResponse(widget.currentType);
    return GetExploreMainListView(list: list, type: widget.currentType);
  }
}
