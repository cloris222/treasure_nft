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
    this.hasWithdraw = false,
    this.cause = const[],
  });

  /// 是否有預約單
  bool isReserve;
  /// 可提現現金
  String validAmount;
  /// 是否有提現鎖
  bool isBlock;
  /// 禁止時間(秒)
  num expireIn;
  /// 是否有提現單
  bool hasWithdraw;
  /// 禁止原因
  List<CaseList> cause;

  factory WithdrawAlertInfo.fromJson(Map<String, dynamic> json) =>
    WithdrawAlertInfo(
      isReserve: json["isReserve"],
      validAmount: json["validAmount"],
      isBlock: json["isBlock"]??false,
      expireIn: json["expireIn"]??0,
      hasWithdraw: json["hasWithdraw"],
      cause: List<CaseList>.from(json["cause"].map((x)=> CaseList.fromJson(x))),
    );

  Map<String, dynamic> toJson() => {
    "isReserve": isReserve,
    "validAmount": validAmount,
    "isBlock": isBlock,
    "expireIn": expireIn,
    "hasWithdraw": hasWithdraw,
    "cause": List<dynamic>.from(cause.map((e) => e.toJson())),
  };
}

class CaseList{
  CaseList({
    this.cause = '',
    this.expireIn = 0
  });
  String cause;
  int expireIn;

  factory CaseList.fromJson(Map<String,dynamic>json) => CaseList(
    cause: json["cause"],
    expireIn: json["expireIn"],
  );

  Map<String, dynamic> toJson() =>{
    "cause": cause,
    "expireIn": expireIn,
  };
}
