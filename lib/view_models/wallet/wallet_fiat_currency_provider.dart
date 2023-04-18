import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';

import '../../constant/enum/coin_enum.dart';
import '../../utils/app_shared_Preferences.dart';
import '../base_pref_provider.dart';


final fiatCurrentIndexProvider = StateProvider.autoDispose<int?>((ref) {
  return null;
});

final currentFiatProvider = StateProvider<String>((ref) {
  return "";
});

final walletFiatTypeProvider =
StateNotifierProvider<WalletFiatTypeNotifier, List<String>>((ref) {
      return WalletFiatTypeNotifier();
});

class WalletFiatTypeNotifier extends StateNotifier<List<String>>
    with BasePrefProvider {
  WalletFiatTypeNotifier() : super([]);

  @override
  Future<void> initProvider() async {
    state = []; //"VND"
  }

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await WalletAPI(onConnectFail: onConnectFail).getFiatCurrency();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [...List<String>.from(json)];
    }
  }

  @override
  String setKey() {
    return "walletFiatType";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(), state);
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
