// To parse this JSON data, do
//
//     final airdropRewardInfo = airdropRewardInfoFromJson(jsonString);

import 'dart:convert';

AirdropRewardInfo airdropRewardInfoFromJson(String str) =>
    AirdropRewardInfo.fromJson(json.decode(str));

String airdropRewardInfoToJson(AirdropRewardInfo data) =>
    json.encode(data.toJson());

class AirdropRewardInfo {
  AirdropRewardInfo({
    required this.rewardType,
    required this.rate,
    required this.startRange,
    required this.endRange,
  });

  final String rewardType;
  final num rate;
  final num startRange;
  final num endRange;

  factory AirdropRewardInfo.fromJson(Map<String, dynamic> json) =>
      AirdropRewardInfo(
        rewardType: json["rewardType"] ?? "",
        rate: json["rate"] ?? 0,
        startRange: json["startRange"] ?? 0,
        endRange: json["endRange"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "rewardType": rewardType,
        "rate": rate,
        "startRange": startRange,
        "endRange": endRange,
      };
}
