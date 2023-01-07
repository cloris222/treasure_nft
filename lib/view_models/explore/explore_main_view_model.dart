import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/ui_define.dart';
import '../../views/explore/api/explore_api.dart';
import '../../views/explore/data/explore_category_response_data.dart';
import '../../views/explore/data/explore_main_response_data.dart';
import '../../views/explore/explore_type_page.dart';

class ExploreMainViewModel extends BaseViewModel {

  Widget getExploreTypePage(String type) {
    return ExploreTypePage(currentType: type);
  }

  Widget getExploreTypeButtons(
      {required String currentExploreType,
        required List<ExploreCategoryResponseData> dataList,
        required ItemScrollController controller,
        required Function(String exploreType) changePage}) {
    List<Widget> buttons = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      bool isCurrent = (dataList[i].name == currentExploreType);
      buttons.add(
        SizedBox(
          height: UIDefine.getScreenWidth(12),
          child: TextButton(
            onPressed: () {
              changePage(dataList[i].name);
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(
                  UIDefine.getScreenWidth(2.77), 0,
                  UIDefine.getScreenWidth(2.77), 0),
              child: Text(
                _getTabTitle(dataList[i].name),
                style: AppTextStyle.getBaseStyle(color: _getButtonColor(isCurrent),
                    fontSize: _getTextSize(isCurrent), fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }
      return SizedBox(
          height: UIDefine.getScreenWidth(13),
          child: ScrollablePositionedList.builder(
              scrollDirection: Axis.horizontal,
              itemScrollController: controller,
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return buttons[index];
              }
          )
      );
    }

  // Widget getExploreTypeButtons( // 第一版的UI樣式
  //     {required String currentExploreType,
  //       required List<ExploreCategoryResponseData> dataList,
  //       required ItemScrollController controller,
  //       required Function(String exploreType) changePage}) {
  //   List<Widget> buttons = <Widget>[];
  //   for (int i = 0; i < dataList.length; i++) {
  //     bool isCurrent = (dataList[i].name == currentExploreType);
  //     buttons.add(
  //         IntrinsicWidth(
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: UIDefine.getScreenWidth(12),
  //                 child: TextButton(
  //                   onPressed: () {
  //                     changePage(dataList[i].name);
  //                   },
  //                   child: Container(
  //                     padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(2.77), 0, UIDefine.getScreenWidth(2.77), 0),
  //                     child: Text(
  //                       _getTabTitle(dataList[i].name),
  //                       style: CustomTextStyle.getBaseStyle(color: _getButtonColor(isCurrent), fontSize: UIDefine.fontSize16),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 height: _getLineHeight(isCurrent),
  //                 color: _getLineColor(isCurrent),
  //               ),
  //             ],
  //           ),
  //         )
  //     );
  //   }
  //   return SizedBox(
  //       height: UIDefine.getScreenWidth(13),
  //       child:  ScrollablePositionedList.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemScrollController: controller,
  //           itemCount: buttons.length,
  //           itemBuilder: (context, index) {
  //             return buttons[index];
  //           }
  //       )
  //   );
  // }

  String _getTabTitle(String value) {
    switch(value) {
      case '':
        return tr('TopPicks');
      case 'polygonNFT':
        return tr('polygonNFT');
      case 'artwork':
        return tr('art');
      case 'collection':
        return tr('collectibles');
      // case 'bscNFT':
      //   return tr('bSCNFT');
      // case 'domain':
      //   return tr('domainNames');
      // case 'ercNFT':
      //   return tr('eRCNFT');
      // case 'facility':
      //   return tr('utility');
      // case 'music':
      //   return tr('music');
      // case 'photo':
      //   return tr('photography');
      // case 'sport':
      //   return tr('sports');
      // case 'tradeCard':
      //   return tr('tradingCards');
    }
    return '';
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

  double _getTextSize(bool isCurrent) {
    if (isCurrent) return UIDefine.fontSize20;
    return UIDefine.fontSize14;
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
        .getExploreCategory();
  }
}