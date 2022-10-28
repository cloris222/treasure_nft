// To parse this JSON data, do
//
//     final pointRecordData = pointRecordDataFromJson(jsonString);

import 'dart:convert';

import '../../../constant/enum/task_enum.dart';

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
    this.level = '',
  });

  String id;
  String time;

  ///MARK: 積分
  int amount;
  PointType type;
  String missionCode;
  String level;

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
      level: json["level"] ?? '',
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
}
