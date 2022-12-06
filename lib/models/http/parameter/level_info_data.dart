// To parse this JSON data, do
//
//     final levelInfoData = levelInfoDataFromJson(jsonString);

import 'dart:convert';

LevelInfoData levelInfoDataFromJson(String str) =>
    LevelInfoData.fromJson(json.decode(str));

String levelInfoDataToJson(LevelInfoData data) => json.encode(data.toJson());

class LevelInfoData {
  LevelInfoData({
    required this.userLevel,
    required this.dailyReverseAmount,
    required this.dailyRCouponAmount,
    required this.buyRangeStart,
    required this.buyRangeEnd,
    required this.couponRate,
    required this.directSave,
    required this.directShare,
    required this.indirectSave,
    required this.indirectShare,
    required this.thirdSave,
    required this.thirdShare,
  });

  int userLevel;
  int dailyReverseAmount;
  int dailyRCouponAmount;
  int buyRangeStart;
  int buyRangeEnd;
  int couponRate;
  double directSave;
  double directShare;
  double indirectSave;
  double indirectShare;
  double thirdSave;
  double thirdShare;

  factory LevelInfoData.fromJson(Map<String, dynamic> json) => LevelInfoData(
        userLevel: json["userLevel"],
        dailyReverseAmount: json["dailyReverseAmount"],
        dailyRCouponAmount: json["dailyRCouponAmount"],
        buyRangeStart: json["buyRangeStart"],
        buyRangeEnd: json["buyRangeEnd"],
        couponRate: json["couponRate"],
        directSave: json["directSave"].toDouble(),
        directShare: json["directShare"].toDouble(),
        indirectSave: json["indirectSave"].toDouble(),
        indirectShare: json["indirectShare"].toDouble(),
        thirdSave: json["thirdSave"].toDouble(),
        thirdShare: json["thirdShare"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "userLevel": userLevel,
        "dailyReverseAmount": dailyReverseAmount,
        "dailyRCouponAmount": dailyRCouponAmount,
        "buyRangeStart": buyRangeStart,
        "buyRangeEnd": buyRangeEnd,
        "couponRate": couponRate,
        "directSave": directSave,
        "directShare": directShare,
        "indirectSave": indirectSave,
        "indirectShare": indirectShare,
        "thirdSave": thirdSave,
        "thirdShare": thirdShare,
      };
}
