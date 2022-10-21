import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/group_api.dart';
import 'package:treasure_nft_project/models/http/parameter/members_detail.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';


class TeamMemberViewModel extends BaseViewModel {

  /// 查詢團隊成員
  Future<TeamMembers> getTeamMembers(
      String startTime, String endTime,
      {ResponseErrorFunction? onConnectFail}) async {
    return await GroupAPI(onConnectFail: onConnectFail)
        .getMembers(startTime: startTime, endTime: endTime);
  }

  /// 查詢群組會員列表
  Future<MembersDetail> getMembersDetail(
      {ResponseErrorFunction? onConnectFail}) async {
    return await GroupAPI(onConnectFail: onConnectFail)
        .getGroupList();
  }

  Widget getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }
  Widget getPaddingWithView(double val, Widget view) {
    return Padding(padding: EdgeInsets.only(
      top: UIDefine.getScreenWidth(val),
      bottom: UIDefine.getScreenWidth(val),
    ),
      child: view,
    );
  }

  String dateTimeFormat(DateTime? time) {
    return DateFormat('yyyy-MM-dd').format(time ?? DateTime.now());
  }

  String getDays(int day) {
    DateTime dateTime = DateTime.now().subtract(Duration(days:day));
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

}