import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/http/api/home_api.dart';
import 'package:treasure_nft_project/models/http/parameter/trading_volume_data.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/parameter/home_film_data.dart';
import '../../base_pref_provider.dart';


///MARK: 首頁影片資訊
final homeFilmProvider =
StateNotifierProvider<HomeFilmNotifier, List<HomeFilmData>>((ref) {
  return HomeFilmNotifier();
});


class HomeFilmNotifier extends StateNotifier<List<HomeFilmData>>
    with BasePrefProvider {
  HomeFilmNotifier() : super([]);

  @override
  Future<void> initProvider() async{
  }

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = [...await HomeAPI(onConnectFail: onConnectFail).getFilm()];
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    AppSharedPreferences.setJson(getSharedPreferencesKey(), List<dynamic>.from(state.map((x)=>x.toJson())));
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = [
        ...state = List<HomeFilmData>.from(
          json.map((x)=> HomeFilmData.fromJson(x))
        )
      ];
    }
  }

  @override
  String setKey() {
    return "homeFilm";
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
