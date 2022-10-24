import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';

import '../parameter/medal_info_data.dart';

class MissionAPI extends HttpManager {
  MissionAPI({super.onConnectFail});

  ///MARK: 每日任務列表
  Future<List<TaskInfoData>> getDailyTask() async {
    var response = await get('/mission/daily-list');
    List<TaskInfoData> result = [];
    for (Map<String, dynamic> json in response.data['pageList']) {
      result.add(TaskInfoData.fromJson(json));
    }
    return result;
  }

  ///MARK: 成就任務列表
  Future<List<TaskInfoData>> getAchieveTask() async {
    var response = await get('/mission/achieve-list');
    List<TaskInfoData> result = [];
    for (Map<String, dynamic> json in response.data['pageList']) {
      result.add(TaskInfoData.fromJson(json));
    }
    return result;
  }

  ///MARK: 成就勳章列表
  Future<List<MedalInfoData>> getMedalList() async {
    var response = await get('/mission/medal-list');
    List<MedalInfoData> result = [];
    for (Map<String, dynamic> json in response.data['pageList']) {
      result.add(MedalInfoData.fromJson(json));
    }
    return result;
  }
}
