import 'package:treasure_nft_project/models/http/http_manager.dart';

class LevelAPI extends HttpManager {
  LevelAPI({super.onConnectFail});

  Future<bool> checkLevelUpdate() async {
    var response = await get('/level/can-level-up');
    return response.data;
  }
}
