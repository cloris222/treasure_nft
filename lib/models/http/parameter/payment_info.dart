// To parse this JSON data, do
//
//     final paymentInfo = paymentInfoFromJson(jsonString);

import 'dart:convert';

PaymentInfo paymentInfoFromJson(String str) => PaymentInfo.fromJson(json.decode(str));

String paymentInfoToJson(PaymentInfo data) => json.encode(data.toJson());

class PaymentInfo {
  PaymentInfo({
    required this.payType,
    required this.account,
  });

  String payType;
  String account;

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
    payType: json["payType"]??'',
    account: json["account"]??'',
  );

  Map<String, dynamic> toJson() => {
    "payType": payType,
    "account": account,
  };
}
