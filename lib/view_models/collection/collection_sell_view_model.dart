import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../views/collection/api/collection_api.dart';
import '../../views/collection/data/collection_level_fee_response_data.dart';

class ClassSellViewModel extends BaseViewModel {


  Future<CollectionLevelFeeResponseData> getLevelFeeResponse(
      String itemId, {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getLevelFeeResponse(itemId: itemId);
  }

  Future<dynamic> getItemStatusResponse(
      String itemId, String status, {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getItemStatusResponse(itemId: itemId, status: status);
  }


}