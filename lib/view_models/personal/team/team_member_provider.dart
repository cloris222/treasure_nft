import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_pref_provider.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/team_members.dart';
import '../../../utils/app_shared_Preferences.dart';

final teamMemberProvider =
    StateNotifierProvider<TeamMemberNotifier, TeamMembers>((ref) {
  return TeamMemberNotifier();
});

class TeamMemberNotifier extends StateNotifier<TeamMembers>
    with BasePrefProvider {
  TeamMemberNotifier() : super(TeamMembers());
  String startTime = '';
  String endTime = '';

  void setTimes(List<String> times) {
    startTime = times[0];
    endTime = times[1];
  }

  List<String> getTimes() {
    return [startTime, endTime];
  }

  @override
  Future<void> initProvider() async {
    startTime = '';
    endTime = '';
    state = TeamMembers();
  }

  @override
  Future<void> initValue() async {}

  @override
  Future<void> readAPIValue() async {
    BaseViewModel viewModel = BaseViewModel();
    state = await GroupAPI().getMembers(
        startTime: viewModel.getStartTime(startTime),
        endTime: viewModel.getEndTime(endTime));
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      state = TeamMembers.fromJson(json);
    }
  }

  @override
  String setKey() {
    return "teamMember";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    ///MARK:只儲存全部值
    if (endTime.isEmpty && startTime.isEmpty) {
      AppSharedPreferences.setJson(getSharedPreferencesKey(), state.toJson());
    }
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
