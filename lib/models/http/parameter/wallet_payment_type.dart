// To parse this JSON data, do
//
//     final walletPaymentType = walletPaymentTypeFromJson(jsonString);

import 'dart:convert';

class WalletPaymentType {

  final String chain;
  final String currency;
  final String poolType;
  /// 支付類型
  final String type;
  /// 限額(起始)
  final num startPrice;
  final num endPrice;
  final num currentRate;

  WalletPaymentType({
    required this.chain,
    required this.currency,
    required this.poolType,
    required this.type,
    required this.startPrice,
    required this.endPrice,
    required this.currentRate,
  });

  WalletPaymentType copyWith({
    String? chain,
    String? currency,
    String? poolType,
    String? type,
    num? startPrice,
    num? endPrice,
    num? currentRate,
  }) =>
      WalletPaymentType(
        chain: chain ?? this.chain,
        currency: currency ?? this.currency,
        poolType: poolType ?? this.poolType,
        type: type ?? this.type,
        startPrice: startPrice ?? this.startPrice,
        endPrice: endPrice ?? this.endPrice,
        currentRate: currentRate ?? this.currentRate,
      );

  factory WalletPaymentType.fromRawJson(String str) =>
      WalletPaymentType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletPaymentType.fromJson(Map<String, dynamic> json) =>
      WalletPaymentType(
        chain: json["chain"] ?? "",
        currency: json["currency"] ?? "",
        poolType: json["poolType"] ?? "",
        type: json["type"] ?? "",
        startPrice: json["startPrice"] ?? 0,
        endPrice: json["endPrice"] ?? 0,
        currentRate: json["currentRate"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "chain": chain,
        "currency": currency,
        "poolType": poolType,
        "type": type,
        "startPrice": startPrice,
        "endPrice": endPrice,
        "currentRate": currentRate,
      };
}
