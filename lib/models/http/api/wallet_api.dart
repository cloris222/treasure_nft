import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../../../constant/enum/coin_enum.dart';
import '../parameter/api_response.dart';

class WalletAPI extends HttpManager {
  WalletAPI({super.onConnectFail});

  ///MARK: 取得充值資訊
  Future<Map<String, dynamic>> getBalanceRecharge() async {
    Map<String, String> result = {};
    var response = await get('/user/balance-recharge');
    for (Map<String, dynamic> json in response.data) {
      result[json['chain']] = json['address'];
    }
    if (!result.containsKey(CoinEnum.TRON.name)) {
      result[CoinEnum.TRON.name] = '';
    }
    if (!result.containsKey(CoinEnum.BSC.name)) {
      result[CoinEnum.BSC.name] = '';
    }

    return result;
  }

  ///MARK: 取得支付資訊
  Future<Map<String, dynamic>> getPaymentInfo() async {
    Map<String, String> result = {};
    var response = await get('/payment/info');
    for (Map<String, dynamic> json in response.data) {
      result[json['payType']] = json['account'];
    }
    return result;
  }

  Future<ApiResponse> setPaymentInfo(
      {required String accountTRON,
      required String accountBSC,
      required String accountROLLOUT}) async {
    return put('/payment/update', data: {
      "paymentList": [
        {"payType": "TRON", "account": accountTRON},
        {"payType": "BSC", "account": accountBSC},
        {"payType": "ROLLOUT", "account": accountROLLOUT}
      ]
    });
  }
}
