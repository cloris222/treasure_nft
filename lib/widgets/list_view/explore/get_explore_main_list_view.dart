import 'package:flutter/cupertino.dart';

import 'package:treasure_nft_project/constant/global_data.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/explore/explore_main_view_model.dart';
import '../../../views/explore/data/explore_main_response_data.dart';
import 'explore_main_item_view.dart';

class GetExploreMainListView extends StatefulWidget {
  const GetExploreMainListView({super.key, required this.list, required this.type});

  final List list;
  final String type;

  @override
  State<StatefulWidget> createState() => _GetExploreMainListView();

}

class _GetExploreMainListView extends State<GetExploreMainListView> {

  ExploreMainViewModel viewModel = ExploreMainViewModel();

  int page = 1;

  Widget createItemBuilder(BuildContext context, int index) {
    return getLikesListViewItem(widget.list[index], index);
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return SizedBox(height: UIDefine.getScreenWidth(4.16));
  }

  int getItemCount() {
    return widget.list.length;
  }

  Widget getLikesListViewItem(ExploreMainResponseData data, int index) {
    return ExploreMainItemView(
        exploreMainResponseData: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          bool isTop = metrics.pixels == 0;
          if (isTop) {
            GlobalData.printLog('At the top');
          } else {
            GlobalData.printLog('At the bottom');
            updateView();
          }
        }
        return true;
      },
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return createItemBuilder(context, index);
          },
          itemCount: getItemCount(),
          separatorBuilder: (BuildContext context, int index) {
            return createSeparatorBuilder(context, index);
          }),
    );
  }

  updateView() async {
    page += 1;
    List newList = await viewModel.getExploreResponse(widget.type, page, 15);
    widget.list.addAll(newList);
    setState(() {});
  }

}