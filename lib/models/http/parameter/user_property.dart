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
    required this.nftBalance,
    required this.totalBalance,
    required this.tradingSavingBalance,
    required this.experienceMoney,
  });

  num income;
  num withdraw;
  num balance;

  /// 儲金罐餘額
  num savingBalance;

  ///MARK: 2022/11/01新增
  /// nft資產
  num nftBalance;

  /// 總資產
  num totalBalance;

  /// 交易儲金罐餘額
  num tradingSavingBalance;

  /// 工單691 增加體驗金
  num experienceMoney;

  factory UserProperty.fromJson(Map<String, dynamic> json) => UserProperty(
        income: json["income"] ?? 0,
        withdraw: json["withdraw"] ?? 0,
        balance: json["balance"] ?? 0,
        savingBalance: json["savingBalance"] ?? 0,
        nftBalance: json["nftBalance"] ?? 0,
        totalBalance: json["totalBalance"] ?? 0,
        tradingSavingBalance: json["tradingSavingBalance"] ?? 0,
        experienceMoney: json["experienceMoney"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "income": income,
        "withdraw": withdraw,
        "balance": balance,
        "savingBalance": savingBalance,
        "nftBalance": nftBalance,
        "totalBalance": totalBalance,
        "tradingSavingBalance": tradingSavingBalance,
        "experienceMoney": experienceMoney,
      };

  num _checkMoney(num check) {
    if (check < 0) {
      return 0;
    }
    return check;
  }

  ///MARK: 扣除體驗金
  num getWalletAccount() {
    num money = balance - experienceMoney;
    return _checkMoney(money);
  }

  num getIncome() => _checkMoney(income);

  num getWithdraw() => _checkMoney(withdraw);

  num getExperienceMoney() => _checkMoney(experienceMoney);

  num getSavingBalance() => _checkMoney(savingBalance);

  num getBalance() => _checkMoney(balance);

  num getNftBalance() => _checkMoney(nftBalance);

  num getTotalBalance() => _checkMoney(totalBalance);

  num getTradingSavingBalance()=>_checkMoney(tradingSavingBalance);
}
