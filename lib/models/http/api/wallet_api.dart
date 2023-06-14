import 'package:treasure_nft_project/models/http/http_manager.dart';
import '../../../constant/enum/coin_enum.dart';
import '../../../views/wallet/data/BalanceRecordResponseData.dart';
import '../../../views/wallet/data/deposit_response_data.dart';
import '../../../views/wallet/data/pay_type_data.dart';
import '../parameter/api_response.dart';
import '../parameter/payment_info.dart';
import '../parameter/wallet_payment_type.dart';
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

  ///MARK: 查詢幣種
  Future<List<String>> getFiatCurrency() async {
    var response = await get('/flatCurrency/currency/all');
    return List<String>.from(response.data);
  }

  ///MARK: 查詢支付類型
  Future<List<PayTypeData>> getPayType(String currency) async {
    List<PayTypeData> result = [];
    var response = await get('/flatCurrency/payType/all',
        queryParameters: {"currency": currency});
    for (Map<String, dynamic> json in response.data) {
      result.add(PayTypeData.fromJson(json));
    }
    return result;
  }

  ///MARK: 申請法幣充值
  Future<DepositResponseData> depositCurrency(
      {required String payType,
      required String currency,
      required double amount}) async {
    var response = await post('/flatCurrency/deposit', data: {
      "payType": payType, //"MOMO"
      "currency": currency, //"VND"
      "amount": amount //1000.00
    });
    return DepositResponseData.fromJson(response.data);
  }

  /// 查詢支付類型
  Future<List<WalletPaymentType>> queryPaymentType(bool isDeposit) async {
    List<WalletPaymentType> result = [];
    var response = await get('/flatCurrency/payType/all', queryParameters: {
      "currency": "USDT",
      "poolType": isDeposit ? "DEPOSIT" : "WITHDRAW"
    });
    for (Map<String, dynamic> json in response.data) {
      result.add(WalletPaymentType.fromJson(json));
    }
    return result;
  }

  /// 查詢內部轉帳是否開啟 空陣列代表未開啟
  /// /flatCurrency/payType/all?currency=USDT&poolType=WITHDRAW&chain=INTER
  Future<List<WalletPaymentType>> queryInterPaymentType() async {
    List<WalletPaymentType> result = [];
    var response = await get('/flatCurrency/payType/all', queryParameters: {
      "currency": "USDT",
      "poolType": "WITHDRAW",
      "chain": "INTER",
    });
    for (Map<String, dynamic> json in response.data) {
      result.add(WalletPaymentType.fromJson(json));
    }
    return result;
  }
}
