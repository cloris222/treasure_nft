// To parse this JSON data, do
//
//     final checkLevelInfo = checkLevelInfoFromJson(jsonString);

import 'dart:convert';

ExploreLevelInfoResponseData checkLevelInfoFromJson(String str) =>
    ExploreLevelInfoResponseData.fromJson(json.decode(str));

String checkLevelInfoToJson(ExploreLevelInfoResponseData data) => json.encode(data.toJson());

class ExploreLevelInfoResponseData {
  ExploreLevelInfoResponseData({
    this.userLevel = 0,
    this.point = 0,
    this.pointRequired = 0,
    this.dailyReverseAmount = 0,
    this.dailyRCouponAmount = 0,
    this.buyRangeStart = 0,
    this.buyRangeEnd = 0,
    this.couponRate = 0,
    this.directShare = 0,
    this.directSave = 0,
    this.indirectShare = 0,
    this.indirectSave = 0,
    this.thirdShare = 0,
    this.thirdSave = 0,
    this.activeDirect = 0,
    this.activeIndirect = 0,
    this.activeDirectRequired = 0,
    this.activeIndirectRequired = 0,
    this.tradeSuccess = 0,
    this.depositAmount = 0,
    this.tradeSuccessRequired = 0,
    this.depositAmountRequired = 0,
    this.nextDailyReverseAmount = 0,
    this.nextDailyRCouponAmount = 0,
    this.nextBuyRangeStart = 0,
    this.nextBuyRangeEnd = 0,
    this.nextCouponRate = 0,
    this.nextDirectShare = 0,
    this.nextDirectSave = 0,
    this.nextIndirectShare = 0,
    this.nextIndirectSave = 0,
    this.nextThirdShare = 0,
    this.nextThirdSave = 0,
    this.income = 0,
    this.feeRate = 0,
    this.directRecommend = 0,
    this.secondRecommend = 0,
    this.thirdRecommend = 0,
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

  factory ExploreLevelInfoResponseData.fromJson(Map<String, dynamic> json) => ExploreLevelInfoResponseData(
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
