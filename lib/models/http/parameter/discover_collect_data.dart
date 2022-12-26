// To parse this JSON data, do
//
//     final discoverCollectData = discoverCollectDataFromJson(jsonString);

import 'dart:convert';

DiscoverCollectData discoverCollectDataFromJson(String str) =>
    DiscoverCollectData.fromJson(json.decode(str));

String discoverCollectDataToJson(DiscoverCollectData data) =>
    json.encode(data.toJson());

class DiscoverCollectData {
  DiscoverCollectData({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.imgDataType,
    required this.currentPrice,
    required this.startTime,
    required this.avatarUrl,
  });

  String id;
  String name;
  String imgUrl;
  String imgDataType;
  num currentPrice;
  String startTime;
  String avatarUrl;

  factory DiscoverCollectData.fromJson(Map<String, dynamic> json) =>
      DiscoverCollectData(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        imgUrl: json["imgUrl"] ?? '',
        imgDataType: json["imgDataType"] ?? '',
        currentPrice: json["currentPrice"] ?? 0,
        startTime: json["startTime"] ?? '',
        avatarUrl: json["avatarUrl"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imgUrl": imgUrl,
        "imgDataType": imgDataType,
        "currentPrice": currentPrice,
        "startTime": startTime,
        "avatarUrl": avatarUrl,
      };
}
