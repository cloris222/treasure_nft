// To parse this JSON data, do
//
//     final withdrawBalanceResponseData = withdrawBalanceResponseDataFromJson(jsonString);

import 'dart:convert';

WithdrawBalanceResponseData withdrawBalanceResponseDataFromJson(String str) =>
    WithdrawBalanceResponseData.fromJson(json.decode(str));

String withdrawBalanceResponseDataToJson(WithdrawBalanceResponseData data) =>
    json.encode(data.toJson());

class WithdrawBalanceResponseData {
  WithdrawBalanceResponseData({
    this.address = '',
    this.balance = '',
    this.feeRate = '',
    this.fee = '',
    this.minAmount = '',
    this.internalMinAmount = '',
  });

  String address;
  String balance;
  String feeRate;
  String fee;
  String minAmount;
  String internalMinAmount;

  factory WithdrawBalanceResponseData.fromJson(Map<String, dynamic> json) =>
      WithdrawBalanceResponseData(
        address: json["address"] ?? '',
        balance: json["balance"] ?? '',
        feeRate: json["feeRate"] ?? '',
        fee: json["fee"] ?? '',
        minAmount: json["minAmount"] ?? '',
        internalMinAmount: json["internalMinAmount"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "balance": balance,
        "feeRate": feeRate,
        "fee": fee,
        "minAmount": minAmount,
        "internamMinAmount": internalMinAmount,
      };

  num _checkMoney(String number) {
    try {
      num check = num.parse(number);
      if (check < 0) {
        return 0;
      }
      return check;
    } catch (e) {
      return 0;
    }
  }

  num getBalance() => _checkMoney(balance);
}
