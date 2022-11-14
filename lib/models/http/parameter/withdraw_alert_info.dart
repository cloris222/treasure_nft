// To parse this JSON data, do
//
//     final withdrawAlertInfo = withdrawAlertInfoFromJson(jsonString);

import 'dart:convert';

WithdrawAlertInfo withdrawAlertInfoFromJson(String str) =>
    WithdrawAlertInfo.fromJson(json.decode(str));

String withdrawAlertInfoToJson(WithdrawAlertInfo data) =>
    json.encode(data.toJson());

class WithdrawAlertInfo {
  WithdrawAlertInfo({
    this.isReserve = false,
    this.validAmount = '0.0',
  });

  /// 是否有預約單
  bool isReserve;

  /// 可提現現金
  String validAmount;

  factory WithdrawAlertInfo.fromJson(Map<String, dynamic> json) =>
      WithdrawAlertInfo(
        isReserve: json["isReserve"],
        validAmount: json["validAmount"],
      );

  Map<String, dynamic> toJson() => {
        "isReserve": isReserve,
        "validAmount": validAmount,
      };
}
