// To parse this JSON data, do
//
//     final blacklistConfigData = blacklistConfigDataFromJson(jsonString);

import 'dart:convert';

BlacklistConfigData blacklistConfigDataFromJson(String str) => BlacklistConfigData.fromJson(json.decode(str));

String blacklistConfigDataToJson(BlacklistConfigData data) => json.encode(data.toJson());

class BlacklistConfigData {
  int unableTrade;
  int unableTradeAfterUnlock;
  int unableLogin;
  int unableWithdrawByPassword;
  int unableWithdrawByGoogle;
  int unableWithdrawByEmail;

  BlacklistConfigData({
    this.unableTrade = 0,
    this.unableTradeAfterUnlock = 0,
    this.unableLogin = 0,
    this.unableWithdrawByPassword = 0,
    this.unableWithdrawByGoogle = 0,
    this.unableWithdrawByEmail = 0,
  });

  factory BlacklistConfigData.fromJson(Map<String, dynamic> json) => BlacklistConfigData(
    unableTrade: json["unableTrade"]??0,
    unableTradeAfterUnlock: json["unableTradeAfterUnlock"]??0,
    unableLogin: json["unableLogin"]??0,
    unableWithdrawByPassword: json["unableWithdrawByPassword"]??0,
    unableWithdrawByGoogle: json["unableWithdrawByGoogle"]??0,
    unableWithdrawByEmail: json["unableWithdrawByEmail"]??0,
  );

  Map<String, dynamic> toJson() => {
    "unableTrade": unableTrade,
    "unableTradeAfterUnlock": unableTradeAfterUnlock,
    "unableLogin": unableLogin,
    "unableWithdrawByPassword": unableWithdrawByPassword,
    "unableWithdrawByGoogle": unableWithdrawByGoogle,
    "unableWithdrawByEmail": unableWithdrawByEmail,
  };
}
