// To parse this JSON data, do
//
//     final checkShareCenter = checkShareCenterFromJson(jsonString);

import 'dart:convert';

CheckShareCenter checkShareCenterFromJson(String str) => CheckShareCenter.fromJson(json.decode(str));

String checkShareCenterToJson(CheckShareCenter data) => json.encode(data.toJson());

class CheckShareCenter {
  CheckShareCenter({
    required this.directRecommend,
    required this.teamIncome,
    required this.no1DirectId,
    required this.no1DirectIncome,
  });

  double directRecommend;
  double teamIncome;
  String no1DirectId;
  int no1DirectIncome;

  factory CheckShareCenter.fromJson(Map<String, dynamic> json) => CheckShareCenter(
    directRecommend: json["directRecommend"].toDouble(),
    teamIncome: json["teamIncome"].toDouble(),
    no1DirectId: json["no1DirectId"],
    no1DirectIncome: json["no1DirectIncome"],
  );

  Map<String, dynamic> toJson() => {
    "directRecommend": directRecommend,
    "teamIncome": teamIncome,
    "no1DirectId": no1DirectId,
    "no1DirectIncome": no1DirectIncome,
  };
}
