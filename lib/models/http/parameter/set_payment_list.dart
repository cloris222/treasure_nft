// To parse this JSON data, do
//
//     final setPaymentList = setPaymentListFromJson(jsonString);

import 'dart:convert';

SetPaymentList setPaymentListFromJson(String str) => SetPaymentList.fromJson(json.decode(str));

String setPaymentListToJson(SetPaymentList data) => json.encode(data.toJson());

class SetPaymentList {
  SetPaymentList({
   required this.paymentList,
  });

  List<PaymentList> paymentList;

  factory SetPaymentList.fromJson(Map<String, dynamic> json) => SetPaymentList(
    paymentList: List<PaymentList>.from(json["paymentList"].map((x) => PaymentList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "paymentList": List<dynamic>.from(paymentList.map((x) => x.toJson())),
  };
}

class PaymentList {
  PaymentList({
   required this.payType,
   required this.account,
  });

  String payType;
  String account;

  factory PaymentList.fromJson(Map<String, dynamic> json) => PaymentList(
    payType: json["payType"],
    account: json["account"],
  );

  Map<String, dynamic> toJson() => {
    "payType": payType,
    "account": account,
  };
}
