import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/models/http/parameter/members_detail.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';


class GroupAPI extends HttpManager {
  GroupAPI({super.onConnectFail, super.baseUrl = HttpSetting.developUrl});

  /// 查詢團隊成員
  Future<TeamMembers> getMembers(
      {required String startTime, required String endTime})  async {
    var response = await get('/group/member-summary',
        queryParameters: {
          'startTime' : startTime,
          'endTime' : endTime,
        });
    return TeamMembers.fromJson(response.data);
  }

  /// 查詢群組會員列表
  Future<MembersDetail> getGroupList(
      {int page = 1, int size = 10, String date = 'ALL'})  async {
    var response = await get('/group/list',
        queryParameters: {
          'size' : size,
          'page' : page,
          'date' : date,
        });
    return MembersDetail.fromJson(response.data);
  }



}