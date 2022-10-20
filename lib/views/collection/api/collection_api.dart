import '../../../models/http/http_manager.dart';
import '../../../models/http/http_setting.dart';
import '../../../models/http/parameter/api_response.dart';
import '../data/collection_nft_item_response_data.dart';
import '../data/collection_reservation_response_data.dart';

class CollectionApi extends HttpManager {
  CollectionApi({super.onConnectFail, super.baseUrl = HttpSetting.developUrl});

  /// 取得訂單信息列表
  Future<List<CollectionReservationResponseData>> getReservationResponse(
      {int page = 1, int size = 10, String type = ''}) async {
    List<CollectionReservationResponseData> result =
    <CollectionReservationResponseData>[];
    try {
      ApiResponse response =
      await get('/order/message-list', queryParameters: {
        'page': page,
        'size': size,
        'type': type,
        'startTime': '',
        'endTime': ''
      });
      response.printLog();
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(CollectionReservationResponseData.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 查詢會員商品
  Future<List<CollectionNftItemResponseData>> getNFTItemResponse(
      {int page = 1, int size = 10, String status = ''}) async {
    List<CollectionNftItemResponseData> result =
    <CollectionNftItemResponseData>[];
    try {
      ApiResponse response =
      await get('/NFTItem/mine', queryParameters: {
        'page': page,
        'size': size,
        'status': status,
      });
      response.printLog();
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(CollectionNftItemResponseData.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

}

class CollectionApiCommon extends HttpManager {
  CollectionApiCommon({super.onConnectFail, super.baseUrl = HttpSetting.developCommonUrl});

  /// 查詢NFT合約擁有者地址
  Future<String> getContractOwnerResponse() async {
    String result = '';
    try {
      ApiResponse response =
      await get('/query/contractOwner');
      response.printLog();
      result = response.data;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}