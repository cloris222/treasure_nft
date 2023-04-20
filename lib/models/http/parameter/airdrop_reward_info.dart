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
    required this.boxType,
    required this.config,
  });

  final String boxType;
  final List<AirdropRewardConfig> config;

  factory AirdropRewardInfo.fromJson(Map<String, dynamic> json) =>
      AirdropRewardInfo(
        boxType: json["boxType"] ?? "",
        config: json["config"] == null
            ? []
            : List<AirdropRewardConfig>.from(
                json["config"].map((x) => AirdropRewardConfig.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "boxType": boxType,
        "config": List<dynamic>.from(config.map((x) => x.toJson())),
      };
}

class AirdropRewardConfig {
  AirdropRewardConfig({
    required this.rewardType,
    required this.rate,
    required this.startRange,
    required this.endRange,
    required this.imageType,
  });

  final String rewardType;
  final num rate;
  final num startRange;
  final num endRange;
  final List<String> imageType;

  factory AirdropRewardConfig.fromJson(Map<String, dynamic> json) =>
      AirdropRewardConfig(
        rewardType: json["rewardType"] ?? "",
        rate: json["rate"] ?? 0,
        startRange: json["startRange"] ?? 0,
        endRange: json["endRange"] ?? 0,
        imageType: json["imageType"] == null
            ? []
            : List<String>.from(json["imageType"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "rewardType": rewardType,
        "rate": rate,
        "startRange": startRange,
        "endRange": endRange,
        "imageType": List<dynamic>.from(imageType.map((x) => x)),
      };
}
