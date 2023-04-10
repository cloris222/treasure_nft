// To parse this JSON data, do
//
//     final checkReservationInfo = checkReservationInfoFromJson(jsonString);

import 'dart:convert';

CheckReservationInfo checkReservationInfoFromJson(String str) =>
    CheckReservationInfo.fromJson(json.decode(str));

String checkReservationInfoToJson(CheckReservationInfo data) =>
    json.encode(data.toJson());

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
    required this.reserveBalance,
    required this.reserveRanges,
    required this.reserveStartTime,
    required this.reserveEndTime,
    // required this.reserveItems,
    required this.reserveDate,
    required this.systemReserveStartTime,
    required this.systemReserveEndTime,
    required this.reserveStartDate,
    required this.reserveEndDate,
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
  num balance;
  num reserveBalance;
  String reserveStartTime;
  String reserveEndTime;
  List<ReserveRange> reserveRanges;

  ///MARK: 系統預約時間

  String reserveDate;
  String systemReserveStartTime;
  String systemReserveEndTime;

  /// 預約開始日期
  String reserveStartDate;

  /// 預約結束日期
  String reserveEndDate;

  // List<ReserveItem> reserveItems;

  _checkNumber(num check) {
    if (check < 0) {
      return 0;
    }
    return check;
  }

  num getBalance() => _checkNumber(balance);

  num getReserveBalance() => _checkNumber(reserveBalance);

  factory CheckReservationInfo.fromJson(Map<String, dynamic> json) =>
      CheckReservationInfo(
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
        reserveBalance: json["reserveBalance"] ?? 0.0,
        reserveRanges: List<ReserveRange>.from(
            json["reserveRanges"].map((x) => ReserveRange.fromJson(x))),
        // reserveItems: List<ReserveItem>.from(json["reserveItems"].map((x) => ReserveItem.fromJson(x))),
        reserveStartTime: json["reserveStartTime"],
        reserveEndTime: json["reserveEndTime"],
        systemReserveStartTime: json["systemReserveStartTime"] ?? '00:00:00',
        systemReserveEndTime: json["systemReserveEndTime"] ?? '00:00:00',
        reserveDate: json["reserveDate"] ?? "",
        reserveStartDate: json["reserveStartDate"] ?? "",
        reserveEndDate: json["reserveEndDate"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "endTime": endTime,
        "localTime": localTime,
        "systemStartTime": systemStartTime,
        "systemEndTime": systemEndTime,
        "systemTime": systemTime,
        "sellDate": sellDate,
        "systemZone": systemZone,
        "zone": zone,
        "reserveCount": reserveCount,
        "balance": balance,
        "reserveBalance": reserveBalance,
        "reserveRanges":
            List<dynamic>.from(reserveRanges.map((x) => x.toJson())),
        // "reserveItems": List<dynamic>.from(reserveItems.map((x) => x.toJson())),
        "reserveStartTime": reserveStartTime,
        "reserveEndTime": reserveEndTime,
        "systemReserveStartTime": systemReserveStartTime,
        "systemReserveEndTime": systemReserveEndTime,
        "reserveDate": reserveDate,
        "reserveStartDate": reserveStartDate,
        "reserveEndDate": reserveEndDate,
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
  dynamic startPrice;
  dynamic endPrice;
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
