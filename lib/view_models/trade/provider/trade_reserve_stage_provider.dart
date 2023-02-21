import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/trade_api.dart';
import '../../../models/http/parameter/trade_reserve_stage__info.dart';
import '../../../utils/app_shared_Preferences.dart';
import '../../../utils/date_format_util.dart';

///MARK: 目前交易場次
final tradeCurrentStageProvider = StateProvider<int?>((ref) {
  return null;
});

///MARK: 交易場次
final tradeReserveStageProvider = StateNotifierProvider<
    TradeReserveStageNotifier, List<TradeReserveStageInfo>>((ref) {
  return TradeReserveStageNotifier();
});

class TradeReserveStageNotifier
    extends StateNotifier<List<TradeReserveStageInfo>> with BasePrefProvider {
  TradeReserveStageNotifier() : super([]);

  @override
  Future<void> initProvider() async {
    state = [];
  }

  @override
  Future<void> initValue() async {}

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    List<TradeReserveStageInfo> list =
        await TradeAPI(onConnectFail: onConnectFail).getTradeCanReserveStage();
    if (list.isNotEmpty) {
      state = [...list];
      _clearExpiredReserveInfo(state);
    }
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<TradeReserveStageInfo>.from(
            json.map((x) => TradeReserveStageInfo.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "tradeTradeReserveStage";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  ///MARK: 此處必須和 trade_reserve_info_provider.dart的setKey一致
  Future<void> _clearExpiredReserveInfo(
      List<TradeReserveStageInfo> state) async {
    List<String> todayState = List<String>.generate(state.length, (index) {
      return format('tradeReserveInfo_user_{reserveDate}_{currentState}', {
        "reserveDate":
            DateFormatUtil().getTimeWithDayFormat(time: state[index].startTime),
        "currentState": state[index].stage,
      });
    });
    if (todayState.isNotEmpty) {
      await AppSharedPreferences.clearExpiredReserveInfo(todayState);
    }
  }
}
