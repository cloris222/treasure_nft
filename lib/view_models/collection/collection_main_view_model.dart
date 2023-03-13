import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/collection/api/collection_api.dart';

import '../../constant/call_back_function.dart';
import '../../constant/enum/collection_enum.dart';
import '../../constant/ui_define.dart';
import '../../views/collection/data/collection_nft_item_response_data.dart';
import '../../views/collection/data/collection_reservation_response_data.dart';
import '../../views/collection/data/collection_ticket_response_data.dart';

class CollectionMainViewModel extends BaseViewModel {
  Widget getCollectionTypeButtons(
      {required CollectionTag currentExploreType,
      required ItemScrollController controller,
      required Function(CollectionTag tag) changePage}) {
    List<Widget> buttons = <Widget>[];
    for (int i = 0; i < CollectionTag.values.length; i++) {
      CollectionTag tag = CollectionTag.values[i];
      bool isCurrent = (tag == currentExploreType);
      buttons.add(IntrinsicWidth(
        child: Column(
          children: [
            SizedBox(
              height: UIDefine.getScreenWidth(12),
              child: TextButton(
                onPressed: () {
                  changePage(tag);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.5), 0,
                      UIDefine.getScreenWidth(3), 0),
                  child: Text(
                    _getTabTitle(tag),
                    style: AppTextStyle.getBaseStyle(
                        color: _getButtonColor(isCurrent),
                        fontSize: UIDefine.fontSize16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              height: _getLineHeight(isCurrent),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: _getLineColor(isCurrent))),
            ),
          ],
        ),
      ));
    }
    return SizedBox(
        height: UIDefine.getScreenWidth(13),
        child: ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal,
            itemScrollController: controller,
            itemCount: buttons.length,
            itemBuilder: (context, index) {
              return buttons[index];
            }));
  }

  String _getTabTitle(CollectionTag tag) {
    switch (tag) {
      case CollectionTag.Reservation:
        return tr('tab_reserve');
      case CollectionTag.Selling:
        return tr('tab_selling');
      case CollectionTag.Pending:
        return tr('tab_unsell');
      case CollectionTag.Ticket:
        return tr('myTicket');
    }
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

  // Future<List<CollectionReservationResponseData>> getReservationResponse(
  //     String type, int page, int size,
  //     {ResponseErrorFunction? onConnectFail}) async {
  //   return await CollectionApi(onConnectFail: onConnectFail)
  //       .getReservationResponse(page: page, size: size, type: type);
  // }

  Future<List<CollectionNftItemResponseData>> getNFTItemResponse(
      String status, int page, int size,
      {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getNFTItemResponse(page: page, size: size, status: status);
  }

  Future<List<CollectionTicketResponseData>> getTicketResponse(
      String type, int page, int size,
      {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getTicketResponse(page: page, size: size, type: type);
  }

  Future<String> getOpenBoxResponse(
      {required String action,
      required String itemId,
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
