import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../views/collection/api/collection_api.dart';

class CollectionTransferViewModel extends BaseViewModel {


  Future<String> getUserCodeResponse(
      String action, String account, String countryName, String type, {ResponseErrorFunction? onConnectFail}) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getUserCodeResponse(action: action, account: account, countryName: countryName, type: type);
  }

  Future<String> getCheckUserCodeResponse(
      String action, String type, String email, String countryName, String phone, String code,
      ResponseErrorFunction? onConnectFail) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getCheckUserCodeResponse(action: action, type: type, email: email,
        countryName: countryName, phone: phone, code: code);
  }

  Future<String> getTransferOutResponse(
      String itemId, String code, ResponseErrorFunction? onConnectFail) async {
    return await CollectionApi(onConnectFail: onConnectFail)
        .getTransferOutResponse(itemId: itemId, code: code);
  }
}