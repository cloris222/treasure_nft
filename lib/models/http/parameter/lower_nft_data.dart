
import 'dart:convert';

LowerNftData lowerNftDataFromJson(String str) => LowerNftData.fromJson(json.decode(str));

String lowerNftDataToJson(LowerNftData data) => json.encode(data.toJson());

class LowerNftData {
  LowerNftData({
    this.id = '',
    this.name = '',
    this.imgUrl = '',
    this.originImgUrl = '',
    this.marketId = '',
    this.currentPrice,
    this.status = '',
  });

  String id;
  String name;
  String imgUrl;
  String originImgUrl;
  String marketId;
  dynamic currentPrice;
  String status;

  factory LowerNftData.fromJson(Map<String, dynamic> json) => LowerNftData(
    id: json["id"],
    name: json["name"],
    imgUrl: json["imgUrl"],
    originImgUrl: json["originImgUrl"],
    marketId: json["marketId"] ?? '',
    currentPrice: json["currentPrice"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imgUrl": imgUrl,
    "originImgUrl": originImgUrl,
    "marketId": marketId,
    "currentPrice": currentPrice,
    "status": status,
  };
}
