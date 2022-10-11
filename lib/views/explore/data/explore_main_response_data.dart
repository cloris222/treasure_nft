// To parse this JSON data, do
//
//     final exploreMainResponseData = exploreMainResponseDataFromJson(jsonString);

import 'dart:convert';

ExploreMainResponseData exploreMainResponseDataFromJson(String str) => ExploreMainResponseData.fromJson(json.decode(str));

String exploreMainResponseDataToJson(ExploreMainResponseData data) => json.encode(data.toJson());

class ExploreMainResponseData {
  ExploreMainResponseData({
    this.code = '',
    this.message = '',
    required this.data,
  });

  String code;
  String message;
  Data data;

  factory ExploreMainResponseData.fromJson(Map<String, dynamic> json) => ExploreMainResponseData(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.total = 0,
    this.totalPages = 0,
    required this.pageList,
  });

  int total;
  int totalPages;
  List<PageList> pageList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json["total"],
    totalPages: json["totalPages"],
    pageList: List<PageList>.from(json["pageList"].map((x) => PageList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "totalPages": totalPages,
    "pageList": List<dynamic>.from(pageList.map((x) => x.toJson())),
  };
}

class PageList {
  PageList({
    this.artistName = '',
    this.artistId = '',
    this.avatarUrl = '',
    this.introPhoneUrl = '',
    this.introPcUrl = '',
  });

  String artistName;
  String artistId;
  String avatarUrl;
  String introPhoneUrl;
  String introPcUrl;

  factory PageList.fromJson(Map<String, dynamic> json) => PageList(
    artistName: json["artistName"],
    artistId: json["artistId"],
    avatarUrl: json["avatarUrl"],
    introPhoneUrl: json["introPhoneUrl"],
    introPcUrl: json["introPcUrl"],
  );

  Map<String, dynamic> toJson() => {
    "artistName": artistName,
    "artistId": artistId,
    "avatarUrl": avatarUrl,
    "introPhoneUrl": introPhoneUrl,
    "introPcUrl": introPcUrl,
  };
}
