import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/trading_volume_data.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';

import '../../base_pref_provider.dart';


///MARK: 首頁 USDT 資訊
final homeUSDTProvider =
    StateNotifierProvider<HomeUSDTNotifier, TradingVolumeData>((ref) {
  return HomeUSDTNotifier();
});

class HomeUSDTNotifier extends StateNotifier<TradingVolumeData>
    with BasePrefProvider {
  HomeUSDTNotifier()
      : super(TradingVolumeData(transactionAmount: '0', cost: '0', nfts: '0'));

  @override
  String setKey() {
    return "homeUSDT";
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }

  @override
  Future<void> initValue() async {
    state = TradingVolumeData(transactionAmount: "0", cost: "0", nfts: "0");
  }

  @override
  Future<void> readAPIValue() async {
    state = await HomeAPI().getTradingVolume();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = TradingVolumeData.fromJson(json);
    }
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(), state.toJson());
  }
}
