import '../../data/station_letter_data.dart';
import '../http_manager.dart';
import '../parameter/announce_data.dart';

class AnnounceAPI extends HttpManager {
  AnnounceAPI({super.onConnectFail});

  ///MARK: 查詢公告
  Future<List<AnnounceData>> getAnnounceAll({required String lang}) async {
    List<AnnounceData> list = [];
      var response = await get('/announce/all', queryParameters: {
        "lang": lang,
      });
      
      for (Map<String, dynamic> json in response.data["pageList"]) {
        list.add(AnnounceData.fromJson(json));
      }
    return list;
  }

  ///MARK: 查詢最新一筆公告
  Future<AnnounceData> getAnnounceLast(String lang) async {
    AnnounceData data = AnnounceData();
    var response = await get('/announce/all', queryParameters: {
      "lang": lang,
      "page":1,
      "size":1
    });
    for (Map<String, dynamic> json in response.data["pageList"]) {
      data = AnnounceData.fromJson(json);
    }
    return data;
  }

  ///MARK: 查詢標籤
  Future<List<AnnounceTagData>> getAnnounceTag({required String lang}) async {
    List<AnnounceTagData> list = [];
    var response = await get('/announce/tag', queryParameters: {
      "lang": lang
    });

    for (Map<String, dynamic> json in response.data["pageList"]) {
      list.add(AnnounceTagData.fromJson(json));
    }
    return list;
  }

  ///MARK: 查詢用戶站內信
  Future<List<StationLetterData>> getStationLetterList({int page = 1, int size = 20}) async {
    List<StationLetterData> list = [];
    var response = await get("/stationLetter/all", queryParameters: {"page": page, "size": size});

    for (Map<String, dynamic> json in response.data["pageList"]) {
      list.add(StationLetterData.fromJson(json));
    }
    /// 假資料
    // return List<StationLetterData>.generate(10, (index) => StationLetterData(id: "${DateTime.timestamp().toIso8601String()}_$index", title: 'ATitle($index)', content: '123456', isRead: false));
    return list;
  }

  ///MARK: 已讀站內信
  Future<void> setStationLetterRead(List<String> ids)async{
    await post("/stationLetter/save/readTime",data: {"letterId":ids});
  }
}
