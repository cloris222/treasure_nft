import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';

import '../../../constant/enum/coin_enum.dart';
import '../../../views/wallet/data/BalanceRecordResponseData.dart';
import '../parameter/api_response.dart';
import '../parameter/payment_info.dart';
import '../parameter/withdraw_alert_info.dart';

class WalletAPI extends HttpManager {
  WalletAPI({super.onConnectFail});

  ///MARK: 取得充值資訊
  Future<Map<String, dynamic>> getBalanceRecharge() async {
    Map<String, String> result = {};
    var response = await get('/user/balance-recharge');
    for (Map<String, dynamic> json in response.data) {
      result[json['chain']] = json['address'].toString();
    }
    if (!result.containsKey(CoinEnum.TRON.name)) {
      result[CoinEnum.TRON.name] = '';
    }
    if (!result.containsKey(CoinEnum.BSC.name)) {
      result[CoinEnum.BSC.name] = '';
    }
    return result;
  }

  Future<List<BalanceRecordResponseData>> getBalanceRecord() async {
    List<BalanceRecordResponseData> result = <BalanceRecordResponseData>[];
    var response = await get('/user/balance-record', queryParameters: {
      'type': 'ALL',
      'page': '1',
      'size': '15',
      'startTime': '',
      'endTime': ''
    });
    for (Map<String, dynamic> json in response.data['pageList']) {
      result.add(BalanceRecordResponseData.fromJson(json));
    }
    AppSharedPreferences.setWalletRecord(result);
    return result;
  }

  ///MARK: 取得支付資訊
  Future<List<PaymentInfo>> getPaymentInfo() async {
    List<PaymentInfo> result = <PaymentInfo>[];
    var response = await get('/payment/info');
    for (Map<String, dynamic> json in response.data) {
      result.add(PaymentInfo.fromJson(json));
    }
    return result;
  }

  Future<ApiResponse> setPaymentInfo(
      {required String accountTRON,
      required String accountBSC,
      required String accountROLLOUT,
      required String emailVerifyCode}) async {
    return put('/payment/update', data: {
      "paymentList": [
        {"payType": "TRON", "account": accountTRON},
        {"payType": "BSC", "account": accountBSC},
        {"payType": "ROLLOUT", "account": accountROLLOUT}
      ],
      "emailVerifyCode": emailVerifyCode
    });
  }

  ///MARK: 查詢提現警告
  Future<WithdrawAlertInfo> checkWithdrawAlert() async {
    var response = await get('/user/balance-withdraw-alert');
    return WithdrawAlertInfo.fromJson(response.data);
  }
}
