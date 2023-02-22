import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/home_api.dart';
import '../../../models/http/parameter/home_carousel.dart';
import '../../base_pref_provider.dart';

final homeCarouselListProvider =
    StateNotifierProvider<HomeCarouselListNotifier, List<HomeCarousel>>((ref) {
  return HomeCarouselListNotifier();
});

class HomeCarouselListNotifier extends StateNotifier<List<HomeCarousel>>
    with BasePrefProvider {
  HomeCarouselListNotifier() : super([]);

  @override
  Future<void> initProvider() async {
  }

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = [...await HomeAPI(onConnectFail: onConnectFail).getCarouselItem()];
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...List<HomeCarousel>.from(json.map((x) => HomeCarousel.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "homeCarousel2";
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
