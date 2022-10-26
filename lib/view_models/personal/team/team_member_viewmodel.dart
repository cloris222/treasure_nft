import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/group_api.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_invite_data.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_nft_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_list_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_group_list.dart';
import 'package:treasure_nft_project/models/http/parameter/team_member_detail.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';


class TeamMemberViewModel extends BaseViewModel {
  int memberDetailTotalPages = 1;

  /// 查詢團隊成員
  Future<TeamMembers> getTeamMembers(
      String startTime, String endTime,
      {ResponseErrorFunction? onConnectFail}) async {
    return await GroupAPI(onConnectFail: onConnectFail)
        .getMembers(startTime: startTime, endTime: endTime);
  }

  /// 查詢成員詳細
  Future< List<MemberDetailPageList>> getMemberDetail(
      int page, String startTime, String endTime, String type,
      {ResponseErrorFunction? onConnectFail}) async {
    List<MemberDetailPageList> list = [];

    var response = await GroupAPI(onConnectFail: onConnectFail)
        .getMemberDetail(
        page: page,
        startTime: startTime,
        endTime: endTime,
        type: type,
    );
    memberDetailTotalPages = response.data['totalPages'];

    for (Map<String, dynamic> json in response.data['pageList']) {
      list.add(MemberDetailPageList.fromJson(json));
    }
    return list;
  }

  /// 查詢下線持有物品
  Future< List<LowerNftData>> getLowerNFT(
      int page, String lowerId,
      {ResponseErrorFunction? onConnectFail}) async {
    List<LowerNftData> list = [];

    var response = await GroupAPI(onConnectFail: onConnectFail)
        .getLowerNFT(
      page: page,
      lowerId: lowerId,
    );
    for (Map<String, dynamic> json in response.data['pageList']) {
      list.add(LowerNftData.fromJson(json));
    }
    return list;
  }

  /// 查詢下線直推列表
  Future<List<LowerInviteData>> getLowerInvite(
      int page, String lowerId,
      {ResponseErrorFunction? onConnectFail}) async {
    List<LowerInviteData> list = [];

    var response = await GroupAPI(onConnectFail: onConnectFail)
        .getLowerInvite(
      page: page,
      lowerId: lowerId,
    );
    for (Map<String, dynamic> json in response.data['pageList']) {
      list.add(LowerInviteData.fromJson(json));
    }
    return list;
  }


  /// 查詢團隊貢獻
  Future<TeamContribute> getContribute(
      String startTime, String endTime,
      {ResponseErrorFunction? onConnectFail}) async {
    return await GroupAPI(onConnectFail: onConnectFail)
        .getContribute(startTime: startTime, endTime: endTime);
  }

  /// 查詢團隊貢獻名單
  Future<List<TeamContributeList>> getContributeList(
      String startTime, String endTime,
      {ResponseErrorFunction? onConnectFail}) async {
    List<TeamContributeList> list = [];

    var response = await GroupAPI(onConnectFail: onConnectFail)
        .getContributeList(startTime: startTime, endTime: endTime);

    for (Map<String, dynamic> json in response.data['pageList']) {
      list.add(TeamContributeList.fromJson(json));
    }
    return list;
  }


  /// 查詢群組會員列表
  Future<GroupList> getGroupList(
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


  Widget getCoinImage() {
    return SizedBox(
      height: UIDefine.getScreenWidth(4),
      child:Image.asset(AppImagePath.tetherImg),
    );
  }


}