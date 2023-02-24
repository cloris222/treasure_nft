import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

class WalletConnectAPI extends HttpManager {
  WalletConnectAPI({super.onConnectFail});

  ///取得錢包nonce
  Future<String> getUserNonce(String address) async {
    var response =
        await get('/user/nonce', queryParameters: {"address": address});
    return response.data;
  }

  ///檢查錢包註冊
  Future<bool> getCheckWalletAddress(String address) async {
    var response = await get('/user/checkWalletExist',
        queryParameters: {"address": address});
    return response.data;
  }

  ///驗證錢包簽名
  Future<void> postCheckWalletVerifySign(WalletInfo info) async {
    await post('/user/verifySign',
        data: {"address": info.address, "signature": info.personalSign});
  }
}
