import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import '../parameter/ios_purchase/ios_product_data.dart';
import '../parameter/ios_purchase/ios_purchase.dart';

class IOSPaymentAPI extends HttpManager {
  IOSPaymentAPI({super.onConnectFail});

  /// 確認內購
  Future<IosPurchaseData> postCheckIOSReceipt(String receipt) async {
    var response =
        await post('/purchase/check/ios', data: {"receipt": receipt});
    return IosPurchaseData.fromJson(response.data);
  }

  /// 取得內購列表
  Future<List<IosProductData>> getPurchaseList() async {
    ApiResponse response = await get('/purchase/list');
    List<IosProductData> result = <IosProductData>[];
    for (Map<String, dynamic> json in response.data) {
      result.add(IosProductData.fromJson(json));
    }
    return result;
  }
}
