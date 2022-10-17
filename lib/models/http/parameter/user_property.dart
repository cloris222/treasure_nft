// To parse this JSON data, do
//
//     final userProperty = userPropertyFromJson(jsonString);

import 'dart:convert';

UserProperty userPropertyFromJson(String str) =>
    UserProperty.fromJson(json.decode(str));

String userPropertyToJson(UserProperty data) => json.encode(data.toJson());

class UserProperty {
  UserProperty({
    required this.income,
    required this.withdraw,
    required this.balance,
    required this.savingBalance,
  });

  double income;
  double withdraw;
  double balance;
  double savingBalance;

  factory UserProperty.fromJson(Map<String, dynamic> json) => UserProperty(
        income: json["income"].toDouble(),
        withdraw: json["withdraw"].toDouble(),
        balance: json["balance"].toDouble(),
        savingBalance: json["savingBalance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "income": income,
        "withdraw": withdraw,
        "balance": balance,
        "savingBalance": savingBalance,
      };
}
