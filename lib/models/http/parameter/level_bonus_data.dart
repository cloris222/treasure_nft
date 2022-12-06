// To parse this JSON data, do
//
//     final levelBonusData = levelBonusDataFromJson(jsonString);

import 'dart:convert';

LevelBonusData levelBonusDataFromJson(String str) =>
    LevelBonusData.fromJson(json.decode(str));

String levelBonusDataToJson(LevelBonusData data) => json.encode(data.toJson());

/// MARK: 取得bonus
class LevelBonusData {
  LevelBonusData({
    required this.userLevel,
    required this.nextLevel,
    required this.nextLevelBonus,
    required this.nextLevelBonusPct,
    required this.maxLevel,
    required this.bonus,
    required this.tradeBonus,
    required this.nextLevelTradeBonus,
    required this.nextLevelTradeBonusPct,
    required this.moneyBoxExpireTime,
    this.moneyBoxExpireDate,
    required this.tradeMoneyBoxExpireTime,
    this.tradeMoneyBoxExpireDate,
  });

  int userLevel;

  ///MARK: 下一等級 使用者為最大等級時 為null
  int nextLevel;

  ///MARK: 下一等級儲金罐返還 使用者為最大等級時 為0
  double nextLevelBonus;

  ///MARK: 下一等級儲金罐返還%數 百分比，使用者為最大等級時 為0
  int nextLevelBonusPct;

  ///MARK: 最大等級
  int maxLevel;

  ///MARK: 獎勵 使用者為最大等級時 為0
  double bonus;

  ///MARK: 最大交易儲金罐獎勵
  double tradeBonus;

  ///MARK: 下一等級交易儲金罐返還
  double nextLevelTradeBonus;

  ///MARK: 下一等級交易儲金罐返還%數
  int nextLevelTradeBonusPct;

  ///MARK: 儲金罐過期時間
  int moneyBoxExpireTime;

  ///MARK: 儲金罐過期日
  String? moneyBoxExpireDate;

  ///MARK: 交易儲金罐過期時間
  int tradeMoneyBoxExpireTime;

  ///MARK: 交易儲金罐過期日
  String? tradeMoneyBoxExpireDate;

  factory LevelBonusData.fromJson(Map<String, dynamic> json) => LevelBonusData(
        userLevel: json["userLevel"],
        nextLevel: json["nextLevel"],
        nextLevelBonus: json["nextLevelBonus"].toDouble(),
        nextLevelBonusPct: json["nextLevelBonusPCT"],
        maxLevel: json["maxLevel"],
        bonus: json["bonus"].toDouble(),
        tradeBonus: json["tradeBonus"].toDouble(),
        nextLevelTradeBonus: json["nextLevelTradeBonus"].toDouble(),
        nextLevelTradeBonusPct: json["nextLevelTradeBonusPCT"],
        moneyBoxExpireTime: json["moneyBoxExpireTime"] ?? 0,
        moneyBoxExpireDate: json["moneyBoxExpireDate"] ?? '',
        tradeMoneyBoxExpireTime: json["tradeMoneyBoxExpireTime"] ?? 0,
        tradeMoneyBoxExpireDate: json["tradeMoneyBoxExpireDate"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userLevel": userLevel,
        "nextLevel": nextLevel,
        "nextLevelBonus": nextLevelBonus,
        "nextLevelBonusPCT": nextLevelBonusPct,
        "maxLevel": maxLevel,
        "bonus": bonus,
        "tradeBonus": tradeBonus,
        "nextLevelTradeBonus": nextLevelTradeBonus,
        "nextLevelTradeBonusPCT": nextLevelTradeBonusPct,
        "moneyBoxExpireTime": moneyBoxExpireTime,
        "moneyBoxExpireDate": moneyBoxExpireDate,
        "tradeMoneyBoxExpireTime": tradeMoneyBoxExpireTime,
        "tradeMoneyBoxExpireDate": tradeMoneyBoxExpireDate,
      };
}
