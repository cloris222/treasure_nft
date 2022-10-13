// To parse this JSON data, do
//
//     final exploreArtistDetailResponseData = exploreArtistDetailResponseDataFromJson(jsonString);

import 'dart:convert';

ExploreArtistDetailResponseData exploreArtistDetailResponseDataFromJson(String str) => ExploreArtistDetailResponseData.fromJson(json.decode(str));

String exploreArtistDetailResponseDataToJson(ExploreArtistDetailResponseData data) => json.encode(data.toJson());

class ExploreArtistDetailResponseData {
  ExploreArtistDetailResponseData({
    this.artistName = '',
    this.creatorName = '',
    this.artistInfo = '',
    this.photoUrl = '',
    this.pcUrl = '',
    this.mbUrl = '',
    required this.sms,
    this.items = 0,
    this.owners = 0,
    this.volume = '',
    this.floorPrice = '',
    required this.list,
  });

  String artistName;
  String creatorName;
  String artistInfo;
  String photoUrl;
  String pcUrl;
  String mbUrl;
  List<Sm> sms;
  int items;
  int owners;
  String volume;
  String floorPrice;
  ListClass list;

  factory ExploreArtistDetailResponseData.fromJson(Map<String, dynamic> json) => ExploreArtistDetailResponseData(
    artistName: json["artistName"],
    creatorName: json["creatorName"] ?? '',
    artistInfo: json["artistInfo"],
    photoUrl: json["photoUrl"],
    pcUrl: json["pcUrl"],
    mbUrl: json["mbUrl"],
    sms: List<Sm>.from(json["sms"].map((x) => Sm.fromJson(x))),
    items: json["items"],
    owners: json["owners"],
    volume: json["volume"],
    floorPrice: json["floorPrice"],
    list: ListClass.fromJson(json["list"]),
  );

  Map<String, dynamic> toJson() => {
    "artistName": artistName,
    "creatorName": creatorName,
    "artistInfo": artistInfo,
    "photoUrl": photoUrl,
    "pcUrl": pcUrl,
    "mbUrl": mbUrl,
    "sms": List<dynamic>.from(sms.map((x) => x.toJson())),
    "items": items,
    "owners": owners,
    "volume": volume,
    "floorPrice": floorPrice,
    "list": list.toJson(),
  };
}

class ListClass {
  ListClass({
    this.total = 0,
    this.totalPages = 0,
    required this.pageList,
  });

  int total;
  int totalPages;
  List<PageList> pageList;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
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
    this.itemId  = '',
    this.ownerId = '',
    this.name = '',
    this.imgUrl = '',
    this.price = '',
    this.growAmount = '',
    this.status = '',
  });

  String itemId;
  String ownerId;
  String name;
  String imgUrl;
  String price;
  String growAmount;
  String status;

  factory PageList.fromJson(Map<String, dynamic> json) => PageList(
    itemId: json["itemId"],
    ownerId: json["ownerId"],
    name: json["name"],
    imgUrl: json["imgUrl"],
    price: json["price"],
    growAmount: json["growAmount"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "ownerId": ownerId,
    "name": name,
    "imgUrl": imgUrl,
    "price": price,
    "growAmount": growAmount,
    "status": status,
  };
}

class Sm {
  Sm({
    this.type = '',
    this.data = '',
  });

  String type;
  String data;

  factory Sm.fromJson(Map<String, dynamic> json) => Sm(
    type: json["type"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data,
  };
}
