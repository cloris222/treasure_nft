import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';

import '../../../views/personal/orders/orderinfo/data/order_message_list_response_data.dart';
import '../parameter/check_earning_income.dart';

class OrderAPI extends HttpManager {
  OrderAPI({super.onConnectFail});

  /// 查詢收益明細
  Future<List<CheckEarningIncomeData>> getEarningData(
      {EarningIncomeType type = EarningIncomeType.ALL,
      int page = 1,
      int size = 10,
      String startDate = '',
      String endDate = ''}) async {
    ApiResponse response = await get('/order/profit-list', queryParameters: {
      'page': page,
      'size': size,
      'startDate': startDate,
      'endDate': endDate,
      'type': getIncomeTypeStr(type),
    });
    List<CheckEarningIncomeData> result = <CheckEarningIncomeData>[];
    for (Map<String, dynamic> json in response.data['pageList']['pageList']) {
      result.add(CheckEarningIncomeData.fromJson(json));
    }

    ///MARK: 偷偷的存起來
    if (type == EarningIncomeType.ALL &&
        page == 1 &&
        size == 10 &&
        startDate.isEmpty &&
        endDate.isEmpty) {
      AppSharedPreferences.setProfitRecord(result);
    }
    return result;
  }

  /// 查詢收益明細 “裡面的總收入”
  Future<double> getPersonalIncome(
      {EarningIncomeType type = EarningIncomeType.ALL,
      int page = 1,
      int size = 1,
      String startDate = '',
      String endDate = ''}) async {
    ApiResponse response = await get('/order/profit-list', queryParameters: {
      'page': page,
      'size': size,
      'startDate': startDate,
      'endDate': endDate,
      'type': getIncomeTypeStr(type),
    });

    return response.data['totalIncome'].toDouble() ?? 0.0;
  }

  /// 暫存查詢收益明細 “裡面的總收入”
  Future<double> saveTempTotalIncome() async {
    GlobalData.totalIncome = await getPersonalIncome();
    return GlobalData.totalIncome ?? 0.0;
  }

  /// 暫存查詢收益明細紀錄
  Future<void> saveTempRecord() async {
    await OrderAPI().getEarningData(
        page: 1,
        size: 10,
        startDate: '',
        endDate: '',
        type: EarningIncomeType.ALL);
  }

  getIncomeTypeStr(EarningIncomeType type) {
    switch (type) {
      case EarningIncomeType.ALL:
        return 'ALL';
      case EarningIncomeType.TEAM:
        return 'TEAM';
      case EarningIncomeType.MINE:
        return 'MINE';
    }
  }

  /// 取得訂單信息列表
  Future<List<OrderMessageListResponseData>> getOrderMessageListResponse(
      {int page = 1,
      int size = 10,
      String type = '',
      String startTime = '',
      String endTime = ''}) async {
    List<OrderMessageListResponseData> result =
        <OrderMessageListResponseData>[];
    try {
      ApiResponse response = await get('/order/message-list', queryParameters: {
        'page': page,
        'size': size,
        'type': type,
        'startTime': startTime,
        'endTime': endTime
      });
      for (Map<String, dynamic> json in response.data['pageList']) {
        result.add(OrderMessageListResponseData.fromJson(json));
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
