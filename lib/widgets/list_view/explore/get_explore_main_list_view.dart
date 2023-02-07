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
    return getExploreListViewItem(widget.list[index], index);
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    // return SizedBox(height: UIDefine.getScreenWidth(4.16)); // 第一版UI
    return SizedBox(height: UIDefine.getScreenWidth(1));
  }

  int getItemCount() {
    return widget.list.length;
  }

  Widget getExploreListViewItem(ExploreMainResponseData data, int index) {
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
          padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // return createItemBuilder(context, index); // 第一版UI
            // if (index == productList.length - 1) { // 開啟'到底更新'的Flag
            //   bDownloading = false;
            // }
            if (index % 2 == 0 && index == widget.list.length - 1) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(
                      UIDefine.getScreenWidth(5),
                      0,
                      0,
                      UIDefine.getScreenWidth(0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      createItemBuilder(
                          context, index),
                    ],
                  ));
            }
            if (index % 2 != 0) {
              return Container();
            }
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  UIDefine.getScreenWidth(5),
                  0,
                  UIDefine.getScreenWidth(5),
                  UIDefine.getScreenWidth(0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  createItemBuilder(
                      context, index),
                  createItemBuilder(
                      context, index + 1)
                ],
              ),
            );
          },
          itemCount: getItemCount(),
          separatorBuilder: (BuildContext context, int index) {
            return createSeparatorBuilder(context, index);
          },

     ),
    );
  }

  updateView() async {
    page += 1;
    List newList = await viewModel.getExploreResponse(widget.type, page, 15);
    widget.list.addAll(newList);
    setState(() {});
  }

}