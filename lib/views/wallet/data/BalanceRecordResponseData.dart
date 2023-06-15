// To parse this JSON data, do
//
//     final balanceRecordResponseData = balanceRecordResponseDataFromJson(jsonString);

import 'dart:convert';

BalanceRecordResponseData balanceRecordResponseDataFromJson(String str) => BalanceRecordResponseData.fromJson(json.decode(str));

String balanceRecordResponseDataToJson(BalanceRecordResponseData data) => json.encode(data.toJson());

class BalanceRecordResponseData {
  BalanceRecordResponseData({
    this.time = '',
    this.amount = 0,
    this.type = '',
    this.status = '',
  });

  String time;
  num amount;
  String type;
  String status;

  factory BalanceRecordResponseData.fromJson(Map<String, dynamic> json) => BalanceRecordResponseData(
    time: json["time"]??'',
    amount: json["amount"],
    type: json["type"]??'',
    status: json["status"]??'',
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "amount": amount,
    "type": type,
    "status": status,
  };
}
