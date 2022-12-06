import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../parameter/api_response.dart';

class MineAPI extends HttpManager {
  MineAPI({super.onConnectFail});

  ///MARK: 查詢版費費率
  Future<double> getRoyaltyRate() async {
    var response = await get('/user/royalty-rate');
    return response.data;
  }

  ///MARK: 查詢是否在白名單
  Future<bool> getWhiteList() async {
    var response = await get('/user/in-whitelist');
    return response.data;
  }

  ///MARK: 鑄造NFT
  Future<ApiResponse> mineNFT(
      {required String imageUrl,
      required String name,
      required String description,
      required String price,
      required String sellDate}) async {
    return post('/NFTItem/mint', data: {
      "imageUrl": imageUrl,
      "name": name,
      "description": description,
      "price": price,
      "sellDate": sellDate
    });
  }
}
