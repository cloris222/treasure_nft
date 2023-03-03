import 'dart:io';

import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/http_manager.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/models/http/parameter/reserve_view_data.dart';
import '../parameter/check_activiey_deposit.dart';
import '../parameter/check_activity_reserve.dart';
import '../parameter/check_experience_info.dart';
import '../parameter/check_reservation_info.dart';
import '../parameter/check_reserve_deposit.dart';
import '../parameter/draw_result_info.dart';
import '../parameter/trade_reserve_stage__info.dart';

class TradeAPI extends HttpManager {
  TradeAPI({super.onConnectFail, super.showTrString});

  /// 活動用參數 1:世界盃
  final String activityID = "1";
  final String activityType = "WORLDCUP";

  /// step1: 查詢副本歸屬區間資訊
  Future<List<int>> getDivisionAPI() async {
    var response = await get('/reserve/division');
    return List<int>.from(response.data.map((x) => x));
  }

  /// step2: 查詢預約資訊
  Future<CheckReservationInfo> getCheckReservationInfoAPI(int division,
      {String? reserveDate, int? reserveStage}) async {
    var response =
        await get('/reserve/info', queryParameters: {'division': division});
    return CheckReservationInfo.fromJson(response.data);
  }

  ///MARK: 交易線圖 查看交易量等資訊
  Future<ReserveViewData> getReserveView(int index) async {
    var response =
        await get('/reserve/view', queryParameters: {"index": index});
    return ReserveViewData.fromJson(response.data);
  }

  /// 查詢預約金
  Future<CheckReserveDeposit> getCheckReserveDepositAPI(
      int index, double startPrice, double endPrice) async {
    var response = await get('/reserve/deposit', queryParameters: {
      'index': index,
      'startPrice': startPrice,
      'endPrice': endPrice
    });
    //  response.printLog();
    return CheckReserveDeposit.fromJson(response.data);
  }

  /// 新增預約
  Future<ApiResponse> postAddNewReservationAPI(
      {required String type,
      required int reserveCount,
      required dynamic startPrice,
      required dynamic endPrice,
      required int priceIndex}) async {
    return post('/reserve/insert', data: {
      'type': type,
      'reserveCount': reserveCount,
      'startPrice': startPrice,
      'endPrice': endPrice,
      'priceIndex': priceIndex
    });
  }

  /// 取得體驗帳號資訊
  Future<ExperienceInfo> getExperienceInfoAPI() async {
    var response = await get('/experience/experience-info');
    return ExperienceInfo.fromJson(response.data);
  }

  ///MARK: 查詢開獎結果
  Future<DrawResultInfo> getActivityDrawResultInfoAPI() async {
    var response = await get('/activity-dungeon/draw-result',
        queryParameters: {'id': activityID});
    return DrawResultInfo.fromJson(response.data);
  }

  /// 查詢活動 是否可預約
  Future<ActivityReserveInfo> getActivityReserveAPI() async {
    var response = await get('/activity-dungeon/can-reserve',
        queryParameters: {'id': activityID});
    return ActivityReserveInfo.fromJson(response.data);
  }

  /// 查詢活動 預約金
  Future<ActivityDeposit> getActivityDeposit(String id) async {
    var response =
        await get('/activity-dungeon/deposit', queryParameters: {'id': id});
    return ActivityDeposit.fromJson(response.data);
  }

  /// 活動 新增預約
  Future<ApiResponse> postActivityInsert() async {
    return post('/activity-dungeon/insert',
        data: {'id': activityID, 'code': activityType});
  }

  /// app交易頁面Enter按鈕是否顯示
  Future<bool> getTradeEnterButtonStatus() async {
    if (Platform.isAndroid) {
      GlobalData.appTradeEnterButtonStatus = true;
      return true;
    }
    try {
      var response = await get('/button/trade/enter');
      GlobalData.appTradeEnterButtonStatus =
          response.data['appTradeEnterButtonStatus'] == 'ENABLE';
      return response.data['appTradeEnterButtonStatus'] == 'ENABLE';
    } catch (e) {
      GlobalData.appTradeEnterButtonStatus = false;
      return false;
    }
  }

  ///MARK: 查詢可預約場次
  Future<List<TradeReserveStageInfo>> getTradeCanReserveStage() async {
    try {
      var response =
          await get('/reserve/can-reserve-stage', queryParameters: {'day': 1});
      return List<TradeReserveStageInfo>.from(
          response.data.map((x) => TradeReserveStageInfo.fromJson(x)));
    } catch (e) {
      GlobalData.printLog("getTradeReserveStage_error:${e.toString()}");
      return [];
    }
  }
}
