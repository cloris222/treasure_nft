// To parse this JSON data, do
//
//     final artistRecord = artistRecordFromJson(jsonString);

import 'dart:convert';

ArtistRecord artistRecordFromJson(String str) =>
    ArtistRecord.fromJson(json.decode(str));

String artistRecordToJson(ArtistRecord data) => json.encode(data.toJson());

class ArtistRecord {
  ArtistRecord({
    this.id = '',
    this.name = '',
    this.twitter = '',
    this.avatarUrl = '',
    this.intro = '',
    this.baseAmtTotal = '',
    this.baseYdayAmt = '',
    this.baseItemPrice = '',
    this.baseOwnerCount = 0,
    this.introPhoneUrl = '',
    this.introPcUrl = '',
    this.sort = 0,
    this.amtTotal = '',
    this.ydayAmt = '',
    this.tradeRate = '',
    this.ownerCount = 0,
    this.itemCount = 0,
    this.imgUrl = const [],
    this.imgInfo = const [],
  });

  String id;
  String name;
  String twitter;
  String avatarUrl;
  String intro; //畫家介紹
  String baseAmtTotal; //基本總交易量(U)
  String baseYdayAmt; //基本昨日交易金額(U)
  String baseItemPrice; //商品底價(U)
  int baseOwnerCount; //基本持有帳號數量
  String introPhoneUrl; //介紹背景(手機)
  String introPcUrl; //介紹背景(電腦)
  int sort;
  String amtTotal; //總交易量(U)
  String ydayAmt; //昨日交易金額(U)
  String tradeRate; //交易率%
  int ownerCount; //持有帳號數量
  int itemCount; //發行數量
  List<String> imgUrl; //隨機傳4張圖片
  List<ImgInfo> imgInfo;

  factory ArtistRecord.fromJson(Map<String, dynamic> json) => ArtistRecord(
        id: json["id"],
        name: json["name"],
        twitter: json["twitter"],
        avatarUrl: json["avatarUrl"],
        intro: json["intro"],
        baseAmtTotal: json["baseAmtTotal"],
        baseYdayAmt: json["baseYdayAmt"],
        baseItemPrice: json["baseItemPrice"],
        baseOwnerCount: json["baseOwnerCount"],
        introPhoneUrl: json["introPhoneUrl"],
        introPcUrl: json["introPcUrl"],
        sort: json["sort"],
        amtTotal: json["amtTotal"],
        ydayAmt: json["ydayAmt"],
        tradeRate: json["tradeRate"],
        ownerCount: json["ownerCount"],
        itemCount: json["itemCount"],
        imgUrl: json.containsKey("imgUrl")
            ? List<String>.from(json["imgUrl"].map((x) => x))
            : [],
        imgInfo: json.containsKey("imgUrl")
            ? List<ImgInfo>.from(
                json["imgInfo"].map((x) => ImgInfo.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "twitter": twitter,
        "avatarUrl": avatarUrl,
        "intro": intro,
        "baseAmtTotal": baseAmtTotal,
        "baseYdayAmt": baseYdayAmt,
        "baseItemPrice": baseItemPrice,
        "baseOwnerCount": baseOwnerCount,
        "introPhoneUrl": introPhoneUrl,
        "introPcUrl": introPcUrl,
        "sort": sort,
        "amtTotal": amtTotal,
        "ydayAmt": ydayAmt,
        "tradeRate": tradeRate,
        "ownerCount": ownerCount,
        "itemCount": itemCount,
        "imgUrl": List<dynamic>.from(imgUrl.map((x) => x)),
        "imgInfo": List<dynamic>.from(imgInfo.map((x) => x.toJson())),
      };
}

class ImgInfo {
  ImgInfo({
    required this.imgUrl,
    required this.name,
    required this.currentPrice,
  });

  String imgUrl;
  String name;
  num currentPrice;

  factory ImgInfo.fromJson(Map<String, dynamic> json) => ImgInfo(
        imgUrl: json["imgUrl"],
        name: json["name"],
        currentPrice: json["currentPrice"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "imgUrl": imgUrl,
        "name": name,
        "currentPrice": currentPrice,
      };
}
