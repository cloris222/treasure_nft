import '../../../models/http/http_manager.dart';
import '../../../models/http/http_setting.dart';
import '../../../models/http/parameter/api_response.dart';
import '../data/collection_item_status_response_error_data.dart';
import '../data/collection_level_fee_response_data.dart';
import '../data/collection_nft_item_response_data.dart';
import '../data/collection_reservation_response_data.dart';
import '../data/collection_ticket_response_data.dart';

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
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(CollectionNftItemResponseData.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 查詢我的票券
  Future<List<CollectionTicketResponseData>> getTicketResponse(
      {int page = 1, int size = 10, String type = ''}) async {
    List<CollectionTicketResponseData> result =
    <CollectionTicketResponseData>[];
    try {
      ApiResponse response =
      await get('/order/message-list', queryParameters: {
        'page': page,
        'size': size,
        'type': type,
        'startTime': '',
        'endTime': ''
      });
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(CollectionTicketResponseData.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 發送驗證碼
  Future<String> getUserCodeResponse({
    required String action, required String account, required String countryName, required String type}) async {
    String result = '';
    try {
      ApiResponse response =
      await get('/user/code', queryParameters: {
        'action': action,
        'account': account,
        'countryName': countryName,
        'type': type,
      });
      result = response.message;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 檢查驗證碼
  Future<String> getCheckUserCodeResponse({
    required String action, required String type, required String countryName,
    required String email, required String phone, required String code}) async {
    String result = '';
    try {
      ApiResponse response =
      await post('/user/code', data: {
        'action': action,
        'email': email,
        'countryName': countryName,
        'type': type,
        'phone': phone,
        'code': code,
      });
      result = response.message;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 轉出NFT
  Future<String> getTransferOutResponse({
    required String itemId, required String code}) async {
    String result = '';
    try {
      ApiResponse response =
      await post('/NFTItem/transferOut', data: {
        'itemId': itemId,
        'code': code,
      });
      result = response.message;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 手續費資訊
  Future<CollectionLevelFeeResponseData> getLevelFeeResponse({
    required String itemId}) async {
    CollectionLevelFeeResponseData result = CollectionLevelFeeResponseData();
    try {
      ApiResponse response =
      await get('/level/fee', queryParameters: {
        'itemId': itemId,
      });
      result = CollectionLevelFeeResponseData.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 上下架商品
  Future<dynamic> getItemStatusResponse({
    required String itemId, required String status}) async {
    dynamic result;
    try {
      ApiResponse response =
      await post('/NFTItem/status', data: {
        'itemId': itemId,
        'status': status,
      });
      if (response.code == 'APP_0062') {
        result = CollectionItemStatusResponseErrorData.fromJson(response.data);

      } else {
        result = response.message;
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 開箱盲盒 / 解鎖NFT
  Future<String> getOpenBoxResponse({
    required String action, required String itemId}) async {
    String result = '';
    try {
      ApiResponse response =
      await post('/NFTItem/reward/open', data: {
        'action': action,
        'itemId': itemId,
      });
      result = response.message;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 查詢錢包餘額
  Future<num> getWalletBalanceResponse() async {
    num result = 0;
    try {
      ApiResponse response =
      await get('/user/balance');
      result = response.data;
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
      result = response.data;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}