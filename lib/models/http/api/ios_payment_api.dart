import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../parameter/api_response.dart';

class IOSPaymentAPI extends HttpManager{
  IOSPaymentAPI({super.onConnectFail});

  Future<ApiResponse> postCheckIOSReceipt(String receipt){
    return post('/purchase/check/ios',data: {"receipt": receipt});
  }
}