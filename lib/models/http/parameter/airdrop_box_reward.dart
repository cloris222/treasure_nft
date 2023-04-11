// To parse this JSON data, do
//
//     final airdropBoxReward = airdropBoxRewardFromJson(jsonString);

import 'dart:convert';

AirdropBoxReward airdropBoxRewardFromJson(String str) =>
    AirdropBoxReward.fromJson(json.decode(str));

String airdropBoxRewardToJson(AirdropBoxReward data) =>
    json.encode(data.toJson());

class AirdropBoxReward {
  AirdropBoxReward({
    required this.type,
    required this.orderNo,
    required this.createdAt,
    required this.updatedAt,
    required this.boxType,
    required this.rewardType,
    required this.medal,
    required this.medalName,
    required this.itemName,
    required this.itemPrice,
    required this.imgUrl,
    required this.reward,
    required this.status,
  });

  final String type;
  final String orderNo;
  final String createdAt;
  final String updatedAt;
  final String boxType;
  final String rewardType;
  final String medal;
  final String medalName;
  final String itemName;
  final num itemPrice;
  final String imgUrl;
  final num reward;
  final String status;

  factory AirdropBoxReward.fromJson(Map<String, dynamic> json) =>
      AirdropBoxReward(
        type: json["type"] ?? "",
        orderNo: json["orderNo"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
        boxType: json["boxType"] ?? "",
        rewardType: json["rewardType"] ?? "",
        medal: json["medal"] ?? "",
        medalName: json["medalName"] ?? "",
        itemName: json["itemName"] ?? "",
        itemPrice: json["itemPrice"] ?? 0,
        imgUrl: json["imgUrl"] ?? "",
        reward: json["reward"] ?? 0,
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "orderNo": orderNo,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "boxType": boxType,
        "rewardType": rewardType,
        "medal": medal,
        "medalName": medalName,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "imgUrl": imgUrl,
        "reward": reward,
        "status": status,
      };
}
