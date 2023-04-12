import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';

import '../parameter/airdrop_box_info.dart';
import '../parameter/airdrop_box_reward.dart';
import '../parameter/airdrop_reward_info.dart';

class AirdropBoxAPI extends HttpManager {
  AirdropBoxAPI({super.onConnectFail});

  Future<AirdropRewardInfo?> getReserveBoxInfo() async {
    try {
      var response = await get("/treasureBox/setting",
          queryParameters: {"boxType": "RESERVE_BOX"});
      for (Map<String, dynamic> json in response.data) {
        return AirdropRewardInfo.fromJson(json);
      }
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return null;
  }

  Future<AirdropRewardInfo?> getLevelBoxInfo(int level) async {
    try {
      var response = await get("/treasureBox/setting",
          queryParameters: {"boxType": "LEVEL_BOX_$level"});
      for (Map<String, dynamic> json in response.data) {
        return AirdropRewardInfo.fromJson(json);
      }
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return null;
  }

  /// 未開的箱子
  Future<int> checkReserveBoxCount() async {
    var response = await get("/treasureBox/record/unOpen/count");
    return response.data["count"];
  }

  Future<List<AirdropBoxInfo>> getAirdropBoxRecord() async {
    try {
      var response = await get("/treasureBox/record/all",
          queryParameters: {"boxType": "RESERVE_BOX", "page": 1, "size": 1});
      List<AirdropBoxInfo> list = [];
      for (Map<String, dynamic> json in response.data["pageList"]) {
        list.add(AirdropBoxInfo.fromJson(json));
      }
      return list;
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return [];
  }

  Future<List<AirdropBoxInfo>> getAirdropBoxLevelRecord(int level) async {
    try {
      var response = await get("/treasureBox/record/all", queryParameters: {
        "boxType": "LEVEL_BOX_$level",
        "page": 1,
        "size": 1
      });
      List<AirdropBoxInfo> list = [];
      for (Map<String, dynamic> json in response.data["pageList"]) {
        list.add(AirdropBoxInfo.fromJson(json));
      }
      return list;
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return [];
  }

  Future<List<AirdropBoxReward>> openAirdropBox(String orderNo) async {
    try {
      var response =
          await post("/treasureBox/open", data: {"orderNo": orderNo});
      List<AirdropBoxReward> list = [];
      for (Map<String, dynamic> json in response.data["pageList"]) {
        list.add(AirdropBoxReward.fromJson(json));
      }
      return list;
    } catch (e) {
      GlobalData.printLog(e.toString());
    }
    return [];
  }
}
