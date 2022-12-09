import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/mission_api.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/models/http/parameter/medal_info_data.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_achieve_finish_page.dart';

class LevelAchievementViewModel extends BaseViewModel {
  LevelAchievementViewModel(
      {required this.showExperienceHint,
      required this.showLevel0Hint,
      required this.setState});

  List<TaskInfoData> dailyList = [];
  List<TaskInfoData> achieveList = [];
  List<MedalInfoData> medalList = [];

  final ViewChange setState;
  final onClickFunction showExperienceHint;
  final onClickFunction showLevel0Hint;

  Future<void> initState() async {
    uploadPersonalInfo().then((value) {
      if (GlobalData.experienceInfo.isExperience) {
        showExperienceHint();
      } else if (GlobalData.userInfo.level == 0) {
        showLevel0Hint();
      }
    });
    MissionAPI()
        .getDailyTask()
        .then((value) => setState(() => dailyList = value));
    MissionAPI()
        .getAchieveTask()
        .then((value) => setState(() => achieveList = value));
    MissionAPI()
        .getMedalList()
        .then((value) => setState(() => medalList = value));
    UserInfoAPI().getCheckLevelInfoAPI().then((value) => setState(() {}));
  }

  void getDailyPoint(BuildContext context, String recordNo, int point) async {
    await MissionAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .getMissionPoint(recordNo: recordNo);
    setState(() {
      GlobalData.userInfo.point += point;
      for (TaskInfoData data in dailyList) {
        if (data.recordNo != null) {
          if (data.recordNo == recordNo) {
            data.takeStatus = 'TAKEN';
          }
        }
      }
    });
  }

  void getAchievementPoint(BuildContext context, TaskInfoData data,
      AchievementCode code, String recordNo, int point) async {
    await MissionAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .getMissionPoint(recordNo: recordNo);
    setState(() {
      pushOpacityPage(
          context, AchievementAchieveFinishPage(data: data, code: code));
      GlobalData.userInfo.point += point;
      for (TaskInfoData data in achieveList) {
        if (data.recordNo != null) {
          if (data.recordNo == recordNo) {
            data.takeStatus = 'TAKEN';
          }
        }
      }
    });

    achieveList = await MissionAPI().getAchieveTask();
    setState(() {});
    MissionAPI()
        .getMedalList()
        .then((value) => setState(() => medalList = value));
  }

  void setMedalCode(BuildContext context, String code) {
    MissionAPI(onConnectFail: (message) => onBaseConnectFail(context, message))
        .setAchieveMedalCode(code: code)
        .then((value) {
      setState(() {
        GlobalData.userInfo.medal = code;
      });
    });
  }
}
