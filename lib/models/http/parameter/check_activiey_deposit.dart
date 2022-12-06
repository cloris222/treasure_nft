// To parse this JSON data, do
//
//     final activityDeposit = activityDepositFromJson(jsonString);

import 'dart:convert';

ActivityDeposit activityDepositFromJson(String str) => ActivityDeposit.fromJson(json.decode(str));

String activityDepositToJson(ActivityDeposit data) => json.encode(data.toJson());

class ActivityDeposit {
  ActivityDeposit({
    required this.deposit,
    required  this.reserveBalance,
    required  this.tradingTime,
    required  this.reward,
  });

  int deposit;
  double reserveBalance;
  int tradingTime;
  double reward;

  factory ActivityDeposit.fromJson(Map<String, dynamic> json) => ActivityDeposit(
    deposit: json["deposit"],
    reserveBalance: json["reserveBalance"].toDouble(),
    tradingTime: json["tradingTime"],
    reward: json["reward"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "deposit": deposit,
    "reserveBalance": reserveBalance,
    "tradingTime": tradingTime,
    "reward": reward,
  };
}
