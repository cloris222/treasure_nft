import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/collection/api/collection_api.dart';
import 'package:treasure_nft_project/views/collection/collection_type_page.dart';

import '../../constant/call_back_function.dart';
import '../../constant/ui_define.dart';
import '../../views/collection/data/collection_nft_item_response_data.dart';
import '../../views/collection/data/collection_reservation_response_data.dart';
import '../../views/collection/data/collection_ticket_response_data.dart';

class CollectionMainViewModel extends BaseViewModel {

  Widget getCollectionTypePage(String type) {
    return CollectionTypePage(currentType: type);
  }

  Widget getCollectionTypeButtons(
      {required String currentExploreType,
        required List<String> dataList,
        required ItemScrollController controller,
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
                        _getTabTitle(dataList[i]),
                        style: AppTextStyle.getBaseStyle(color: _getButtonColor(isCurrent), fontSize: UIDefine.fontSize16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _getLineHeight(isCurrent),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getLineColor(isCurrent)
                    )
                  ),
                ),
              ],
            ),
          )
      );
    }
    return SizedBox(
        height: UIDefine.getScreenWidth(13),
        child:  ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal,
            itemScrollController: controller,
            itemCount: buttons.length,
            itemBuilder: (context, index) {
              return buttons[index];
            }
        )
    );
  }

  String _getTabTitle(String value) {
    switch(value) {
      case 'Reservation':
        return tr('tab_reserve');
      case 'Selling':
        return tr('tab_selling');
      case 'Pending':
        return tr('tab_unsell');
      case 'Ticket':
        return tr('myTicket');
    }
    return '';
  }

  double _getLineHeight(bool isCurrent) {
    if (isCurrent) return 2.5;
    return 1;
  }

  List<Color> _getLineColor(bool isCurrent) {
    if (isCurrent) return AppColors.gradientBaseColorBg;
    return [AppColors.lineBarGrey, AppColors.lineBarGrey];
  }

  Color _getButtonColor(bool isCurrent) {
    if (isCurrent) return Colors.black;
    return Colors.grey;
  }

  Future<List<CollectionReservationResponseData>> getReservationResponse(
      String type, int page, int size, {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getReservationResponse(page: page, size: size, type: type);
  }

  Future<List<CollectionNftItemResponseData>> getNFTItemResponse(
      String status, int page, int size, {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getNFTItemResponse(page: page, size: size, status: status);
  }

  Future<List<CollectionTicketResponseData>> getTicketResponse(
      String type, int page, int size, {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getTicketResponse(page: page, size: size, type: type);
  }

  Future<String> getOpenBoxResponse({required String action, required String itemId,
    ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getOpenBoxResponse(action: action, itemId: itemId);
  }

  Future<String> requestMakeUpBalance(
      {required String recordNo, ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .requestMakeUpBalance(recordNo: recordNo);
  }

}