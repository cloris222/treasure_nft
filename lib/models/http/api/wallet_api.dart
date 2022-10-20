import 'package:treasure_nft_project/models/http/http_manager.dart';

class WalletAPI extends HttpManager {
  WalletAPI({super.onConnectFail});

  ///MARK: 取得充值資訊
  Future<Map<String, dynamic>> getBalanceRecharge() async {
    Map<String, String> result = {};
    var response = await get('/user/balance-recharge');
    for (Map<String, dynamic> json in response.data) {
      result[json['chain']] = json['address'];
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
}
