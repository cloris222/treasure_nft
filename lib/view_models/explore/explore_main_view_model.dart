import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../views/explore/api/explore_api.dart';
import '../../views/explore/data/explore_main_response_data.dart';
import '../../views/explore/explore_type.dart';
import '../../views/explore/explore_type_page.dart';

class ExploreMainViewModel extends BaseViewModel {

  List<ExploreType> getExploreTypes() {
    return <ExploreType>[ExploreType.All, ExploreType.ERC_NFT, ExploreType.Polygon_NFT, ExploreType.BSC_NFT];
  }

  Widget getExploreTypePage(ExploreType type) {
    return ExploreTypePage(currentType: type);
  }

  Widget getExploreTypeButtons(
      {required ExploreType currentExploreType,
        required ScrollController controller,
        required Function(ExploreType exploreType) changePage}) {
    List<Widget> buttons = <Widget>[];
    getExploreTypes().forEach((lMessageType) {
      bool isCurrent = (lMessageType == currentExploreType);
      buttons.add(
          IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: _getButtonBg(isCurrent),
                  onPressed: () {
                    changePage(lMessageType);
                  },
                  child: Container(
                    // constraints: BoxConstraints(minWidth: UIDefine.getScreenWidth(36.11)),
                    child: Text(
                      _getPageTitle(lMessageType),
                      style: TextStyle(color: _getButtonColor(isCurrent), fontSize: UIDefine.fontSize14),
                      textAlign: TextAlign.center,
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
    });
    return Row(
        mainAxisAlignment: MainAxisAlignment.start, children: buttons);
  }


  String _getPageTitle(ExploreType type) {
    if (type == ExploreType.All) {
      // return tr("all");
      return "All";

    } else if (type == ExploreType.ERC_NFT) {
      // return tr("ercNft");
      return "ERC NFT";

    } else if (type == ExploreType.Polygon_NFT) {
      // return tr('polygonNft');
      return 'Polygon NFT';

    } else if (type == ExploreType.BSC_NFT) {
      // return tr('bscNft');
      return 'BSC NFT';

    } else {
      return 'unKnown';
    }
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


  ButtonStyle _getButtonBg(bool isCurrent) {
    if (isCurrent) {
      return TextButton.styleFrom(
          // backgroundColor: AppColors.subThemePurple,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))));
    }
    return TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))));
  }

  Future<List<ExploreMainResponseData>> getExploreResponse(
      ExploreType type, int page, int size,
      {ResponseErrorFunction? onConnectFail}) async {
    String category = '';
    switch (type) { // test
      case ExploreType.All:
        category = '';
        break;
      case ExploreType.ERC_NFT:
        category = '';
        break;
      case ExploreType.Polygon_NFT:
        category = '';
        break;
      case ExploreType.BSC_NFT:
        category = '';
        break;
    }
    return await ExploreApi(onConnectFail: onConnectFail)
        .getExploreArtists(page: page, size: size, category: category);
  }
}