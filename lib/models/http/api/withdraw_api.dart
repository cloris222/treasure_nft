import '../../../views/personal/orders/withdraw/data/withdraw_balance_response_data.dart';
import '../http_manager.dart';
import '../http_setting.dart';
import '../parameter/api_response.dart';

class WithdrawApi extends HttpManager {
  WithdrawApi({super.onConnectFail, super.baseUrl = HttpSetting.appUrl});

  /// 取得餘額提現資訊
  Future<WithdrawBalanceResponseData> getWithdrawBalance() async {
    WithdrawBalanceResponseData result = WithdrawBalanceResponseData();
    try {
      ApiResponse response = await get('/user/balance-withdraw');
      response.printLog();
      result = WithdrawBalanceResponseData.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<ApiResponse> submitBalanceWithdraw(
      {required String address, required String amount}) async {
    ApiResponse response = await post('/user/balance-withdraw', data: {
      'type': 'USDT',
      'address': address,
      'amount': amount
    });
    response.printLog();
    return response;
  }

}