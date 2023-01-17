import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/group_api.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_invite_data.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_nft_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_group_list.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

class TeamMemberViewModel extends BaseViewModel {
  int memberDetailTotalPages = 1;

  /// 查詢團隊成員
  Future<TeamMembers> getTeamMembers(String startTime, String endTime,
      {ResponseErrorFunction? onConnectFail}) async {
    return await GroupAPI(onConnectFail: onConnectFail).getMembers(
        startTime: getStartTime(startTime), endTime: getEndTime(endTime));
  }

  /// 查詢下線持有物品
  Future<List<LowerNftData>> getLowerNFT(int size, String lowerId,
      {ResponseErrorFunction? onConnectFail}) async {
    List<LowerNftData> list = [];

    var response = await GroupAPI(onConnectFail: onConnectFail).getLowerNFT(
      page: 1,
      size: size > 0 ? size : 1,
      lowerId: lowerId,
    );
    for (Map<String, dynamic> json in response.data['pageList']) {
      list.add(LowerNftData.fromJson(json));
    }
    return list;
  }

  /// 查詢下線直推列表
  Future<List<LowerInviteData>> getLowerInvite(int size, String lowerId,
      {ResponseErrorFunction? onConnectFail}) async {
    List<LowerInviteData> list = [];

    var response = await GroupAPI(onConnectFail: onConnectFail).getLowerInvite(
      page: 1,
      size: size > 0 ? size : 1,
      lowerId: lowerId,
    );
    for (Map<String, dynamic> json in response.data['pageList']) {
      list.add(LowerInviteData.fromJson(json));
    }
    return list;
  }

  /// 查詢群組會員列表
  Future<GroupList> getGroupList({ResponseErrorFunction? onConnectFail}) async {
    return await GroupAPI(onConnectFail: onConnectFail).getGroupList();
  }

  Widget getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }

  Widget getPaddingWithView(double val, Widget view) {
    return Padding(
      padding: EdgeInsets.only(
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
    DateTime dateTime = DateTime.now().subtract(Duration(days: day));
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  Widget getCoinImage() {
    return SizedBox(
      height: UIDefine.getScreenWidth(4),
      child: Image.asset(AppImagePath.tetherImg),
    );
  }

  BoxDecoration setBoxDecoration() {
    return BoxDecoration(
        border: Border.all(width: 1, color: AppColors.bolderGrey),
        borderRadius: BorderRadius.circular(8));
  }

  OutlineInputBorder setOutlineInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.datePickerBorder, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(10)));
  }
}
