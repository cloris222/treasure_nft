
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/call_back_function.dart';
import '../../models/http/api/announce_api.dart';
import '../../models/http/parameter/announce_data.dart';
import '../../utils/app_shared_Preferences.dart';
import '../base_pref_provider.dart';


final announceTagProvider =
StateNotifierProvider<AnnounceTagNotifier, List<AnnounceTagData>>((ref) {
return AnnounceTagNotifier();
});

class AnnounceTagNotifier extends StateNotifier<List<AnnounceTagData>>
    with BasePrefProvider {
  AnnounceTagNotifier() : super([]);

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
    state = await AnnounceAPI(onConnectFail: onConnectFail).getAnnounceTag();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = List<AnnounceTagData>.from(
            json.map((x) => AnnounceTagData.fromJson(x)));
    }
  }

  @override
  String setKey() {
    return "announceTag";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    if (state != null) {
      await AppSharedPreferences.setJson(getSharedPreferencesKey(), state);
    }
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
