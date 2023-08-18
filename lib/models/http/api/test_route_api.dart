import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../../../constant/enum/route_setting_enum.dart';
import '../parameter/api_response.dart';

class TestRouteAPI extends HttpManager {
  TestRouteAPI({super.replaceRoute});

  /// 線路測試
  Future<ApiResponse> testConnectRoute() {
    return get("/user/route-test");
  }

  /// 紀錄線路延遲
  Future<ApiResponse?> updateRouteDelay(RouteSetting route, num delay) async {
    try {
      return await post("/user/route-delay", data: {"route": route.getFullUrl(), "delay": delay});
    } catch (e) {
      return null;
    }
  }

  /// 更換線路
  Future<ApiResponse> setChangeRoute(RouteSetting route) {
    return post("/user/change-route", data: {"route": route.getFullUrl()});
  }
}
