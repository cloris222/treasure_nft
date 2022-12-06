// To parse this JSON data, do
//
//     final pointRecordData = pointRecordDataFromJson(jsonString);

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:format/format.dart';

import '../../../constant/enum/task_enum.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../utils/number_format_util.dart';

PointRecordData pointRecordDataFromJson(String str) =>
    PointRecordData.fromJson(json.decode(str));

String pointRecordDataToJson(PointRecordData data) =>
    json.encode(data.toJson());

class PointRecordData {
  PointRecordData({
    required this.id,
    required this.time,
    required this.amount,
    required this.type,
    this.missionCode = '',
    this.level = 0,
  });

  String id;
  String time;

  ///MARK: 積分
  int amount;
  PointType type;
  String missionCode;
  int level;

  factory PointRecordData.fromJson(Map<String, dynamic> json) {
    String strType = json["type"];
    PointType type = PointType.DAILY;
    for (var element in PointType.values) {
      if (strType == element.name) {
        type = element;
        break;
      }
    }
    return PointRecordData(
      id: json["id"],
      time: json["time"],
      amount: json["amount"],
      type: type,
      missionCode: json["missionCode"] ?? '',
      level: json["level"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "amount": amount,
        "type": type.name,
        "missionCode": missionCode,
        "level": level,
      };

  String getTitle() {
    return tr(type == PointType.DAILY
        ? 'dly_t_$missionCode'
        : type == PointType.ACHIEVEMENT
            ? 'mis_t_$missionCode'
            : 'levelUp');
  }

  String getStringType() {
    return tr(type == PointType.DAILY
        ? 'pt_DAILY'
        : type == PointType.ACHIEVEMENT
            ? 'pt_ACHIEVEMENT'
            : 'pt_LEVEL_UP_SUBTRACT');
  }

  String getStringPoint() {
    return '${amount > 0 ? '' : ''}$amount';
  }

  String getImagePath() {
    switch (type) {
      case PointType.DAILY:
        {
          return format(
              '${AppImagePath.dailyMission}/dm_{index}_01_{strStatus}.png', {
            'index':
                NumberFormatUtil().integerTwoFormat(getDailyCodeIndex() + 1),
            'strStatus': 'focus'
          });
        }
      case PointType.ACHIEVEMENT:
        {
          return format(
              '${AppImagePath.achievementMission}/ma_{index}_01_{strStatus}.png',
              {
                'index': NumberFormatUtil()
                    .integerTwoFormat(getAchievementCodeIndex() + 1),
                'strStatus': 'focus'
              });
        }
      case PointType.LEVEL_UP_SUBTRACT:
        {
          return format(AppImagePath.level, ({'level': level}));
        }
    }
  }

  int getDailyCodeIndex() {
    for (int i = 0; i < DailyCode.values.length; i++) {
      if (DailyCode.values[i].name == missionCode) {
        return i;
      }
    }
    return 0;
  }

  int getAchievementCodeIndex() {
    for (int i = 0; i < AchievementCode.values.length; i++) {
      if (AchievementCode.values[i].name == missionCode) {
        return i;
      }
    }
    return 0;
  }
}
