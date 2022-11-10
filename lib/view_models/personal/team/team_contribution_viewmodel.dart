import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/team_contribute_data.dart';
import '../../../widgets/list_view/team/team_contribute_item.dart';

class TeamContributionViewModel extends BaseListViewModel {
  TeamContributionViewModel({required super.onListChange});

  TeamContribute teamContribute = TeamContribute();
  String startDate = '';
  String endDate = '';

  ///MARK: direct:A級會員, indirect:B級會員, third:C級會員, totalUser:全部會員
  String type = 'direct';

  Future<void> initState() async {
    getContribute('', '').then((value) {
      teamContribute = value;
      onListChange();
    });
    initListView();
  }

  @override
  Widget itemView(int index, data) {
    return TeamContributeItemView(itemCount: index + 1, itemData: data);
  }

  @override
  Widget buildSeparatorView(BuildContext context, int index) {
    return Divider(
      height: UIDefine.getScreenWidth(4.16),
      color: AppColors.datePickerBorder,
    );
  }

  @override
  Future<List> loadData(int page, int size) async {
    return GroupAPI().getContributeList(
        page: page,
        size: size,
        type: type,
        startTime: getStartTime(startDate),
        endTime: getEndTime(endDate));
  }

  /// 查詢團隊貢獻
  Future<TeamContribute> getContribute(String startDate, String endDate,
      {ResponseErrorFunction? onConnectFail}) async {
    return await GroupAPI(onConnectFail: onConnectFail).getContribute(
        startTime: getStartTime(startDate), endTime: getEndTime(endDate));
  }

  void onDataCallBack(String startDate, String endDate) {
    if (startDate != this.startDate || endDate != this.endDate) {
      this.startDate = startDate;
      this.endDate = endDate;
      getContribute(startDate, endDate).then((value) => {
            teamContribute = value,
          });
      initListView();
    }
  }
}
