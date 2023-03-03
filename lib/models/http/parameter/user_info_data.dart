// To parse this JSON data, do
//
//     final userInfoData = userInfoDataFromJson(jsonString);

import 'dart:convert';

UserInfoData userInfoDataFromJson(String str) =>
    UserInfoData.fromJson(json.decode(str));

String userInfoDataToJson(UserInfoData data) => json.encode(data.toJson());

class UserInfoData {
  UserInfoData({
    this.name = '',
    this.account = '',
    this.email = '',
    this.phoneCountry = '',
    this.phone = '',
    this.inviteCode = '',
    this.photoUrl = '',
    this.bannerUrl = '',
    this.gender = '',
    this.birthday = '',
    this.bindGoogle = false,
    this.level = 0,
    this.canLevelUp = false,
    this.medal = '',
    this.point = 0,
    this.country = '',
    this.zone = '',
    this.address = '',
  });

  /// 暱稱
  String name;

  /// 帳號
  String account;

  /// 信箱
  String email;

  /// 國家
  String phoneCountry;

  /// 手機
  String phone;

  /// 邀請碼
  String inviteCode;

  /// 頭像連結
  String photoUrl;

  /// 背景連結
  String bannerUrl;

  /// 性別
  String gender;

  /// 生日
  String birthday;

  /// 是否綁定GOOGLE
  bool bindGoogle;

  /// 會員等級
  int level;

  /// 是否可升等
  bool canLevelUp;

  /// 勳章代號
  String medal;

  ///點數 (?)
  int point;

  /// 國籍
  String country;

  /// 時區
  String zone;

  ///錢包位址
  String address;

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
        name: json["name"],
        account: json['account'],
        email: json["email"],
        phoneCountry: json["phoneCountry"] ?? '',
        phone: json["phone"] ?? '',
        inviteCode: json["inviteCode"] ?? '',
        photoUrl: json["photoUrl"] ?? '',
        bannerUrl: json["bannerUrl"] ?? '',
        gender: json["gender"],
        birthday: json["birthday"] ?? '',
        bindGoogle: json["bindGoogle"],
        level: json["level"],
        canLevelUp: json["canLevelUp"],
        medal: json["medal"] ?? '',
        point: json["point"] ?? 0,
        country: json["country"],
        zone: json["zone"],
        address: json["address"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "name": name,
        "email": email,
        "phoneCountry": phoneCountry,
        "phone": phone,
        "inviteCode": inviteCode,
        "photoUrl": photoUrl,
        "bannerUrl": bannerUrl,
        "gender": gender,
        "birthday": birthday,
        "bindGoogle": bindGoogle,
        "level": level,
        "canLevelUp": canLevelUp,
        "medal": medal,
        "point": point,
        "country": country,
        "zone": zone,
        "address": address,
      };

  String getStrZone() {
    return '';
  }

  String getUserName() {
    if (name.isEmpty) {
      return account;
    }
    return name;
  }
}
