// To parse this JSON data, do
//
//     final medalInfoData = medalInfoDataFromJson(jsonString);

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

MedalInfoData medalInfoDataFromJson(String str) =>
    MedalInfoData.fromJson(json.decode(str));

String medalInfoDataToJson(MedalInfoData data) => json.encode(data.toJson());

class MedalInfoData {
  MedalInfoData({
    required this.title,
    required this.code,
    required this.isFinished,
  });

  String title;
  String code;
  bool isFinished;

  factory MedalInfoData.fromJson(Map<String, dynamic> json) => MedalInfoData(
        title: json["title"],
        code: json["code"],
        isFinished: json["isFinished"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "code": code,
        "isFinished": isFinished,
      };

  String getMedalText() {
    return tr('mis_t_$code');
  }
}
