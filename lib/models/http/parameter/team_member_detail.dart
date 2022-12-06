// To parse this JSON data, do
//
//     final memberDetail = memberDetailFromJson(jsonString);

import 'dart:convert';

MemberDetail memberDetailFromJson(String str) =>
    MemberDetail.fromJson(json.decode(str));

String memberDetailToJson(MemberDetail data) => json.encode(data.toJson());

class MemberDetail {
  MemberDetail({
    this.total = 0,
    this.totalPages = 0,
    this.pageList,
  });

  int total;
  int totalPages;
  List<MemberDetailPageList>? pageList;

  factory MemberDetail.fromJson(Map<String, dynamic> json) => MemberDetail(
        total: json["total"],
        totalPages: json["totalPages"],
        pageList: List<MemberDetailPageList>.from(
            json["pageList"].map((x) => MemberDetailPageList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "totalPages": totalPages,
        "pageList": List<dynamic>.from(pageList!.map((x) => x.toJson())),
      };
}

class MemberDetailPageList {
  MemberDetailPageList({
    this.email = '',
    this.userId = '',
    this.userName = '',
    this.account = '',
    this.areaCode,
    this.phone,
    this.itemCount,
    this.totalPrice = 0.0,
    this.tradingVolume = 0.0,
    this.inviteCount,
  });

  String email;
  String userId;
  String userName;
  String account;
  dynamic areaCode;
  dynamic phone;
  dynamic itemCount;
  double totalPrice;
  double tradingVolume;
  dynamic inviteCount;

  factory MemberDetailPageList.fromJson(Map<String, dynamic> json) =>
      MemberDetailPageList(
        email: json["email"],
        userId: json["userId"],
        userName: json["userName"],
        account: json["account"],
        areaCode: json["areaCode"],
        phone: json["phone"],
        itemCount: json["itemCount"],
        totalPrice: json["totalPrice"].toDouble(),
        tradingVolume: json["tradingVolume"].toDouble(),
        inviteCount: json["inviteCount"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userId": userId,
        "userName": userName,
        "account": account,
        "areaCode": areaCode,
        "phone": phone,
        "itemCount": itemCount,
        "totalPrice": totalPrice,
        "tradingVolume": tradingVolume,
        "inviteCount": inviteCount,
      };
}
