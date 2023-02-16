import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/provider/base_pref_provider.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';

import '../../http/api/home_api.dart';
import '../../http/parameter/home_carousel.dart';

final homeCarouselListProvider =
    StateNotifierProvider<HomeCarouselListNotifier, List<HomeCarousel>>((ref) {
  return HomeCarouselListNotifier();
});

class HomeCarouselListNotifier extends StateNotifier<List<HomeCarousel>>
    with BasePrefProvider {
  HomeCarouselListNotifier() : super([]);

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue() async {
    state = await HomeAPI().getCarouselItem();
    AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())));
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state =
          List<HomeCarousel>.from(json.map((x) => HomeCarousel.fromJson(x)));
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
