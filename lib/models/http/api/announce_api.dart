import 'dart:convert';
import '../http_manager.dart';
import '../parameter/announce_data.dart';

class AnnounceAPI extends HttpManager {
  AnnounceAPI({super.onConnectFail});

  ///MARK: 查詢公告
  Future<List<AnnounceData>> getAnnounceAll() async {
    List<AnnounceData> list = [];
    var response = await get('/announce/all');

    for (Map<String, dynamic> json in response.data["pageList"]) {
      list.add(AnnounceData.fromJson(json));
    }
    return list;
  }

  ///MARK: 查詢標籤
  Future<List<AnnounceTagData>> getAnnounceTag() async {
    List<AnnounceTagData> list = [];
    var response = await get('/announce/tag');

    for (Map<String, dynamic> json in response.data["pageList"]) {
      list.add(AnnounceTagData.fromJson(json));
    }
    return list;
  }


}