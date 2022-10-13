import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/ui_define.dart';
import '../../views/explore/api/explore_api.dart';
import '../../views/explore/data/explore_catogory_response_data.dart';
import '../../views/explore/data/explore_main_response_data.dart';
import '../../views/explore/explore_type_page.dart';

class ExploreMainViewModel extends BaseViewModel {

  Widget getExploreTypePage(String type) {
    return ExploreTypePage(currentType: type);
  }

  Widget getExploreTypeButtons(
      {required String currentExploreType,
        required List<ExploreCategoryResponseData> dataList,
        required ScrollController controller,
        required Function(String exploreType) changePage}) {
    List<Widget> buttons = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      bool isCurrent = (dataList[i].name == currentExploreType);
      buttons.add(
          IntrinsicWidth(
            child: Column(
              children: [
                SizedBox(
                  height: UIDefine.getScreenWidth(12),
                  child: TextButton(
                    onPressed: () {
                      changePage(dataList[i].name);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(2.77), 0, UIDefine.getScreenWidth(2.77), 0),
                      child: Text(
                        dataList[i].frontName,
                        style: TextStyle(color: _getButtonColor(isCurrent), fontSize: UIDefine.fontSize16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _getLineHeight(isCurrent),
                  color: _getLineColor(isCurrent),
                ),
              ],
            ),
          )
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: buttons
      ),
    );
  }

  double _getLineHeight(bool isCurrent) {
    if (isCurrent) return 2.5;
    return 1;
  }

  Color _getLineColor(bool isCurrent) {
    if (isCurrent) return Colors.blue;
    return Colors.grey;
  }

  Color _getButtonColor(bool isCurrent) {
    if (isCurrent) return Colors.black;
    return Colors.grey;
  }

  Future<List<ExploreMainResponseData>> getExploreResponse(
      String type, int page, int size, {ResponseErrorFunction? onConnectFail}) async {
    String category = type;
    return await ExploreApi(onConnectFail: onConnectFail)
        .getExploreArtists(page: page, size: size, category: category);
  }

  Future<List<ExploreCategoryResponseData>> getExploreCategory(
      {ResponseErrorFunction? onConnectFail}) async {
    return await ExploreApi(onConnectFail: onConnectFail)
        .getExploreCatogory();
  }
}