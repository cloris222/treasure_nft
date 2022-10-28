import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';

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

    return response.data['totalIncome'].toDouble()?? 0.0;
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
}
