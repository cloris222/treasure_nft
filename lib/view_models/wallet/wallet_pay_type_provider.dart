import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_aisle_provider.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_fiat_currency_provider.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_fiat_deposit_viewmodel.dart';
import 'package:treasure_nft_project/views/wallet/data/pay_type_data.dart';
import '../../utils/app_shared_Preferences.dart';
import '../base_pref_provider.dart';


final payTypeCurrentIndexProvider = StateProvider.autoDispose<int?>((ref) {
  return null;
});

final currentPayTypeProvider = StateProvider<PayTypeData>((ref) {
  return PayTypeData();
});

final walletPayTypeProvider =
StateNotifierProvider<WalletPayTypeNotifier, List<PayTypeData>>((ref) {
  return WalletPayTypeNotifier();
});

class WalletPayTypeNotifier extends StateNotifier<List<PayTypeData>>
    with BasePrefProvider {
  WalletPayTypeNotifier() : super([]);

  WidgetRef? ref;
  WalletFiatDepositViewModel? viewModel;

  @override
  Future<void> initProvider() async {
    state = [];
  }

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    // state = [PayTypeData(type: tr("searching"))];
    ref!.read(payTypeCurrentIndexProvider.notifier).update((state) => 0);
    await WalletAPI(onConnectFail: onConnectFail)
        .getPayType(ref!.read(currentFiatProvider))
        .then((value) => {
      ref!.read(currentPayTypeProvider.notifier).state = value[0],
      ref!.read(payTypeCurrentIndexProvider.notifier).update((state) => 0),
      state = value,
      viewModel!.onTextChange()
    });
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state =  [
        ...List<PayTypeData>.from(
            json.map((x) => PayTypeData.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "walletPayType";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(), state);
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  setRefAndVM(WidgetRef ref, WalletFiatDepositViewModel viewModel){
    this.ref = ref;
    this.viewModel = viewModel;
  }
}
