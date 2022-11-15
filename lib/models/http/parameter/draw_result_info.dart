// To parse this JSON data, do
//
//     final drawResultInfo = drawResultInfoFromJson(jsonString);

import 'dart:convert';

DrawResultInfo drawResultInfoFromJson(String str) =>
    DrawResultInfo.fromJson(json.decode(str));

String drawResultInfoToJson(DrawResultInfo data) => json.encode(data.toJson());

class DrawResultInfo {
  DrawResultInfo({
    required this.startAt,
    required this.endAt,
    required this.zone,
    required this.prizeList,
  });

  String startAt;
  String endAt;
  String zone;
  List<PrizeList> prizeList;

  factory DrawResultInfo.fromJson(Map<String, dynamic> json) => DrawResultInfo(
        startAt: json["startAt"],
        endAt: json["endAt"],
        zone: json["zone"],
        prizeList: List<PrizeList>.from(
            json["prizeList"].map((x) => PrizeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "startAt": startAt,
        "endAt": endAt,
        "zone": zone,
        "prizeList": List<dynamic>.from(prizeList.map((x) => x.toJson())),
      };
}

class PrizeList {
  PrizeList(
      {required this.index,
      required this.quota,
      required this.amount,
      required this.winners});

  int index;
  int quota;
  int amount;
  List<String> winners;

  factory PrizeList.fromJson(Map<String, dynamic> json) => PrizeList(
        index: json["index"],
        quota: json["quota"],
        amount: json["amount"],
        winners: List<String>.from(json["winners"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "quota": quota,
        "amount": amount,
        "winners": List<dynamic>.from(winners.map((x) => x)),
      };
}
