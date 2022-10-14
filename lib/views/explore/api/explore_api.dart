import '../../../models/http/http_manager.dart';
import '../../../models/http/http_setting.dart';
import '../../../models/http/parameter/api_response.dart';
import '../data/explore_artist_detail_response_data.dart';
import '../data/explore_catogory_response_data.dart';
import '../data/explore_main_response_data.dart';

class ExploreApi extends HttpManager {
  ExploreApi({super.onConnectFail, super.baseUrl = HttpSetting.developUrl, super.addToken = false});

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
      response.printLog();
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(ExploreMainResponseData.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 查詢畫家類型
  Future<List<ExploreCategoryResponseData>> getExploreCatogory() async {
    List<ExploreCategoryResponseData> result =
    <ExploreCategoryResponseData>[];
    try {
      ApiResponse response =
      await get('/explore/category');
      response.printLog();
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
      response.printLog();
      result = ExploreArtistDetailResponseData.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

}