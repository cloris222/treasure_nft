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
    this.isBlock = false,
    this.expireIn = 0,
  });

  /// 是否有預約單
  bool isReserve;

  /// 可提現現金
  String validAmount;

  /// 是否有提現鎖
  bool isBlock;

  /// 禁止時間(秒)
  num expireIn;

  factory WithdrawAlertInfo.fromJson(Map<String, dynamic> json) =>
      WithdrawAlertInfo(
        isReserve: json["isReserve"],
        validAmount: json["validAmount"],
        isBlock: json["isBlock"],
        expireIn: json["expireIn"],
      );

  Map<String, dynamic> toJson() => {
        "isReserve": isReserve,
        "validAmount": validAmount,
        "isBlock": isBlock,
        "expireIn": expireIn,
      };
}
