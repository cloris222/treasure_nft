import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';

import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/team_contribute_data.dart';
import '../../../utils/app_shared_Preferences.dart';
import '../../base_view_model.dart';

final teamContributionInfoProviderProvider = StateNotifierProvider.autoDispose<
    TeamContributionInfoNotifier, TeamContribute>((ref) {
  return TeamContributionInfoNotifier();
});

class TeamContributionInfoNotifier extends StateNotifier<TeamContribute>
    with BasePrefProvider {
  TeamContributionInfoNotifier() : super(TeamContribute());
  BaseViewModel viewModel = BaseViewModel();
  String startDate = '';
  String endDate = '';

  @override
  Future<void> initProvider() async {
    state = TeamContribute();
  }

  @override
  Future<void> initValue() async {
    state = TeamContribute();
  }

  void setDate({required String startDate, required String endDate}) {
    this.startDate = startDate;
    this.endDate = endDate;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = await GroupAPI(onConnectFail: onConnectFail).getContribute(
        startTime: viewModel.getStartTime(startDate),
        endTime: viewModel.getEndTime(endDate));
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = TeamContribute.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "teamContributionInfo";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    await AppSharedPreferences.setJson(
        getSharedPreferencesKey(), state.toJson());
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
