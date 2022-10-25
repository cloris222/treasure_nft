import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/mission_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/parameter/medal_info_data.dart';
import '../../../models/http/parameter/task_info_data.dart';

class LevelAchievementViewModel extends BaseViewModel {
  LevelAchievementViewModel({required this.setState});

  List<TaskInfoData> dailyList = [];
  List<TaskInfoData> achieveList = [];
  List<MedalInfoData> medalList = [];

  final ViewChange setState;

  Future<void> initState() async {
    dailyList = await MissionAPI().getDailyTask();
    achieveList = await MissionAPI().getAchieveTask();
    medalList = await MissionAPI().getMedalList();
    setState(() {});
  }

  void getDailyPoint(BuildContext context, String recordNo, int point) async {
    // await MissionAPI(
    //         onConnectFail: (message) => onBaseConnectFail(context, message))
    //     .getMissionPoint(recordNo: recordNo);
    setState(() {
      GlobalData.userInfo.point += point;
      for (TaskInfoData data in achieveList) {
        if (data.recordNo != null) {
          data.takeStatus = 'TAKEN';
        }
      }
    });
  }

  void getAchievementPoint(BuildContext context, AchievementCode code,
      String recordNo, int point) async {
    // await MissionAPI(
    //     onConnectFail: (message) => onBaseConnectFail(context, message))
    //     .getMissionPoint(recordNo: recordNo);
    setState(() {
      GlobalData.userInfo.point += point;
      for (TaskInfoData data in dailyList) {
        if (data.recordNo != null) {
          data.takeStatus = 'TAKEN';
        }
      }
    });

    achieveList = await MissionAPI().getAchieveTask();
    setState(() {});
  }
}
