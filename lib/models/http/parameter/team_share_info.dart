// To parse this JSON data, do
//
//     final teamShareInfo = teamShareInfoFromJson(jsonString);

import 'dart:convert';

TeamShareInfo teamShareInfoFromJson(String str) =>
    TeamShareInfo.fromJson(json.decode(str));

String teamShareInfoToJson(TeamShareInfo data) => json.encode(data.toJson());

class TeamShareInfo {
  TeamShareInfo({
    required this.day,
    required this.promotePct,
    required this.profitPCT, // for個人訂單分享
  });

  int day;
  double promotePct;
  double profitPCT;

  factory TeamShareInfo.fromJson(Map<String, dynamic> json) => TeamShareInfo(
        day: json["day"],
        promotePct: json["promotePCT"]!=null? json["promotePCT"].toDouble() : 0,
        profitPCT: json["profitPCT"]!=null? json["profitPCT"].toDouble() : 0,
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "promotePCT": promotePct,
        "profitPCT": profitPCT,
      };
}
