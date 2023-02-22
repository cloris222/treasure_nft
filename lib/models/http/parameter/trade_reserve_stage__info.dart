// To parse this JSON data, do
//
//     final tradeReserveStageInfo = tradeReserveStageInfoFromJson(jsonString);

import 'dart:convert';

TradeReserveStageInfo tradeReserveStageInfoFromJson(String str) =>
    TradeReserveStageInfo.fromJson(json.decode(str));

String tradeReserveStageInfoToJson(TradeReserveStageInfo data) =>
    json.encode(data.toJson());

class TradeReserveStageInfo {
  TradeReserveStageInfo({
    required this.date,
    required this.stage,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.reserveBalance,
  });

  DateTime date;
  int stage;
  DateTime startTime;
  DateTime endTime;
  bool isAvailable;
  num reserveBalance;

  factory TradeReserveStageInfo.fromJson(Map<String, dynamic> json) =>
      TradeReserveStageInfo(
        date: DateTime.parse(json["date"]),
        stage: json["stage"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        isAvailable: json["isAvailable"],
        reserveBalance: json["reserveBalance"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "stage": stage,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "isAvailable": isAvailable,
        "reserveBalance": reserveBalance,
      };
}
