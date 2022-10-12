import '../../../models/http/http_manager.dart';
import '../../../models/http/http_setting.dart';
import '../../../models/http/parameter/api_response.dart';
import '../data/explore_main_response_data.dart';

class ExploreApi extends HttpManager {
  ExploreApi({super.onConnectFail, super.baseUrl = HttpSetting.developUrl});

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

}