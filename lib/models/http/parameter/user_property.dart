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
    required this.todayIncome,
    required this.spreadSavingsTotal,
    required this.tradeSavingsTotal,
  });

  /// 總收益
  num income;

  /// 已提領
  num withdraw;

  /// 錢包餘額(未提取)
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

  /// 工單691增加 體驗金
  num experienceMoney;

  /// 工單799增加 每日收益
  num todayIncome;

  /// 工單812增加 推廣儲金罐總額
  num spreadSavingsTotal;

  /// 工單812增加 交易儲金罐總額
  num tradeSavingsTotal;


  factory UserProperty.fromJson(Map<String, dynamic> json) => UserProperty(
        income: json["income"] ?? 0,
        withdraw: json["withdraw"] ?? 0,
        balance: json["balance"] ?? 0,
        savingBalance: json["savingBalance"] ?? 0,
        nftBalance: json["nftBalance"] ?? 0,
        totalBalance: json["totalBalance"] ?? 0,
        tradingSavingBalance: json["tradingSavingBalance"] ?? 0,
        experienceMoney: json["experienceMoney"] ?? 0,
        todayIncome: json["todayIncome"] ?? 0,
        spreadSavingsTotal: json["spreadSavingsTotal"] ?? 0,
        tradeSavingsTotal: json["tradeSavingsTotal"] ?? 0,
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
        "todayIncome": todayIncome,
        "spreadSavingsTotal": spreadSavingsTotal,
        "tradeSavingsTotal": tradeSavingsTotal,
      };

  num _checkMoney(num check) {
    if (check < 0) {
      return 0;
    }
    return check;
  }

  ///MARK: 加上體驗金
  num getWalletAccount() {
    num money = balance + experienceMoney;
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

  num getTodayIncome()=>_checkMoney(todayIncome);

  num getSpreadSavingsTotal()=>_checkMoney(spreadSavingsTotal);

  num getTradeSavingsTotal()=>_checkMoney(tradeSavingsTotal);
}
