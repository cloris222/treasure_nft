import 'package:treasure_nft_project/models/http/http_manager.dart';
import '../parameter/ios_purchase.dart';

class IOSPaymentAPI extends HttpManager {
  IOSPaymentAPI({super.onConnectFail});

  Future<IosPurchaseData> postCheckIOSReceipt(String receipt) async {
    var response =
        await post('/purchase/check/ios', data: {"receipt": receipt});
    return IosPurchaseData.fromJson(response.data);
  }
}