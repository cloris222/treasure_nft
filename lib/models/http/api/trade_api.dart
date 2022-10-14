import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import '../parameter/add_new_reservation.dart';
import '../parameter/check_reservation_info.dart';
import '../parameter/check_reserve_deposit.dart';

class TradeAPI extends HttpManager {
  TradeAPI({super.onConnectFail});

  /// 查詢預約資訊
  Future<CheckReservationInfo> getCheckReservationInfoAPI() async {
    var response = await get('/reserve/info');
    response.printLog();
    return CheckReservationInfo.fromJson(response.data);
  }

  /// 查詢預約金
  Future<CheckReserveDeposit> getCheckReserveDepositAPI(
      int index, double startPrice, double endPrice) async {
    var response = await get('/reserve/deposit', queryParameters: {
      'index': index,
      'startPrice': startPrice,
      'endPrice': endPrice
    });
    response.printLog();
    return CheckReserveDeposit.fromJson(response.data);
  }

  /// 新增預約
  Future<Future<ApiResponse>> postAddNewReservationAPI(
      {required String type}) async {
    return post('/reserve/insert', data: {'type': type});
  }
}
