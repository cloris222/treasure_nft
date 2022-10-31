// To parse this JSON data, do
//
//     final checkReserveDeposit = checkReserveDepositFromJson(jsonString);

import 'dart:convert';

CheckReserveDeposit checkReserveDepositFromJson(String str) =>
    CheckReserveDeposit.fromJson(json.decode(str));

String checkReserveDepositToJson(CheckReserveDeposit data) =>
    json.encode(data.toJson());

class CheckReserveDeposit {
  CheckReserveDeposit({
    required this.deposit,
    required this.reserveBalance,
    required this.tradingTime,
    required this.reward,
  });

  int deposit;
  double reserveBalance;
  int tradingTime;
  double reward;

  factory CheckReserveDeposit.fromJson(Map<String, dynamic> json) =>
      CheckReserveDeposit(
        deposit: json["deposit"],
        reserveBalance: json["reserveBalance"].toDouble(),
        tradingTime: json["tradingTime"],
        reward: json["reward"],
      );

  Map<String, dynamic> toJson() => {
        "deposit": deposit,
        "reserveBalance": reserveBalance,
        "tradingTime": tradingTime,
        "reward": reward,
      };
}
