// To parse this JSON data, do
//
//     final randomCollectInfo = randomCollectInfoFromJson(jsonString);

import 'dart:convert';

List<RandomCollectInfo> randomCollectInfoFromJson(String str) =>
    List<RandomCollectInfo>.from(
        json.decode(str).map((x) => RandomCollectInfo.fromJson(x)));

String randomCollectInfoToJson(List<RandomCollectInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RandomCollectInfo {
  RandomCollectInfo({
    required this.collectionName,
    required this.creatorAvatarUrl,
    required this.creator,
    required this.itemCount,
    required this.nftItemInfo,
  });

  String collectionName;
  String creatorAvatarUrl;
  String creator;
  num itemCount;
  List<NftItemInfo> nftItemInfo;

  factory RandomCollectInfo.fromJson(Map<String, dynamic> json) =>
      RandomCollectInfo(
        collectionName: json["collectionName"] ?? '',
        creatorAvatarUrl: json["creatorAvatarUrl"] ?? '',
        creator: json["creator"] ?? '',
        itemCount: json["itemCount"] ?? 0,
        nftItemInfo: json.containsKey("nftItemInfo")
            ? List<NftItemInfo>.from(
                json["nftItemInfo"].map((x) => NftItemInfo.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "collectionName": collectionName,
        "creatorAvatarUrl": creatorAvatarUrl,
        "creator": creator,
        "itemCount": itemCount,
        "nftItemInfo": List<dynamic>.from(nftItemInfo.map((x) => x.toJson())),
      };
}

class NftItemInfo {
  NftItemInfo({
    required this.id,
    required this.name,
    required this.imgUrl,
  });

  String id;
  String name;
  String imgUrl;

  factory NftItemInfo.fromJson(Map<String, dynamic> json) => NftItemInfo(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        imgUrl: json["imgUrl"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imgUrl": imgUrl,
      };
}
