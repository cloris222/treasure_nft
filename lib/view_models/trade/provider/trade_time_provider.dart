import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/data/trade_model_data.dart';

///MARK: 交易倒數時間
final tradeTimeProvider =
    StateNotifierProvider<TradeTimeNotifier, TradeData?>((ref) {
  return TradeTimeNotifier();
});

class TradeTimeNotifier extends StateNotifier<TradeData?> {
  TradeTimeNotifier() : super(null);

  void updateTradeTime(TradeData? data) {
    state = data;
  }
}
