import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/collection/api/collection_api.dart';
import 'package:treasure_nft_project/views/collection/collection_type_page.dart';

import '../../constant/call_back_function.dart';
import '../../constant/ui_define.dart';
import '../../views/collection/data/collection_nft_item_response_data.dart';
import '../../views/collection/data/collection_reservation_response_data.dart';

class CollectionMainViewModel extends BaseViewModel {

  Widget getCollectionTypePage(String type) {
    return CollectionTypePage(currentType: type);
  }

  Widget getCollectionTypeButtons(
      {required String currentExploreType,
        required List<String> dataList,
        required ScrollController controller,
        required Function(String exploreType) changePage}) {
    List<Widget> buttons = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      bool isCurrent = (dataList[i] == currentExploreType);
      buttons.add(
          IntrinsicWidth(
            child: Column(
              children: [
                SizedBox(
                  height: UIDefine.getScreenWidth(12),
                  child: TextButton(
                    onPressed: () {
                      changePage(dataList[i]);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.5), 0, UIDefine.getScreenWidth(3), 0),
                      child: Text(
                        dataList[i], // test 要改成tr
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

  Future<List<CollectionNftItemResponseData>> getNFTItemResponse(
      String status, int page, int size, {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getNFTItemResponse(page: page, size: size, status: status);
  }

  Future<List<CollectionReservationResponseData>> getReservationResponse(
      String type, int page, int size, {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getReservationResponse(page: page, size: size, type: type);
  }

}