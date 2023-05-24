import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';
import '../../../models/http/parameter/google_auth_data.dart';
import '../../../utils/app_shared_Preferences.dart';


final googleProcessProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});


final userGoogleAuthProvider =
StateNotifierProvider.autoDispose<UserGoogleAuthNotifier,
    GoogleAuthData>((ref) {
      return UserGoogleAuthNotifier();
    });

class UserGoogleAuthNotifier extends StateNotifier<GoogleAuthData>
    with BasePrefProvider {
  UserGoogleAuthNotifier() : super(GoogleAuthData());

  @override
  Future<void> initProvider() async {
    state = GoogleAuthData();
  }

  @override
  Future<void> initValue() async {
    state = GoogleAuthData();
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await UserInfoAPI(onConnectFail: onConnectFail).getUserGoogleAuth();
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = GoogleAuthData.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "userGoogleAuth";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    await AppSharedPreferences.setJson(
        getSharedPreferencesKey(), state.toJson());
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
