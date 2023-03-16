import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/order_api.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../constant/enum/setting_enum.dart';

final orderDetailIncomeProvider =
    StateNotifierProvider.autoDispose<OrderDetailIncomeNotifier, double>((ref) {
  return OrderDetailIncomeNotifier();
});

class OrderDetailIncomeNotifier extends StateNotifier<double>
    with BasePrefProvider {
  OrderDetailIncomeNotifier() : super(0);
  EarningIncomeType type = EarningIncomeType.ALL;
  String startDate = '';
  String endDate = '';

  @override
  Future<void> initProvider() async {
    ///MARK:初始化參數
    type = EarningIncomeType.ALL;
    startDate = '';
    endDate = '';
    state = 0;
  }

  @override
  Future<void> initValue() async {
    state = 0;
  }

  void setParam(
      {required EarningIncomeType type,
      required String startDate,
      required String endDate}) {
    this.type = type;
    this.startDate = startDate;
    this.endDate = endDate;
    update();
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await OrderAPI()
        .getPersonalIncome(type: type, startDate: startDate, endDate: endDate);
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    state = await AppSharedPreferences.getDouble(getSharedPreferencesKey());
  }

  @override
  String setKey() {
    return "orderDetailIncome_${type.name}";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (startDate.isEmpty && endDate.isEmpty) {
      await AppSharedPreferences.setDouble(getSharedPreferencesKey(), state);
    }
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
