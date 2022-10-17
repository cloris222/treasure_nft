import 'package:format/format.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/global_data.dart';
import '../../constant/theme/app_image_path.dart';
import '../../views/explore/api/explore_api.dart';
import '../../views/explore/data/explore_item_response_data.dart';

class ExploreProductDetailViewModel extends BaseViewModel {


  String getLevelImg() {
    return format(AppImagePath.level, ({'level': GlobalData.userInfo.level}));
  }

  Future<ExploreItemResponseData> getExploreItemDetail(
      String itemId,
      {ResponseErrorFunction? onConnectFail}) async {

    return await ExploreApi(onConnectFail: onConnectFail)
        .getExploreItemDetail(itemId: itemId);
  }
}