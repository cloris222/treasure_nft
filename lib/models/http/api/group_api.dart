import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_nft_data.dart';
import 'package:treasure_nft_project/models/http/parameter/other_collect_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_list_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_group_list.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';

import '../parameter/check_share_center.dart';
import '../parameter/other_user_info.dart';
import '../parameter/team_member_detail.dart';
import '../parameter/team_order.dart';
import '../parameter/team_share_info.dart';

class GroupAPI extends HttpManager {
  GroupAPI({super.onConnectFail, super.baseUrl = HttpSetting.developUrl});

  /// 查詢團隊成員
  Future<TeamMembers> getMembers(
      {required String startTime, required String endTime}) async {
    var response = await get('/group/member-summary', queryParameters: {
      'startTime': startTime,
      'endTime': endTime,
    });
    return TeamMembers.fromJson(response.data);
  }

  /// 查詢成員詳細
  Future<ApiResponse> getMemberDetail(
      {required int page,
      int size = 2,
      required String type,
      required String startTime,
      required String endTime}) async {
    return await get('/group/member-list', queryParameters: {
      'page': page,
      'size': size,
      'startTime': startTime,
      'endTime': endTime,
      'type': type,
    });
  }

  /// 查詢下線持有物品
  Future<ApiResponse> getLowerNFT(
      {required int page, int size = 20, required String lowerId}) async {
    return await get('/group/lower-nft', queryParameters: {
      'page': page,
      'size': size,
      'lowerId': lowerId,
    });
  }

  /// 查詢下線直推列表
  Future<ApiResponse> getLowerInvite(
      {required int page, int size = 20, required String lowerId}) async {
    return await get('/group/lower-invite', queryParameters: {
      'page': page,
      'size': size,
      'lowerId': lowerId,
    });
  }

  /// 查詢團隊貢獻
  Future<TeamContribute> getContribute(
      {required String startTime, required String endTime}) async {
    var response = await get('/group/contribute-summary', queryParameters: {
      'startTime': startTime,
      'endTime': endTime,
    });
    return TeamContribute.fromJson(response.data);
  }

  /// 查詢團隊貢獻名單
  Future<ApiResponse> getContributeList(
      {int page = 1,
      int size = 20,
      type = '',
      required String startTime,
      required String endTime}) async {
    return await get('/group/contribute-list', queryParameters: {
      'page': page,
      'size': size,
      'startTime': startTime,
      'endTime': endTime,
      'type': type,
    });
  }

  /// 查詢團隊訂單
  Future<List<TeamOrderData>> getTeamOrder(
      {int page = 1,
      int size = 10,
      String sortBy = '',
      String nameAcct = '',
      String nameAcctType = '',
      required String startTime,
      required String endTime}) async {
    var response = await get('/group/team-order', queryParameters: {
      'page': page,
      'size': size,
      'startTime': startTime,
      'endTime': endTime,
      'sortBy': sortBy,
      'nameAcct': nameAcct,
      'nameAcctType': nameAcctType,
    });

    List<TeamOrderData> list = [];
    for (Map<String, dynamic> json in response.data['pageList']) {
      list.add(TeamOrderData.fromJson(json));
    }
    return list;
  }

  /// 查詢群組會員列表
  Future<GroupList> getGroupList(
      {int page = 1, int size = 10, String date = 'ALL'}) async {
    var response = await get('/group/list', queryParameters: {
      'size': size,
      'page': page,
      'date': date,
    });
    return GroupList.fromJson(response.data);
  }

  /// 查詢分享中心資訊
  Future<CheckShareCenter> getShareCenter() async {
    var response = await get('/level/share-center');
    return CheckShareCenter.fromJson(response.data);
  }

  ///MARK: 取得團隊分享訊息
  Future<TeamShareInfo> getTeamShareInfo(String orderNo) async {
    var response =
        await get('/group/share-info', queryParameters: {'orderNo': orderNo});
    return TeamShareInfo.fromJson(response.data);
  }

  ///MARK: 查詢買/賣家 用戶資訊
  Future<OtherUserInfo> getOtherUserInfo(
      {required String orderNo, required bool isSeller}) async {
    var response = await get('/user/query/user', queryParameters: {
      "orderNo": orderNo,
      "type": isSeller ? "MAKER" : "TAKER"
    });
    return OtherUserInfo.fromJson(response.data);
  }

  ///MARK: 查詢買/賣家收藏
  Future<List<OtherCollectData>> getOtherCollectData({
    required int page,
    required int size,
    required String userId,
    required bool isDesc,
    required String nftName,
  }) async {
    var response = await get('/NFTItem/query/collect', queryParameters: {
      "page": page,
      "size": size,
      "id": userId,
      "sort": isDesc ? "desc" : "asc",
      "nftName": nftName
    });

    List<OtherCollectData> result = [];
    for (Map<String, dynamic> json in response.data['pageList']) {
      result.add(OtherCollectData.fromJson(json));
    }

    return result;
  }
}
