// To parse this JSON data, do
//
//     final taskInfoData = taskInfoDataFromJson(jsonString);

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:format/format.dart';
import '../../../constant/enum/task_enum.dart';

TaskInfoData taskInfoDataFromJson(String str) =>
    TaskInfoData.fromJson(json.decode(str));

String taskInfoDataToJson(TaskInfoData data) => json.encode(data.toJson());

class TaskInfoData {
  TaskInfoData({
    required this.title,
    required this.content,
    required this.code,
    required this.point,
    required this.goalType,
    required this.goalValue,
    required this.nowValue,
    this.recordNo,
    this.takeStatus,
  });

  String title;
  String content;

  /// MARK: 任務代碼
  String code;

  ///MARK: 積分
  int point;

  ///MARK: 目標類型
  String goalType;

  ///MARK:目標值
  double goalValue;

  ///MARK:目前值
  double nowValue;

  ///MARK: 任務記錄單號 未完成為空值
  String? recordNo;

  ///MARK: 領取狀態 未完成為空值
  String? takeStatus;

  factory TaskInfoData.fromJson(Map<String, dynamic> json) => TaskInfoData(
        title: json["title"],
        content: json["content"],
        code: json["code"],
        point: json["point"],
        goalType: json["goalType"],
        goalValue: json["goalValue"].toDouble(),
        nowValue: json["nowValue"]?.toDouble() ?? 0.0,
        recordNo: json["recordNo"],
        takeStatus: json["takeStatus"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "code": code,
        "point": point,
        "goalType": goalType,
        "goalValue": goalValue,
        "nowValue": nowValue,
        "recordNo": recordNo,
        "takeStatus": takeStatus,
      };

  int getDailyCodeIndex() {
    for (int i = 0; i < DailyCode.values.length; i++) {
      if (DailyCode.values[i].name == code) {
        return i;
      }
    }
    return 0;
  }

  int getAchievementCodeIndex() {
    for (int i = 0; i < AchievementCode.values.length; i++) {
      if (AchievementCode.values[i].name == code) {
        return i;
      }
    }
    return 0;
  }

  TaskStatus getTaskStatus() {
    if (takeStatus == null) {
      return TaskStatus.notFinish;
    } else {
      return takeStatus == 'TAKEN' ? TaskStatus.isTaken : TaskStatus.unTaken;
    }
  }

  String getDailyTaskText() {
    return tr('dly_t_$code');
  }

  String getDailyTaskSubText() {
    return '${tr('mis_goal')} : ${tr('dly_c_$code')}';
  }

  String getAchievementTaskText() {
    return tr('mis_t_$code');
  }

  String getAchievementGoalTaskSubText(AchievementCode code) {
    String unit;
    switch (code) {
      case AchievementCode.AchSignIn:
      case AchievementCode.AchContSignIn:
        unit = tr('mis_type_DAY');
        break;
      case AchievementCode.AchRsvScs:
      case AchievementCode.AchBuyScs:
      case AchievementCode.AchTeamBuyFreq:
        unit = tr('mis_type_TIMES');
        break;
      case AchievementCode.AchSlfBuyAmt:
      case AchievementCode.AchTeamBuyAmt:
        unit = tr('mis_type_AMT');
        break;
      case AchievementCode.AchInvClsA:
      case AchievementCode.AchInvClsBC:
        unit = tr('mis_type_PEOPLE');
        break;
    }
    return format(tr('mis_c_${code.name}'), {'num': goalValue, 'unit': unit});
  }

  String getAchievementCurrentTaskSubText(AchievementCode code) {
    String unit;
    switch (code) {
      case AchievementCode.AchSignIn:
      case AchievementCode.AchContSignIn:
        unit = tr('mis_type_DAY');
        break;
      case AchievementCode.AchRsvScs:
      case AchievementCode.AchBuyScs:
      case AchievementCode.AchTeamBuyFreq:
        unit = tr('mis_type_TIMES');
        break;
      case AchievementCode.AchSlfBuyAmt:
      case AchievementCode.AchTeamBuyAmt:
        unit = tr('mis_type_AMT');
        break;
      case AchievementCode.AchInvClsA:
      case AchievementCode.AchInvClsBC:
        unit = tr('mis_type_PEOPLE');
        break;
    }
    return format(tr('mis_c_${code.name}'), {'num': nowValue, 'unit': unit});
  }
}
