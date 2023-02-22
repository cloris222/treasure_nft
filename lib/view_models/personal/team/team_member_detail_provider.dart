import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_list_provider.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/team_member_detail.dart';
import '../../../utils/app_shared_Preferences.dart';

final teamMemberDetailProvider = StateNotifierProvider.family<
    TeamMemberDetailNotifier, List<MemberDetailPageList>, String>((ref, type) {
  return TeamMemberDetailNotifier(type);
});

class TeamMemberDetailNotifier extends StateNotifier<List<MemberDetailPageList>>
    with BaseListProvider {
  TeamMemberDetailNotifier(this.type) : super([]);
  final String type;

  @override
  Future<void> initValue() async {
    state = <MemberDetailPageList>[];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      List<MemberDetailPageList> list = List<MemberDetailPageList>.from(
          json.map((x) => MemberDetailPageList.fromJson(x)));
      state = list;
    }
  }

  @override
  String setKey() {
    return "teamMemberDetail_$type";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  Future<List> loadData(
      {required int page,
      required int size,
      required String startTime,
      required String endTime,
      required bool needSave,
      ResponseErrorFunction? onConnectFail}) async {
    List<MemberDetailPageList> list =
        await GroupAPI(onConnectFail: onConnectFail).getMemberDetail(
            page: page,
            size: size,
            type: type,
            startTime: startTime,
            endTime: endTime);

    if (needSave) {
      setSharedPreferencesValue(list);
    }
    return list;
  }

  @override
  void addList(List data) {
    state = [...state, ...data as List<MemberDetailPageList>];
  }

  @override
  void clearList() {
    state = <MemberDetailPageList>[];
  }
}
