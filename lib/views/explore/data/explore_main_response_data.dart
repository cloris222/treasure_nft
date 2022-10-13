// To parse this JSON data, do
//
//     final exploreMainResponseData = exploreMainResponseDataFromJson(jsonString);

import 'dart:convert';

ExploreMainResponseData exploreMainResponseDataFromJson(String str) => ExploreMainResponseData.fromJson(json.decode(str));

String exploreMainResponseDataToJson(ExploreMainResponseData data) => json.encode(data.toJson());

class ExploreMainResponseData {
  ExploreMainResponseData({
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

  factory ExploreMainResponseData.fromJson(Map<String, dynamic> json) => ExploreMainResponseData(
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
