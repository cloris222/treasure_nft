// To parse this JSON data, do
//
//     final bannerData = bannerDataFromJson(jsonString);

import 'dart:convert';

BannerData bannerDataFromJson(String str) => BannerData.fromJson(json.decode(str));

String bannerDataToJson(BannerData data) => json.encode(data.toJson());

class BannerData {
  String id;
  String viewPc;
  String viewMb;
  String name;
  String externalUrl;
  String startAt;
  String endAt;
  String carouselSeconds;

  BannerData({
    this.id = '',
    this.viewPc = '',
    this.viewMb = '',
    this.name = '',
    this.externalUrl = '',
    this.startAt = '',
    this.endAt = '',
    this.carouselSeconds = '',
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    id: json["id"]??'',
    viewPc: json["viewPc"]??'',
    viewMb: json["viewMb"]??'',
    name: json["name"]??'',
    externalUrl: json["externalUrl"]??'',
    startAt: json["startAt"]??'',
    endAt: json["endAt"]??'',
    carouselSeconds: json["carouselSeconds"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "viewPc": viewPc,
    "viewMb": viewMb,
    "name": name,
    "externalUrl": externalUrl,
    "startAt": startAt,
    "endAt": endAt,
    "carouselSeconds": carouselSeconds,
  };
}
