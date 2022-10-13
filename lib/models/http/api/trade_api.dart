import 'package:treasure_nft_project/models/http/http_manager.dart';
import '../parameter/check_reservation_info.dart';

class TradeAPI extends HttpManager {
  TradeAPI({super.onConnectFail});

  /// 查詢預約資訊
  Future<CheckReservationInfo> getCheckReservationInfoAPI() async {
    var response = await get('/reserve/info');
    response.printLog();
    return CheckReservationInfo.fromJson(response.data);
  }
}
