import 'package:format/format.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/call_back_function.dart';
import '../../constant/global_data.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/parameter/api_response.dart';
import '../../views/explore/api/explore_api.dart';
import '../../views/explore/data/explore_item_response_data.dart';
import '../../views/explore/data/explore_level_info_response_data.dart';

class ExploreItemDetailViewModel extends BaseViewModel {


  String getLevelImg() {
    return format(AppImagePath.level, ({'level': GlobalData.userInfo.level}));
  }

  Future<ExploreItemResponseData> getExploreItemDetail(
      String itemId,
      {ResponseErrorFunction? onConnectFail}) async {

    return await ExploreApi(onConnectFail: onConnectFail)
        .getExploreItemDetail(itemId: itemId);
  }

  Future<ExploreLevelInfoResponseData> getCheckLevelInfoAPI() async {
    return await ExploreApiWithToken().getCheckLevelInfoAPI();
  }

  Future<dynamic> getNewReservationAPI(
      String type, String itemId, ResponseErrorFunction? onConnectFail) async {
    return await ExploreApiWithToken(onConnectFail: onConnectFail, showTrString: false)
        .getNewReservationAPI(type: type, itemId: itemId);
  }
}