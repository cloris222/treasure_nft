import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/level_info_data.dart';

import '../parameter/bonus_referral_record_data.dart';
import '../parameter/bonus_trade_record_data.dart';
import '../parameter/level_bonus_data.dart';

class LevelAPI extends HttpManager {
  LevelAPI({super.onConnectFail});

  ///MARK: 檢查是否可升級
  Future<bool> checkLevelUpdate() async {
    var response = await get('/level/can-level-up');
    return response.data;
  }

  Future<void> setLevelUp() async {
    await post("/level/level-up");
  }

  Future<List<LevelInfoData>> getAllLevelInfo() async {
    var response = await get('/level/all');
    List<LevelInfoData> result = [];
    for (Map<String, dynamic> json in response.data) {
      result.add(LevelInfoData.fromJson(json));
    }
    return result;
  }

  ///MARK: 取得bonus
  Future<LevelBonusData> getBonusInfo() async {
    var response = await get('/level/bonus');
    return LevelBonusData.fromJson(response.data);
  }

  ///MARK: 取得推廣交易儲金罐明細
  Future<List<BonusReferralRecordData>> getBonusReferralRecord(
      {required int page,
      required int size,
      required String startTime,
      required String endTime}) async {
    List<BonusReferralRecordData> list = [];
    try {
      var response = await get('/savingsBox/spreadSavings/details',
          queryParameters: {
            'page': page,
            'size': size,
            'startTime': startTime,
            'endTime': endTime
          });
      for (Map<String, dynamic> json in response.data['pageList']) {
        list.add(BonusReferralRecordData.fromJson(json));
      }
    } catch (e) {}
    return list;
  }
  ///MARK: 取得交易儲金罐明細
  Future<List<BonusTradeRecordData>> getBonusTradeRecord(
      {required int page,
        required int size,
        required String startTime,
        required String endTime}) async {
    List<BonusTradeRecordData> list = [];
    try {
      var response = await get('/savingsBox/tradeSavings/details',
          queryParameters: {
            'page': page,
            'size': size,
            'startTime': startTime,
            'endTime': endTime
          });
      for (Map<String, dynamic> json in response.data['pageList']) {
        list.add(BonusTradeRecordData.fromJson(json));
      }
    } catch (e) {}
    return list;
  }
}
