
import 'dart:convert';

LowerInviteData lowerInviteDataFromJson(String str) => LowerInviteData.fromJson(json.decode(str));

String lowerInviteDataToJson(LowerInviteData data) => json.encode(data.toJson());

class LowerInviteData {
  LowerInviteData({
    this.time,
    this.userName = '',
    this.account = '',
    this.email = '',
    this.tradingVolume,
    this.isActive,
  });

  dynamic time;
  String userName;
  String account;
  String email;
  dynamic tradingVolume;
  dynamic isActive;

  factory LowerInviteData.fromJson(Map<String, dynamic> json) => LowerInviteData(
    time: json["time"],
    userName: json["userName"],
    account: json["account"],
    email: json["email"],
    tradingVolume: json["tradingVolume"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "time": time.toIso8601String(),
    "userName": userName,
    "account": account,
    "email": email,
    "tradingVolume": tradingVolume,
    "isActive": isActive,
  };
}
