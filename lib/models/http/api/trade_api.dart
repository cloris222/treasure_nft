import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import '../parameter/add_new_reservation.dart';
import '../parameter/check_experience_info.dart';
import '../parameter/check_reservation_info.dart';
import '../parameter/check_reserve_deposit.dart';

class TradeAPI extends HttpManager {
  TradeAPI({super.onConnectFail, super.showTrString});

  /// step1: 查詢副本歸屬區間資訊
  Future<List<int>> getDivisionAPI() async {
    var response = await get('/reserve/division');
    return List<int>.from(response.data.map((x) => x));
  }

  /// step2: 查詢預約資訊
  Future<CheckReservationInfo> getCheckReservationInfoAPI(int division) async {
    var response =
        await get('/reserve/info', queryParameters: {'division': division});
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
    //  response.printLog();
    return CheckReserveDeposit.fromJson(response.data);
  }

  /// 新增預約
  Future<ApiResponse> postAddNewReservationAPI(
      {required String type,
      required int reserveCount,
      required dynamic startPrice,
      required dynamic endPrice,
      required int priceIndex}) async {
    return post('/reserve/insert', data: {
      'type': type,
      'reserveCount': reserveCount,
      'startPrice': startPrice,
      'endPrice': endPrice,
      'priceIndex': priceIndex
    });
  }

  /// 取得體驗帳號資訊
  Future<ExperienceInfo> getExperienceInfoAPI() async {
    var response = await get('/experience/experience-info');
    GlobalData.experienceInfo = ExperienceInfo.fromJson(response.data);
    return GlobalData.experienceInfo;
  }
}
