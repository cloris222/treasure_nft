
import 'dart:convert';

GroupList teamMembersFromJson(String str) => GroupList.fromJson(json.decode(str));

String teamMembersToJson(GroupList data) => json.encode(data.toJson());

class GroupList {
  GroupList({
    this.totalVal,
    this.user,
    this.active,
    this.direct,
    this.notDirect,
    this.pageResult,
  });

  dynamic totalVal;
  dynamic user;
  dynamic active;
  dynamic direct;
  dynamic notDirect;
  PageResult? pageResult;

  factory GroupList.fromJson(Map<String, dynamic> json) => GroupList(
    totalVal: json["totalVal"],
    user: json["user"],
    active: json["active"],
    direct: json["direct"],
    notDirect: json["notDirect"],
    pageResult: PageResult.fromJson(json["pageResult"]),
  );

  Map<String, dynamic> toJson() => {
    "totalVal": totalVal,
    "user": user,
    "active": active,
    "direct": direct,
    "notDirect": notDirect,
    "pageResult": pageResult?.toJson(),
  };
}

class PageResult {
  PageResult({
    this.total,
    this.totalPages,
    this.pageList,
  });

  dynamic total;
  dynamic totalPages;
  List<PageList>? pageList;

  factory PageResult.fromJson(Map<String, dynamic> json) => PageResult(
    total: json["total"],
    totalPages: json["totalPages"],
    pageList: List<PageList>.from(json["pageList"].map((x) => PageList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "totalPages": totalPages,
    "pageList": List<dynamic>.from(pageList!.map((x) => x.toJson())),
  };
}

class PageList {
  PageList({
    this.email = '',
    this.userId = '',
    this.userName = '',
    this.account = '',
    this.areaCode,
    this.phone,
    this.itemCount,
    this.totalPrice,
    this.tradingVolume,
    this.inviteCount,
  });

  String email;
  String userId;
  String userName;
  String account;
  dynamic areaCode;
  dynamic phone;
  dynamic itemCount;
  dynamic totalPrice;
  dynamic tradingVolume;
  dynamic inviteCount;

  factory PageList.fromJson(Map<String, dynamic> json) => PageList(
    email: json["email"],
    userId: json["userId"],
    userName: json["userName"],
    account: json["account"],
    areaCode: json["areaCode"],
    phone: json["phone"],
    itemCount: json["itemCount"],
    totalPrice: json["totalPrice"],
    tradingVolume: json["tradingVolume"],
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
