import 'package:treasure_nft_project/constant/global_data.dart';

import '../../../views/personal/orders/withdraw/data/withdraw_balance_response_data.dart';
import '../http_manager.dart';
import '../http_setting.dart';
import '../parameter/api_response.dart';

class WithdrawApi extends HttpManager {
  WithdrawApi({super.onConnectFail, super.baseUrl = HttpSetting.appUrl});

  /// 取得餘額提現資訊
  Future<WithdrawBalanceResponseData> getWithdrawBalance(String? chain) async {
    WithdrawBalanceResponseData result = WithdrawBalanceResponseData();
    ApiResponse response;
    try {
      if (chain != null) {
        response = await get('/user/balance-withdraw',
            queryParameters: {'chain': chain});
      } else {
        response = await get('/user/balance-withdraw');
      }
      result = WithdrawBalanceResponseData.fromJson(response.data);
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return result;
  }

  Future<ApiResponse> submitBalanceWithdraw(
      {required String chain,
      required String amount,
      required String address,
      required String account,
      required String emailVerifyCode}) async {
    ApiResponse response = await post('/user/balance-withdraw', data: {
      'chain': chain,
      'amount': amount,
      'address': address,
      'account': account,
      'emailVerifyCode': emailVerifyCode.trim()
    });
    return response;
  }
}
