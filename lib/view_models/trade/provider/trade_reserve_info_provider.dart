import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/admin_api.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/utils/trade_timer_util.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/parameter/check_reservation_info.dart';
import '../../../utils/app_shared_Preferences.dart';

/// division index for dropdownButton use
final tradeCurrentDivisionIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

/// range index for dropdownButton use
final tradeCurrentRangeIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

///MARK: 查詢區間的預約資訊
final tradeReserveInfoProvider = StateNotifierProvider<TradeReserveInfoNotifier, CheckReservationInfo?>((ref) {
  return TradeReserveInfoNotifier();
});

final beginAmount = StateProvider<String>((ref) {
  return "";
});

class TradeReserveInfoNotifier extends StateNotifier<CheckReservationInfo?> with BasePrefProvider {
  TradeReserveInfoNotifier() : super(null);
  int currentDivision = 0;
  int? currentState;
  String? reserveDate;

  void setCurrentChoose(int currentDivision, int? currentState, String? reserveDate) {
    this.currentDivision = currentDivision;
    this.currentState = currentState;
    this.reserveDate = reserveDate;
  }

  @override
  Future<void> initProvider() async {
    state = null;
  }

  @override
  Future<void> initValue() async {
    state = await _getCommInfo(currentDivision);
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await TradeAPI(onConnectFail: onConnectFail)
        .getCheckReservationInfoAPI(currentDivision, reserveStage: currentState, reserveDate: reserveDate);
    await _saveCommInfo(currentDivision, state);

    ///MARK: 更新交易資料時間
    TradeTimerUtil().start(setInfo: state);
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = CheckReservationInfo.fromJson(json);
      await _saveCommInfo(currentDivision, CheckReservationInfo.fromJson(json));
    }
  }

  ///MARK: 存共用的參數
  Future<void> _saveCommInfo(int currentDivision, CheckReservationInfo? state) async {
    ///MARK:先存
    if (state != null) {
      await AppSharedPreferences.setJson("tradeReserveInfo_common_$currentDivision", state.toJson());
    }

    ///MARK: 後讀 (避免改到provider的值)
    CheckReservationInfo? info = await _getCommInfo(currentDivision);
    if (info != null) {
      for (int i = 0; i < info.reserveRanges.length; i++) {
        info.reserveRanges[i].lock = true;
      }

      ///MARK:再存
      await AppSharedPreferences.setJson("tradeReserveInfo_common_$currentDivision", info.toJson());
    }
  }

  ///MARK: 讀取共用的參數
  Future<CheckReservationInfo?> _getCommInfo(int currentDivision) async {
    var json = await AppSharedPreferences.getJson("tradeReserveInfo_common_$currentDivision");
    if (json != null) {
      return CheckReservationInfo.fromJson(json);
    }
    return null;
  }

  ///MARK: 此處必須和 trade_reserve_stage_provider.dart的_clearReserveInfo一致
  @override
  String setKey() {
    return format('tradeReserveInfo_user_{reserveDate}_{currentState}_{currentDivision}',
        {"reserveDate": reserveDate, "currentState": currentState, "currentDivision": currentDivision});
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state != null) {
      AppSharedPreferences.setJson(getSharedPreferencesKey(), state!.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  Future getBeginerHintNum() async {
    var json = await AdminAPI().getBeginerHint();
    String value = json.data["depositAmount"].toString();
    return value;
  }
}
