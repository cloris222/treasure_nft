import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/api/group_api.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';
import '../../../widgets/list_view/team/team_order_item.dart';

class TeamOrderViewModel extends BaseListViewModel {
  TeamOrderViewModel(
      {required super.onListChange,
      super.hasTopView = true,
      required this.topView,
      super.padding});

  String startDate = '';
  String endDate = '';

  // bool isSortDesc = true;
  String sortType = 'time';
  String nameAcct = '';
  String nameAcctType = 'ALL';
  final Widget Function() topView;

  @override
  Widget itemView(int index, data) {
    return TeamOrderItemView(itemData: data);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return GroupAPI().getTeamOrder(
        page: page,
        size: size,
        startTime: getStartTime(startDate),
        endTime: getEndTime(endDate),
        sortBy: sortType,
        nameAcct: nameAcct,
        nameAcctType: nameAcctType);
  }

  @override
  Widget buildTopView() {
    return topView();
  }
}
