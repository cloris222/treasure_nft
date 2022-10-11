import '../../../models/http/http_manager.dart';
import '../../../models/http/http_setting.dart';
import '../../../models/http/parameter/api_response.dart';
import '../data/explore_main_response_data.dart';

class ExploreApi extends HttpManager {
  ExploreApi({super.onConnectFail, super.baseUrl = HttpSetting.developUrl});

  /// 搜尋使用帳戶
  Future<List<ExploreMainResponseData>> getUsers(
      {int page = 1, int size = 10, String search = ''}) async {
    List<ExploreMainResponseData> result =
    <ExploreMainResponseData>[];
    try {
      ApiResponse response =
      await get('/app/discover/user/search', queryParameters: {
        'page': page,
        'size': size,
        'search': search,
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