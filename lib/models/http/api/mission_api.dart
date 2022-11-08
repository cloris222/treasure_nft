import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/point_record_data.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../parameter/api_response.dart';
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

  ///MARK: 領取任務獎勵
  Future<ApiResponse> getMissionPoint({required String recordNo}) async {
    return post('/mission/take-point', data: {'recordNo': recordNo});
  }

  ///MARK: 選擇成就徽章
  Future<ApiResponse> setAchieveMedalCode({required String code}) async {
    return post('/mission/medal-choose', data: {'code': code});
  }

  Future<List<PointRecordData>> getPointRecord(
      {int page = 1,
      int size = 10,
      required String startDate,
      required String endDate}) async {
    var response = await get('/user/points', queryParameters: {
      'page': page,
      'size': size,
      'startTime': BaseViewModel().changeTimeZone('$startDate 00:00:00',
          isSystemTime: false, isApiValue: true),
      'endTime': BaseViewModel().changeTimeZone('$endDate 23:59:59',
          isSystemTime: false, isApiValue: true),
    });

    List<PointRecordData> result = [];
    for (Map<String, dynamic> json in response.data['pageList']) {
      result.add(PointRecordData.fromJson(json));
    }

    return result;
  }

  Future<ApiResponse> finishShareMission() async {
    return post('/mission/share');
  }
}
