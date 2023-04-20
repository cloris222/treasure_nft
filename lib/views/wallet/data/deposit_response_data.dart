// To parse this JSON data, do
//
//     final depositResponseData = depositResponseDataFromJson(jsonString);

import 'dart:convert';

DepositResponseData depositResponseDataFromJson(String str) => DepositResponseData.fromJson(json.decode(str));

String depositResponseDataToJson(DepositResponseData data) => json.encode(data.toJson());

class DepositResponseData {
  DepositResponseData({
    this.orderNo = '',
    this.redirectUrl = '',
    this.status = '',
  });

  String orderNo;
  String redirectUrl;
  String status; //SUCCESS, PENDING, FAIL

  factory DepositResponseData.fromJson(Map<String, dynamic> json) => DepositResponseData(
    orderNo: json["orderNo"]??'',
    redirectUrl: json["redirectUrl"]??'',
    status: json["status"]??'',
  );

  Map<String, dynamic> toJson() => {
    "orderNo": orderNo,
    "redirectUrl": redirectUrl,
    "status": status,
  };
}
