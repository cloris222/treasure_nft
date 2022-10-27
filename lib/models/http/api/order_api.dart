import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';

import '../parameter/check_earning_income.dart';

class OrderAPI extends HttpManager {
  OrderAPI({super.onConnectFail});

  /// 查詢收益明細
  // Future<List<CheckEarningIncomeData>> getPersonalVideoPost(
  //     {String type = '', int page = 1, int size = 10, String starDate, String endDate}) async {
  //   ApiResponse response = await get('/order/profit-list',
  //       queryParameters: {
  //         'page': page,
  //         'size': size,
  //         'startDate': startDate,
  //         'endDate': endDate,
  //         'type': type,
  //       });
  //   response.printLog();
  //   List<CheckEarningIncomeData> result = <CheckEarningIncomeData>[];
  //   for (Map<String, dynamic> json in response.data['pageList']) {
  //     result.add(CheckEarningIncomeData.fromJson(json));
  //   }
  //   return result;
  // }

}
