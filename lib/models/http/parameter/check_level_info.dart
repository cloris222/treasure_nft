// To parse this JSON data, do
//
//     final checkLevelInfo = checkLevelInfoFromJson(jsonString);

import 'dart:convert';

CheckLevelInfo checkLevelInfoFromJson(String str) =>
    CheckLevelInfo.fromJson(json.decode(str));

String checkLevelInfoToJson(CheckLevelInfo data) => json.encode(data.toJson());

class CheckLevelInfo {
  CheckLevelInfo({
    required this.userLevel,
    required this.point,
    required this.pointRequired,
    required this.dailyReverseAmount,
    required this.dailyRCouponAmount,
    required this.buyRangeStart,
    required this.buyRangeEnd,
    required this.couponRate,
    required this.directShare,
    required this.directSave,
    required this.indirectShare,
    required this.indirectSave,
    required this.thirdShare,
    required this.thirdSave,
    required this.activeDirect,
    required this.activeIndirect,
    required this.activeDirectRequired,
    required this.activeIndirectRequired,
    required this.tradeSuccess,
    required this.depositAmount,
    required this.tradeSuccessRequired,
    required this.depositAmountRequired,
    required this.nextDailyReverseAmount,
    required this.nextDailyRCouponAmount,
    required this.nextBuyRangeStart,
    required this.nextBuyRangeEnd,
    required this.nextCouponRate,
    required this.nextDirectShare,
    required this.nextDirectSave,
    required this.nextIndirectShare,
    required this.nextIndirectSave,
    required this.nextThirdShare,
    required this.nextThirdSave,
    required this.income,
    required this.feeRate,
    required this.directRecommend,
    required this.secondRecommend,
    required this.thirdRecommend,
  });

  int userLevel;
  int point;
  int pointRequired;
  int dailyReverseAmount;
  int dailyRCouponAmount;
  int buyRangeStart;
  int buyRangeEnd;
  double couponRate;
  double directShare;
  double directSave;
  double indirectShare;
  double indirectSave;
  double thirdShare;
  double thirdSave;

  ///MARK: 邀請A級有效 等級1以上
  int activeDirect;

  ///MARK: 邀請A+B+C級有效 等級1以上
  int activeIndirect;

  ///MARK: 邀請A級有效 需求 等級1以上
  int activeDirectRequired;

  ///MARK: 邀請A+B+C級有效 需求 等級1以上
  int activeIndirectRequired;

  ///MARK: 交易成功次數 等級0才有
  int tradeSuccess;

  ///MARK: 充值金額 等級0才有
  double depositAmount;

  ///MARK: 交易成功次數 需求 等級0才有
  int tradeSuccessRequired;

  ///MARK: 充值金額 需求 等級0才有
  int depositAmountRequired;

  int nextDailyReverseAmount;
  int nextDailyRCouponAmount;
  int nextBuyRangeStart;
  int nextBuyRangeEnd;
  int nextCouponRate;
  double nextDirectShare;
  double nextDirectSave;
  double nextIndirectShare;
  double nextIndirectSave;
  double nextThirdShare;
  double nextThirdSave;
  double income;
  double feeRate;
  double directRecommend;
  double secondRecommend;
  double thirdRecommend;

  factory CheckLevelInfo.fromJson(Map<String, dynamic> json) => CheckLevelInfo(
        userLevel: json["userLevel"],
        point: json["point"],
        pointRequired: json["pointRequired"],
        dailyReverseAmount: json["dailyReverseAmount"],
        dailyRCouponAmount: json["dailyRCouponAmount"],
        buyRangeStart: json["buyRangeStart"],
        buyRangeEnd: json["buyRangeEnd"],
        couponRate: json["couponRate"].toDouble(),
        directShare: json["directShare"].toDouble(),
        directSave: json["directSave"].toDouble(),
        indirectShare: json["indirectShare"].toDouble(),
        indirectSave: json["indirectSave"].toDouble(),
        thirdShare: json["thirdShare"].toDouble(),
        thirdSave: json["thirdSave"].toDouble(),
        activeDirect: json["activeDirect"] ?? 0,
        activeIndirect: json["activeIndirect"] ?? 0,
        activeDirectRequired: json["activeDirectRequired"] ?? 0,
        activeIndirectRequired: json["activeIndirectRequired"] ?? 0,
        tradeSuccess: json["tradeSuccess"] ?? 0,
        depositAmount: json["depositAmount"] != null
            ? json["depositAmount"].toDouble()
            : 0.0,
        tradeSuccessRequired: json["tradeSuccessRequired"] ?? 0,
        depositAmountRequired: json["depositAmountRequired"] ?? 0,
        nextDailyReverseAmount: json["nextDailyReverseAmount"] ?? 0,
        nextDailyRCouponAmount: json["nextDailyRCouponAmount"] ?? 0,
        nextBuyRangeStart: json["nextBuyRangeStart"],
        nextBuyRangeEnd: json["nextBuyRangeEnd"],
        nextCouponRate: json["nextCouponRate"],
        nextDirectShare: json["nextDirectShare"].toDouble(),
        nextDirectSave: json["nextDirectSave"].toDouble(),
        nextIndirectShare: json["nextIndirectShare"].toDouble(),
        nextIndirectSave: json["nextIndirectSave"].toDouble(),
        nextThirdShare: json["nextThirdShare"].toDouble(),
        nextThirdSave: json["nextThirdSave"].toDouble(),
        income: json["income"].toDouble(),
        feeRate: json["feeRate"].toDouble(),
        directRecommend: json["directRecommend"].toDouble(),
        secondRecommend: json["secondRecommend"].toDouble(),
        thirdRecommend: json["thirdRecommend"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "userLevel": userLevel,
        "point": point,
        "pointRequired": pointRequired,
        "dailyReverseAmount": dailyReverseAmount,
        "dailyRCouponAmount": dailyRCouponAmount,
        "buyRangeStart": buyRangeStart,
        "buyRangeEnd": buyRangeEnd,
        "couponRate": couponRate,
        "directShare": directShare,
        "directSave": directSave,
        "indirectShare": indirectShare,
        "indirectSave": indirectSave,
        "thirdShare": thirdShare,
        "thirdSave": thirdSave,
        "activeDirect": activeDirect,
        "activeIndirect": activeIndirect,
        "activeDirectRequired": activeDirectRequired,
        "activeIndirectRequired": activeIndirectRequired,
        "tradeSuccess": tradeSuccess,
        "depositAmount": depositAmount,
        "tradeSuccessRequired": tradeSuccessRequired,
        "depositAmountRequired": depositAmountRequired,
        "nextDailyReverseAmount": nextDailyReverseAmount,
        "nextDailyRCouponAmount": nextDailyRCouponAmount,
        "nextBuyRangeStart": nextBuyRangeStart,
        "nextBuyRangeEnd": nextBuyRangeEnd,
        "nextCouponRate": nextCouponRate,
        "nextDirectShare": nextDirectShare,
        "nextDirectSave": nextDirectSave,
        "nextIndirectShare": nextIndirectShare,
        "nextIndirectSave": nextIndirectSave,
        "nextThirdShare": nextThirdShare,
        "nextThirdSave": nextThirdSave,
        "income": income,
        "feeRate": feeRate,
        "directRecommend": directRecommend,
        "secondRecommend": secondRecommend,
        "thirdRecommend": thirdRecommend,
      };
}
