import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
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
      buttons.add(TextButton(
          style: _getButtonBg(isCurrent),
          onPressed: () {
            changePage(lMessageType);
          },
          child: Container(
            constraints: BoxConstraints(minWidth: UIDefine.getScreenWidth(36.11)),
            child: Text(
              _getPageTitle(lMessageType),
              style: TextStyle(color: _getButtonColor(isCurrent), fontSize: UIDefine.fontSize14),
              textAlign: TextAlign.center,
            ),
          )));
    });
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, children: buttons);
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

  Color _getButtonColor(bool isCurrent) {
    if (isCurrent) return Colors.white;
    return Colors.grey;
  }


  ButtonStyle _getButtonBg(bool isCurrent) {
    if (isCurrent) {
      return TextButton.styleFrom(
          backgroundColor: AppColors.subThemePurple,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))));
    }
    return TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }

  Future<ExploreMainResponseData> getExploreResponse(
      ExploreType type, int page, int size, String search,
      {ResponseErrorFunction? onConnectFail}) async {
    return await ExploreApi(onConnectFail: onConnectFail)
        .getExploreArtists(page: page, size: size, search: search);
  }
}