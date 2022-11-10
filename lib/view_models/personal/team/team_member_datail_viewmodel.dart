import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/api/group_api.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';

import '../../../constant/ui_define.dart';
import '../../../widgets/list_view/team/member_detail_item.dart';

class TeamMemberDetailViewModel extends BaseListViewModel {
  TeamMemberDetailViewModel({
    required super.onListChange,
    required this.startTime,
    required this.endTime,
    required this.type,
  });

  final String startTime;
  final String endTime;
  final String type;

  @override
  Widget buildSeparatorView(BuildContext context, int index) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(3)));
  }

  @override
  Widget itemView(int index, data) {
    return MemberDetailItemView(itemData: data);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return GroupAPI().getMemberDetail(
        page: page,
        size: size,
        type: type,
        startTime: startTime,
        endTime: endTime);
  }
}
