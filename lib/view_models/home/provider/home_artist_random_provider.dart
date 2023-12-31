import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/home_api.dart';
import '../../../models/http/parameter/home_artist_record.dart';
import '../../../utils/app_shared_Preferences.dart';
import '../../base_pref_provider.dart';

///MARK: 隨機畫家畫廊
final homeArtistRandomProvider =
    StateNotifierProvider<HomeArtistRandomNotifier, ArtistRecord?>((ref) {
  return HomeArtistRandomNotifier();
});

class HomeArtistRandomNotifier extends StateNotifier<ArtistRecord?>
    with BasePrefProvider {
  HomeArtistRandomNotifier() : super(null);
  @override
  Future<void> initProvider() async{
  }
  @override
  Future<void> initValue() async {
    state = null;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    List<ArtistRecord> records = await HomeAPI(onConnectFail: onConnectFail).getArtistRecord();
    if (records.isNotEmpty) {
      state = records[Random().nextInt(records.length)];
    }
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = ArtistRecord.fromJson(json);
    } else {
      state = null;
    }
  }

  @override
  String setKey() {
    return "homeRandomArt";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state != null) {
      AppSharedPreferences.setJson(getSharedPreferencesKey(), state!.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
