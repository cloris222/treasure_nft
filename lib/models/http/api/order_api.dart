import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';

import '../../../constant/enum/order_enum.dart';
import '../../../views/personal/orders/orderinfo/data/order_message_list_response_data.dart';
import '../parameter/check_earning_income.dart';
import '../parameter/team_share_info.dart';

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
      String startDate = '',
      String endDate = ''}) async {
    ApiResponse response = await get('/order/profit-list', queryParameters: {
      'page': 1,
      'size': 1,
      'startDate': startDate,
      'endDate': endDate,
      'type': getIncomeTypeStr(type),
    });

    return response.data['totalIncome'].toDouble() ?? 0.0;
  }

  getIncomeTypeStr(EarningIncomeType type) {
    switch (type) {
      case EarningIncomeType.ALL:
        return 'ALL';
      case EarningIncomeType.TEAM:
        return 'TEAM';
      case EarningIncomeType.MINE:
        return 'MINE';
      case EarningIncomeType.SAVINGS:
        return 'SAVINGS';
    }
  }

  /// 取得訂單信息列表
  Future<List<OrderMessageListResponseData>> getOrderMessageListResponse(
      {int page = 1,
      int size = 10,
      required OrderInfoType type,
      String startTime = '',
      String endTime = ''}) async {
    List<OrderMessageListResponseData> result =
        <OrderMessageListResponseData>[];
    try {
      ApiResponse response = await get('/order/message-list', queryParameters: {
        'page': page,
        'size': size,
        'type': type.name,
        'startTime': startTime,
        'endTime': endTime
      });
      for (Map<String, dynamic> json in response.data['pageList']) {
        OrderMessageListResponseData data =
            OrderMessageListResponseData.fromJson(json);
        /// 只顯示已開過的寶箱
        if (type == OrderInfoType.TREASURE_BOX) {
          if (data.status == "OPENED") {
            result.add(data);
          }
        } else {
          result.add(data);
        }
      }
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return result;
  }

  ///MARK: 取得團隊分享訊息  (共用團隊分享的Data Class)
  Future<TeamShareInfo> getOrderShareInfo(String orderNo) async {
    var response =
        await get('/order/share-info', queryParameters: {'orderNo': orderNo});
    return TeamShareInfo.fromJson(response.data);
  }
}
