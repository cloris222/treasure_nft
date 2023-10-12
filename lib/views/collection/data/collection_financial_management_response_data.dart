// To parse this JSON data, do
//
//     final collectionTicketResponseData = collectionTicketResponseDataFromJson(jsonString);

import 'dart:convert';

CollectionFinancialManagementResponseData collectionFinancialManagementResponseDataFromJson(String str) => CollectionFinancialManagementResponseData.fromJson(json.decode(str));

String collectionFinancialManagementResponseDataToJson(CollectionFinancialManagementResponseData data) => json.encode(data.toJson());

class CollectionFinancialManagementResponseData {
  CollectionFinancialManagementResponseData({
    this.minRank = 0,
    this.maxRank = 0,
    this.dayCircle = 0,
    this.type = FinancialManagementType.normal,
    this.note = '',
    this.minInMoney = 0,
    this.maxInMoney = 0,
    this.dayIncome = 0,
    this.imgUrl = ''
  });

  num minRank; // 參與等級
  num maxRank;  // 參與等級
  num dayCircle;  // ？天定投
  FinancialManagementType type;  // 方案類型
  String note; // 備註 35天限制參與一次
  num minInMoney; // 數量（最小）
  num maxInMoney; // 數量（最大）
  num dayIncome; // 日收益
  String imgUrl; // 圖片


  factory CollectionFinancialManagementResponseData.fromJson(Map<String, dynamic> json) => CollectionFinancialManagementResponseData(
    minRank: json["minRank"]??0,
    maxRank: json["maxRank"]??0,
    dayCircle: json["dayCircle"]??0,
    type: json["type"]??FinancialManagementType.normal,
    note: json["note"]??'',
    minInMoney: json["minInMoney"]??0,
    maxInMoney: json["maxInMoney"]??0,
    dayIncome: json["dayIncome"]??0,
    imgUrl: json["imgUrl"]??'',
  );

  Map<String, dynamic> toJson() => {
    "minRank": minRank,
    "maxRank": maxRank,
    "dayCircle": dayCircle,
    "type": type,
    "note": note,
    "minInMoney": minInMoney,
    "maxInMoney": maxInMoney,
    "dayIncome": dayIncome,
    "imgUrl": imgUrl,
  };
}

enum FinancialManagementType {

  ///普通型
  normal,

  ///創業型
  startUp,

  ///升值型
  appreciation,

  ///經濟型
  economy,

  ///上市型
  listed,
}
