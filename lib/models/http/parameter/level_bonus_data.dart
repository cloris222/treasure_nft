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

  factory LevelBonusData.fromJson(Map<String, dynamic> json) => LevelBonusData(
        userLevel: json["userLevel"],
        nextLevel: json["nextLevel"],
        nextLevelBonus: json["nextLevelBonus"].toDouble(),
        nextLevelBonusPct: json["nextLevelBonusPCT"],
        maxLevel: json["maxLevel"],
        bonus: json["bonus"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "userLevel": userLevel,
        "nextLevel": nextLevel,
        "nextLevelBonus": nextLevelBonus,
        "nextLevelBonusPCT": nextLevelBonusPct,
        "maxLevel": maxLevel,
        "bonus": bonus,
      };
}
