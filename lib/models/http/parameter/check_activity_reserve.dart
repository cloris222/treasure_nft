// To parse this JSON data, do
//
//     final activityReserveInfo = activityReserveInfoFromJson(jsonString);

import 'dart:convert';

ActivityReserveInfo activityReserveInfoFromJson(String str) =>
    ActivityReserveInfo.fromJson(json.decode(str));

String activityReserveInfoToJson(ActivityReserveInfo data) =>
    json.encode(data.toJson());

class ActivityReserveInfo {
  ActivityReserveInfo({
    required this.isReServeTime,
    required this.startTime,
    required this.endTime,
    required this.zone,
    required this.localTime,
    required this.drawTime,
    required this.memberPool,
    required this.platformPool,
    required this.levelMin,
    required this.levelMax,
    required this.deposit,
    required this.depositForConsume,
    required this.depositForPool,
    required this.isUsed,
    required this.usedCount,
    required this.limitCount,
    required this.isOpen,
  });

  bool isReServeTime;
  String startTime;
  String endTime;
  String zone;
  String localTime;
  String drawTime;
  int memberPool;
  int platformPool;
  int levelMin;
  int levelMax;
  int deposit;
  int depositForConsume;
  int depositForPool;
  bool isUsed;
  int usedCount;
  int limitCount;
  bool isOpen;

  factory ActivityReserveInfo.fromJson(Map<String, dynamic> json) =>
      ActivityReserveInfo(
        isReServeTime: json["isReServeTime"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        zone: json["zone"],
        localTime: json["localTime"],
        drawTime: json["drawTime"],
        memberPool: json["memberPool"],
        platformPool: json["platformPool"],
        levelMin: json["levelMin"],
        levelMax: json["levelMax"],
        deposit: json["deposit"],
        depositForConsume: json["depositForConsume"],
        depositForPool: json["depositForPool"],
        isUsed: json["isUsed"],
        usedCount: json["usedCount"],
        limitCount: json["limitCount"],
        isOpen: json["isOpen"],
      );

  Map<String, dynamic> toJson() => {
        "isReServeTime": isReServeTime,
        "startTime": startTime,
        "endTime": endTime,
        "zone": zone,
        "localTime": localTime,
        "drawTime": drawTime,
        "memberPool": memberPool,
        "platformPool": platformPool,
        "levelMin": levelMin,
        "levelMax": levelMax,
        "deposit": deposit,
        "depositForConsume": depositForConsume,
        "depositForPool": depositForPool,
        "isUsed": isUsed,
        "usedCount": usedCount,
        "limitCount": limitCount,
        "isOpen": isOpen,
      };
}
