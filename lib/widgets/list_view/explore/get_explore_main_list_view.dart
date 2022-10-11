import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/views/explore/explore_type.dart';

import '../../../constant/ui_define.dart';
import '../../../views/explore/data/explore_main_response_data.dart';
import 'explore_main_item_view.dart';

class GetExploreMainListView extends StatefulWidget {
  const GetExploreMainListView({super.key, required this.list, required this.type,});

  final List list;
  final ExploreType type;

  @override
  State<StatefulWidget> createState() => _GetExploreMainListView();

}

class _GetExploreMainListView extends State<GetExploreMainListView> {

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
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return createItemBuilder(context, index);
        },
        itemCount: getItemCount(),
        separatorBuilder: (BuildContext context, int index) {
          return createSeparatorBuilder(context, index);
        });
  }

}