import '../http_manager.dart';
import '../http_setting.dart';

class CommonAPI extends HttpManager {
  CommonAPI({super.onConnectFail, super.baseUrl = HttpSetting.developCommonUrl});

}

