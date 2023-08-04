import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_fiat_deposit_viewmodel.dart';
import 'package:treasure_nft_project/view_models/wallet/wallet_pay_type_provider.dart';
import 'package:treasure_nft_project/views/wallet/data/aisle_type_data.dart';
import '../../models/http/api/wallet_api.dart';
import '../../utils/app_shared_Preferences.dart';
import 'wallet_fiat_currency_provider.dart';

final aisleCurrentIndexProvider = StateProvider.autoDispose<int?>((ref){
  return null;
});

final currentAisleProvider = StateProvider<AisleTypeData>((ref){
  return AisleTypeData();
});

final walletAisleTypeProvider =
    StateNotifierProvider<WalletAisleTypeNotifier, List<AisleTypeData>>((ref){
      return WalletAisleTypeNotifier();
    });

class WalletAisleTypeNotifier extends StateNotifier<List<AisleTypeData>> with BasePrefProvider{
  WalletAisleTypeNotifier() : super([]);
  WidgetRef? ref;
  WalletFiatDepositViewModel? viewModel;

  @override
  Future<void> initProvider() async{
    state = [];
  }

  @override
  Future<void> initValue() async{
    state = [];
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async{
    ref!.read(aisleCurrentIndexProvider.notifier).update((state) => 0);
    await WalletAPI(onConnectFail: onConnectFail).getAisleType(
      ref!.watch(currentFiatProvider), ref!.watch(currentPayTypeProvider).type)
      .then((value){
        if(value.isNotEmpty){
          ref!.read(currentAisleProvider.notifier).state = value[0];
          ref!.read(aisleCurrentIndexProvider.notifier).update((state) => 0);
          state = value;
        }else{
          state = [AisleTypeData(route: tr("rechargeMaintain"))];
        }
        viewModel!.onTextChange();
    });
  }


  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state =  [
        ...List<AisleTypeData>.from(
            json.map((x) => AisleTypeData.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "walletAisleType";
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