import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/level_info_data.dart';

import '../parameter/level_bonus_data.dart';

class LevelAPI extends HttpManager {
  LevelAPI({super.onConnectFail});

  Future<bool> checkLevelUpdate() async {
    var response = await get('/level/can-level-up');
    return response.data;
  }

  Future<List<LevelInfoData>> getAllLevelInfo() async {
    var response = await get('/level/all');
    List<LevelInfoData> result = [];
    for (Map<String, dynamic> json in response.data) {
      result.add(LevelInfoData.fromJson(json));
    }
    return result;
  }

  ///MARK: 取得bonus
  Future<LevelBonusData> getBonusInfo() async {
    var response = await get('/level/bonus');
    return LevelBonusData.fromJson(response.data);
  }
}
