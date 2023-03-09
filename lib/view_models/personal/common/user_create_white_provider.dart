import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/mine_api.dart';
import '../../../utils/app_shared_Preferences.dart';

final userCreateWhiteProvider = StateNotifierProvider.autoDispose<UserCreateWhiteNotifier,bool >((ref) {
    return UserCreateWhiteNotifier();
});

class UserCreateWhiteNotifier extends StateNotifier<bool> with BasePrefProvider{
  UserCreateWhiteNotifier() : super(false);

  @override
  Future<void> initProvider() async{
    state =false;
  }

  @override
  Future<void> initValue() async{
    state =false;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async{
    state =await MineAPI().getWhiteList();
  }

  @override
  Future<void> readSharedPreferencesValue() async{
    state = await AppSharedPreferences.getBool(getSharedPreferencesKey());
  }

  @override
  String setKey() {
   return "userCreateWhite";
  }

  @override
  Future<void> setSharedPreferencesValue()async{
    await AppSharedPreferences.setBool(getSharedPreferencesKey(), state);
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }


}