import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/models/http/api/mission_api.dart';
import 'package:treasure_nft_project/models/http/parameter/medal_info_data.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_achieve_finish_page.dart';

import '../../gobal_provider/user_experience_info_provider.dart';
import '../../gobal_provider/user_info_provider.dart';

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

  Future<void> initState(WidgetRef ref) async {
    if (ref.read(userExperienceInfoProvider).isExperience) {
      showExperienceHint();
    } else if (ref.read(userInfoProvider).level == 0) {
      showLevel0Hint();
    } else {
      MissionAPI()
          .getDailyTask()
          .then((value) => setState(() => dailyList = value));
      MissionAPI()
          .getAchieveTask()
          .then((value) => setState(() => achieveList = value));
      MissionAPI()
          .getMedalList()
          .then((value) => setState(() => medalList = value));
    }
  }

  void getDailyPoint(
      BuildContext context, WidgetRef ref, String recordNo, int point) async {
    await MissionAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .getMissionPoint(recordNo: recordNo);
    setState(() {
      ref.read(userInfoProvider.notifier).update();
      for (TaskInfoData data in dailyList) {
        if (data.recordNo != null) {
          if (data.recordNo == recordNo) {
            data.takeStatus = 'TAKEN';
          }
        }
      }
    });
  }

  void getAchievementPoint(
      BuildContext context,
      WidgetRef ref,
      TaskInfoData data,
      AchievementCode code,
      String recordNo,
      int point) async {
    await MissionAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .getMissionPoint(recordNo: recordNo);
    setState(() {
      pushOpacityPage(
          context, AchievementAchieveFinishPage(data: data, code: code));
      ref.read(userInfoProvider.notifier).update();
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

  void setMedalCode(BuildContext context, WidgetRef ref, String code) {
    MissionAPI(onConnectFail: (message) => onBaseConnectFail(context, message))
        .setAchieveMedalCode(code: code)
        .then((value) {
      setState(() {
        ref.read(userInfoProvider.notifier).update();
      });
    });
  }
}
