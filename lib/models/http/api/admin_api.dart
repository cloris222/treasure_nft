import '../http_manager.dart';
import '../http_setting.dart';
import '../parameter/api_response.dart';

class AdminAPI extends HttpManager {
  AdminAPI({super.onConnectFail, super.baseUrl = HttpSetting.adminUrl});

  ///MARK: 新手到期提示
  Future<ApiResponse> getBeginerHint() async {
    return get('/newbie/config-account');
  }

}