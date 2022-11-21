import '../../../models/http/http_manager.dart';
import '../../../models/http/http_setting.dart';
import '../../../models/http/parameter/api_response.dart';
import '../data/explore_artist_detail_response_data.dart';
import '../data/explore_category_response_data.dart';
import '../data/explore_item_response_data.dart';
import '../data/explore_level_info_response_data.dart';
import '../data/explore_main_response_data.dart';
import '../data/explore_reserve_insert_response_error_data.dart';

class ExploreApi extends HttpManager {
  ExploreApi({super.onConnectFail, super.baseUrl = HttpSetting.appUrl, super.addToken = false});

  /// 查詢探索首頁
  Future<List<ExploreMainResponseData>> getExploreArtists(
      {int page = 1, int size = 10, String category = ''}) async {
    List<ExploreMainResponseData> result =
    <ExploreMainResponseData>[];
    try {
      ApiResponse response =
      await get('/explore/artists', queryParameters: {
        'page': page,
        'size': size,
        'category': category,
      });
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(ExploreMainResponseData.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 查詢畫家類型
  Future<List<ExploreCategoryResponseData>> getExploreCategory() async {
    List<ExploreCategoryResponseData> result =
    <ExploreCategoryResponseData>[];
    try {
      ApiResponse response =
      await get('/explore/category');
      for (Map<String, dynamic> json in response.data) {
        result.add(ExploreCategoryResponseData.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 查詢商品列表
  Future<ExploreArtistDetailResponseData> getExploreArtistDetail(
      {int page = 1, int size = 10, String artistId = '', String name = '', String sortBy = ''}) async {
    ExploreArtistDetailResponseData result = ExploreArtistDetailResponseData(sms: [], list: ListClass(pageList: []));
    try {
      ApiResponse response =
      await get('/explore/artist/detail', queryParameters: {
        'artistId': artistId,
        'name': name,
        'page': page,
        'size': size,
        'sortBy': sortBy,
      });
      result = ExploreArtistDetailResponseData.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 查詢單一商品詳細資訊
  Future<ExploreItemResponseData> getExploreItemDetail(
      {String itemId = ''}) async {
    ExploreItemResponseData result = ExploreItemResponseData(priceHistory: [], sellTimeList: []);
    try {
      ApiResponse response =
      await get('/explore/item', queryParameters: {
        'itemId': itemId,
      });
      result = ExploreItemResponseData.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}

class ExploreApiWithToken extends HttpManager {
  ExploreApiWithToken({super.onConnectFail, super.baseUrl = HttpSetting.appUrl, super.showTrString});

  /// 查詢等級資訊
  Future<ExploreLevelInfoResponseData> getCheckLevelInfoAPI() async {
    var response = await get('/level/user-info');
    return ExploreLevelInfoResponseData.fromJson(response.data);
  }

  /// 新增預約
  Future<dynamic> getNewReservationAPI(
      {required String type, required String itemId}) async {
    dynamic result;
    try {
      ApiResponse response =
      await post('/reserve/insert', data: {
        'type': type,
        'itemId': itemId,
      });
      if (response.code == 'APP_0041') {
        result = ExploreReserveInsertResponseErrorData.fromJson(response.data);

      } else {
        result = response.message;
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}