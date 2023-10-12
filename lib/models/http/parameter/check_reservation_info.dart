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
    required this.systemDate,
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
    required this.todayIncome,
    required this.income,
    required this.teamIncome,
    required this.reserveResults,
    required this.resetTime
    // required this.canReserve,
  });

  String startTime;
  String endTime;
  String localTime;
  String systemStartTime;
  String systemEndTime;

  ///系統目前時間
  String systemTime;

  ///系統目前日期
  String systemDate;
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
  /// 預約結果
  List<ReserveResults> reserveResults;

  num todayIncome;
  num income;
  num teamIncome;
  String resetTime; // 重置時間
  // bool canReserve;

  // List<ReserveItem> reserveItems;

  _checkNumber(num check) {
    if (check < 0) {
      return 0;
    }
    return check;
  }

  num getBalance() => _checkNumber(balance);

  num getReserveBalance() => _checkNumber(reserveBalance);

  num getTodayIncome() => _checkNumber(todayIncome);

  num getIncome() => _checkNumber(income);

  num getTeamIncome() => _checkNumber(teamIncome);

  factory CheckReservationInfo.fromJson(Map<String, dynamic> json) =>
      CheckReservationInfo(
        startTime: json["startTime"],
        endTime: json["endTime"],
        localTime: json["localTime"],
        systemStartTime: json["systemStartTime"],
        systemEndTime: json["systemEndTime"],
        systemTime: json["systemTime"],
        systemDate: json["systemDate"] ?? "",
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
        todayIncome: json["todayIncome"]??0.0,
        income: json["income"]??0.0,
        teamIncome: json["teamIncome"]??0.0,
        reserveResults: json["reserveResults"] == null ? [] :
        List<ReserveResults>.from(json["reserveResults"].map((x) => ReserveResults.fromJson(x)))??[],
        resetTime: json["resetTime"] ?? "",
        // canReserve: json["canReserve"],
      );

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "endTime": endTime,
    "localTime": localTime,
    "systemStartTime": systemStartTime,
    "systemEndTime": systemEndTime,
    "systemTime": systemTime,
    "systemDate": systemDate,
    "sellDate": sellDate,
    "systemZone": systemZone,
    "zone": zone,
    "reserveCount": reserveCount,
    "balance": balance,
    "reserveBalance": reserveBalance,
    "reserveRanges": List<dynamic>.from(reserveRanges.map((x) => x.toJson())),
    // "reserveItems": List<dynamic>.from(reserveItems.map((x) => x.toJson())),
    "reserveStartTime": reserveStartTime,
    "reserveEndTime": reserveEndTime,
    "systemReserveStartTime": systemReserveStartTime,
    "systemReserveEndTime": systemReserveEndTime,
    "reserveDate": reserveDate,
    "reserveStartDate": reserveStartDate,
    "reserveEndDate": reserveEndDate,
    "todayIncome": todayIncome,
    "income": income,
    "teamIncome": teamIncome,
    "reserveResults": List<dynamic>.from(reserveResults.map((x) => x.toJson())),
    "resetTime": resetTime,
    // "canReserve": canReserve,
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
    required this.rewardRate,
    required this.grow,
    required this.startExpectedReturn,
    required this.endExpectedReturn
  });

  int index; // 序列號
  num startPrice; // 價格區間(開始)
  num endPrice; // 價格區間(結束)
  bool used; // 預約狀態
  bool lock; // 是否鎖定
  num rewardRate; // 獎勵%數
  num grow; // 預期收益
  num startExpectedReturn; // 預期收益（起始）
  num endExpectedReturn; // 預期收益（結束）

  factory ReserveRange.fromJson(Map<String, dynamic> json) => ReserveRange(
        index: json["index"],
        startPrice: json["startPrice"] ?? 0,
        endPrice: json["endPrice"]?? 0,
        used: json["used"],
        lock: json["lock"],
        rewardRate: json["rewardRate"]??0,
        grow: json["grow"]??0,
        startExpectedReturn: json["startExpectedReturn"]??0,
        endExpectedReturn: json["endExpectedReturn"]??0,
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "startPrice": startPrice,
        "endPrice": endPrice,
        "used": used,
        "lock": lock,
        "rewardRate": rewardRate,
        "grow": grow,
        "startExpectedReturn": startExpectedReturn,
        "endExpectedReturn": endExpectedReturn,
      };
}

class ReserveResults {
  ReserveResults({
    required this.orderNo,
    required this.itemName,
    required this.itemPrice,
    required this.imgUrl,
    required this.isWin,
  });

  String orderNo;
  String itemName;
  num itemPrice;
  String imgUrl;
  bool isWin;

  factory ReserveResults.fromJson(Map<String, dynamic> json) => ReserveResults(
    orderNo: json["orderNo"]??"",
    itemName: json["itemName"] ?? "",
    itemPrice: json["itemPrice"]?? 0,
    imgUrl: json["imgUrl"]??"",
    isWin: json["isWin"],
  );

  Map<String, dynamic> toJson() => {
    "orderNo": orderNo,
    "itemName": itemName,
    "itemPrice": itemPrice,
    "imgUrl": imgUrl,
    "isWin": isWin,
  };
}
