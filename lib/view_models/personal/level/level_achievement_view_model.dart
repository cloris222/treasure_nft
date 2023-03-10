// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/models/http/api/mission_api.dart';
import 'package:treasure_nft_project/models/http/parameter/medal_info_data.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_achieve_finish_page.dart';

import '../../../utils/app_shared_Preferences.dart';
import '../../gobal_provider/user_experience_info_provider.dart';
import '../../gobal_provider/user_info_provider.dart';

class LevelAchievementViewModel extends BaseViewModel {
  LevelAchievementViewModel(
      {required this.showExperienceHint,
      required this.showLevel0Hint,
      required this.onViewChange});

  List<TaskInfoData> dailyList = [];
  List<TaskInfoData> achieveList = [];
  List<MedalInfoData> medalList = [];

  final onClickFunction onViewChange;
  final onClickFunction showExperienceHint;
  final onClickFunction showLevel0Hint;

  Future<void> initState(WidgetRef ref) async {
    if (ref.read(userExperienceInfoProvider).isExperience) {
      showExperienceHint();
    } else if (ref.read(userInfoProvider).level == 0) {
      showLevel0Hint();
    } else {
      dailyList = await getSharePrefDailyList();
      achieveList = await getSharePrefAchieveList();
      medalList = await getSharePrefMedalList();
      onViewChange();

      updateDailyList();
      updateAchieveList();
      updateMedalList();
    }
  }

  void getDailyPoint(
      BuildContext context, WidgetRef ref, String recordNo, int point) async {
    await MissionAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .getMissionPoint(recordNo: recordNo);

    ref.read(userInfoProvider.notifier).update();
    for (TaskInfoData data in dailyList) {
      if (data.recordNo != null) {
        if (data.recordNo == recordNo) {
          data.takeStatus = 'TAKEN';
        }
      }
    }
    setSharePrefDailyList();
    updateDailyList();
    onViewChange();
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
    onViewChange();
    setSharePrefAchieveList();
    updateAchieveList();
   updateMedalList();
  }

  void setMedalCode(BuildContext context, WidgetRef ref, String code) {
    MissionAPI(onConnectFail: (message) => onBaseConnectFail(context, message))
        .setAchieveMedalCode(code: code)
        .then((value) {
      ref.read(userInfoProvider.notifier).update();
      onViewChange();
    });
  }

  Future<List<TaskInfoData>> getSharePrefDailyList() async {
    var json = await AppSharedPreferences.getJson("levelDaily_tmp");
    if (json != null) {
      return List<TaskInfoData>.from(json.map((x) => TaskInfoData.fromJson(x)));
    }
    return [];
  }

  Future<List<TaskInfoData>> getSharePrefAchieveList() async {
    var json = await AppSharedPreferences.getJson("levelAchieve_tmp");
    if (json != null) {
      return List<TaskInfoData>.from(json.map((x) => TaskInfoData.fromJson(x)));
    }
    return [];
  }

  Future<List<MedalInfoData>> getSharePrefMedalList() async {
    var json = await AppSharedPreferences.getJson("levelMedal_tmp");
    if (json != null) {
      return List<MedalInfoData>.from(
          json.map((x) => MedalInfoData.fromJson(x)));
    }
    return [];
  }

  Future<void> setSharePrefDailyList() async {
    await AppSharedPreferences.setJson(
        "levelDaily_tmp", List<dynamic>.from(dailyList.map((x) => x.toJson())));
  }

  Future<void> setSharePrefAchieveList() async {
    await AppSharedPreferences.setJson("levelAchieve_tmp",
        List<dynamic>.from(achieveList.map((x) => x.toJson())));
  }

  Future<void> setSharePrefMedalList() async {
    await AppSharedPreferences.setJson(
        "levelMedal_tmp", List<dynamic>.from(medalList.map((x) => x.toJson())));
  }

  void updateDailyList() {
    MissionAPI().getDailyTask().then((value) {
      dailyList = value;
      setSharePrefDailyList();
      onViewChange();
    });
  }

  void updateAchieveList() {
    MissionAPI().getAchieveTask().then((value) {
      achieveList = value;
      onViewChange();
    });
  }

  void updateMedalList() {
    MissionAPI().getMedalList().then((value) {
      medalList = value;
      onViewChange();
    });
  }
}
