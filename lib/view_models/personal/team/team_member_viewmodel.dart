import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/group_api.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_invite_data.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_nft_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_group_list.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

class TeamMemberViewModel extends BaseViewModel {
  int memberDetailTotalPages = 1;

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
}
