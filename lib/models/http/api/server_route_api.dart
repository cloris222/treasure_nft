import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../../../constant/enum/server_route_enum.dart';
import '../parameter/api_response.dart';

class ServerRouteAPI extends HttpManager {
  ServerRouteAPI({super.replaceRoute});

  /// 線路測試
  Future<ApiResponse> testConnectRoute() {
    return get("/user/route-test");
  }

  /// 紀錄線路延遲
  Future<ApiResponse?> updateRouteDelay(ServerRoute route, num delay) async {
    try {
      return await post("/user/route-delay", data: {"route": route.getFullUrl(), "delay": delay});
    } catch (e) {
      return null;
    }
  }

  /// 更換線路
  Future<ApiResponse> setChangeRoute(ServerRoute route) {
    return post("/user/change-route", data: {"route": route.getFullUrl()});
  }
}
