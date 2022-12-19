// To parse this JSON data, do
//
//     final collectTopInfo = collectTopInfoFromJson(jsonString);

import 'dart:convert';

CollectTopInfo collectTopInfoFromJson(String str) =>
    CollectTopInfo.fromJson(json.decode(str));

String collectTopInfoToJson(CollectTopInfo data) => json.encode(data.toJson());

class CollectTopInfo {
  CollectTopInfo({
    required this.artistName,
    required this.artistId,
    required this.introPhoneUrl,
    required this.introPcUrl,
    required this.avatarUrl,
    required this.yesVolume,
    required this.volume,
    required this.growthRate,
  });

  String artistName;
  String artistId;
  String introPhoneUrl;
  String introPcUrl;
  String avatarUrl;
  num yesVolume;
  num volume;
  num growthRate;

  factory CollectTopInfo.fromJson(Map<String, dynamic> json) => CollectTopInfo(
        artistName: json["artistName"] ?? '',
        artistId: json["artistId"] ?? '',
        introPhoneUrl: json["introPhoneUrl"] ?? '',
        introPcUrl: json["introPcUrl"] ?? '',
        avatarUrl: json["avatarUrl"] ?? '',
        yesVolume: json["yesVolume"] ?? 0,
        volume: json["volume"] ?? 0,
        growthRate: json["growthRate"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "artistName": artistName,
        "artistId": artistId,
        "introPhoneUrl": introPhoneUrl,
        "introPcUrl": introPcUrl,
        "avatarUrl": avatarUrl,
        "yesVolume": yesVolume,
        "volume": volume,
        "growthRate": growthRate,
      };
}
