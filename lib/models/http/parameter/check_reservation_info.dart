// To parse this JSON data, do
//
//     final checkReservationInfo = checkReservationInfoFromJson(jsonString);

import 'dart:convert';

CheckReservationInfo checkReservationInfoFromJson(String str) => CheckReservationInfo.fromJson(json.decode(str));

String checkReservationInfoToJson(CheckReservationInfo data) => json.encode(data.toJson());

class CheckReservationInfo {
  CheckReservationInfo({
    required this.startTime,
    required this.endTime,
    required this.localTime,
    required this.systemStartTime,
    required this.systemEndTime,
    required this.systemTime,
    required this.sellDate,
    required this.systemZone,
    required this.zone,
    required this.reserveCount,
    required this.balance,
    required this.reserveRanges,
    // required this.reserveItems,
  });

  String startTime;
  String endTime;
  String localTime;
  String systemStartTime;
  String systemEndTime;
  String systemTime;
  String sellDate;
  String systemZone;
  String zone;
  int reserveCount;
  double balance;
  List<ReserveRange> reserveRanges;
  // List<ReserveItem> reserveItems;

  factory CheckReservationInfo.fromJson(Map<String, dynamic> json) => CheckReservationInfo(
    startTime: json["startTime"],
    endTime: json["endTime"],
    localTime: json["localTime"],
    systemStartTime: json["systemStartTime"],
    systemEndTime: json["systemEndTime"],
    systemTime: json["systemTime"],
    sellDate: json["sellDate"] ?? "",
    systemZone: json["systemZone"],
    zone: json["zone"],
    reserveCount: json["reserveCount"],
    balance: json["balance"],
    reserveRanges: List<ReserveRange>.from(json["reserveRanges"].map((x) => ReserveRange.fromJson(x))),
    // reserveItems: List<ReserveItem>.from(json["reserveItems"].map((x) => ReserveItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "endTime": endTime,
    "localTime": localTime,
    "systemStartTime": systemStartTime,
    "systemEndTime": systemEndTime,
    "systemTime": systemTime,
    "sellDate": sellDate ,
    "systemZone": systemZone,
    "zone": zone,
    "reserveCount": reserveCount,
    "balance": balance,
    "reserveRanges": List<dynamic>.from(reserveRanges.map((x) => x.toJson())),
    // "reserveItems": List<dynamic>.from(reserveItems.map((x) => x.toJson())),
  };
}

class ReserveItem {
  ReserveItem({
    required this.itemId,
    required this.usedCount,
  });

  String itemId;
  int usedCount;

  factory ReserveItem.fromJson(Map<String, dynamic> json) => ReserveItem(
    itemId: json["itemId"],
    usedCount: json["usedCount"],
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "usedCount": usedCount,
  };
}

class ReserveRange {
  ReserveRange({
    required this.index,
    required this.startPrice,
    required this.endPrice,
    required this.used,
    required this.lock,
  });

  int index;
  double startPrice;
  double endPrice;
  bool used;
  bool lock;

  factory ReserveRange.fromJson(Map<String, dynamic> json) => ReserveRange(
    index: json["index"],
    startPrice: json["startPrice"] ?? 0,
    endPrice: json["endPrice"],
    used: json["used"],
    lock: json["lock"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "startPrice": startPrice,
    "endPrice": endPrice,
    "used": used,
    "lock": lock,
  };
}
