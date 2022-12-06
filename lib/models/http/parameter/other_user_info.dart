// To parse this JSON data, do
//
//     final otherUserInfo = otherUserInfoFromJson(jsonString);

import 'dart:convert';

OtherUserInfo otherUserInfoFromJson(String str) =>
    OtherUserInfo.fromJson(json.decode(str));

String otherUserInfoToJson(OtherUserInfo data) => json.encode(data.toJson());

class OtherUserInfo {
  OtherUserInfo({
    required this.id,
    required this.account,
    required this.name,
    required this.userLevel,
    this.medalCode,
    this.bannerUrl,
    this.photoUrl,
  });

  String id;
  String account;
  String name;
  int userLevel;
  String? medalCode;
  String? bannerUrl;
  String? photoUrl;

  factory OtherUserInfo.fromJson(Map<String, dynamic> json) => OtherUserInfo(
        id: json["id"],
        account: json["account"],
        name: json["name"],
        userLevel: json["userLevel"],
        medalCode: json["medalCode"],
        bannerUrl: json["bannerUrl"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account": account,
        "name": name,
        "userLevel": userLevel,
        "medalCode": medalCode,
        "bannerUrl": bannerUrl,
        "photoUrl": photoUrl,
      };
}
