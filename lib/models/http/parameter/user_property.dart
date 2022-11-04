// To parse this JSON data, do
//
//     final userProperty = userPropertyFromJson(jsonString);

import 'dart:convert';

UserProperty userPropertyFromJson(String str) =>
    UserProperty.fromJson(json.decode(str));

String userPropertyToJson(UserProperty data) => json.encode(data.toJson());

class UserProperty {
  UserProperty(
      {required this.income,
      required this.withdraw,
      required this.balance,
      required this.savingBalance,
      required this.nftBalance,
      required this.totalBalance,
      required this.tradingSavingBalance});

  double income;
  double withdraw;
  double balance;

  /// 儲金罐餘額
  double savingBalance;

  ///MARK: 2022/11/01新增
  /// nft資產
  double nftBalance;

  /// 總資產
  double totalBalance;

  /// 交易儲金罐餘額
  double tradingSavingBalance;

  factory UserProperty.fromJson(Map<String, dynamic> json) => UserProperty(
        income: json["income"].toDouble(),
        withdraw: json["withdraw"].toDouble(),
        balance: json["balance"].toDouble(),
        savingBalance: json["savingBalance"].toDouble(),
        nftBalance: json["nftBalance"].toDouble(),
        totalBalance: json["totalBalance"].toDouble(),
        tradingSavingBalance: json["tradingSavingBalance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "income": income,
        "withdraw": withdraw,
        "balance": balance,
        "savingBalance": savingBalance,
        "nftBalance": nftBalance,
        "totalBalance": totalBalance,
        "tradingSavingBalance": tradingSavingBalance,
      };
}
