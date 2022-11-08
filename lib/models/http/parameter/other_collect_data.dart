// To parse this JSON data, do
//
//     final otherCollectData = otherCollectDataFromJson(jsonString);

import 'dart:convert';

OtherCollectData otherCollectDataFromJson(String str) =>
    OtherCollectData.fromJson(json.decode(str));

String otherCollectDataToJson(OtherCollectData data) =>
    json.encode(data.toJson());

class OtherCollectData {
  OtherCollectData({
    required this.nftName,
    required this.nftCurrentPrice,
    required this.nftImgUrl,
  });

  String nftName;
  double nftCurrentPrice;
  String nftImgUrl;

  factory OtherCollectData.fromJson(Map<String, dynamic> json) =>
      OtherCollectData(
        nftName: json["nftName"],
        nftCurrentPrice: json["nftCurrentPrice"].toDouble(),
        nftImgUrl: json["nftImgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "nftName": nftName,
        "nftCurrentPrice": nftCurrentPrice,
        "nftImgUrl": nftImgUrl,
      };
}
