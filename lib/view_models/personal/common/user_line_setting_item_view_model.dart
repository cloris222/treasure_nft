import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/enum/route_setting_enum.dart';
import '../../../constant/global_data.dart';
import '../../../models/http/api/test_route_api.dart';

class UserLineSettingItemViewModel extends BaseViewModel {
  UserLineSettingItemViewModel({required this.onViewChange});

  final String _tag = "LineConnect";
  List<num> pinResultList = [];
  bool isTimeOut = false;
  num? label;
  bool stop = false;
  bool isRun = false;
  final onClickFunction onViewChange;

  void _initSetting() {
    label = null;
    isTimeOut = false;
    stop = false;
    pinResultList.clear();
  }

  Future<void> initServer({required RouteSetting server, int successCount = 3, int runCount = 10}) async {
    disconnectServer();
    if (!isRun) {
      isRun = true;
      _initSetting();

      /// 測試10次 都沒成功就當作Time out
      for (int i = 0; i < runCount; i++) {
        /// 強制停止用
        if (stop) {
          break;
        }
        DateTime startTime = DateTime.now();
        try {
          await TestRouteAPI(replaceRoute: server.getDomain()).testConnectRoute();
          DateTime endTime = DateTime.now();
          int pingMs = endTime.difference(startTime).inMilliseconds;

          GlobalData.printLog("$_tag : startTime (${startTime.toIso8601String()})");
          GlobalData.printLog("$_tag : endTime (${endTime.toIso8601String()})");
          GlobalData.printLog("$_tag : Connect (${server.name}) $pingMs ms");

          pinResultList.add(endTime.difference(startTime).inMilliseconds);

          /// 檢查是否連接滿成功的次數
          if (pinResultList.length == successCount) {
            break;
          }
        } catch (e) {
          GlobalData.printLog("$_tag : Connect (${server.name}) Error");
        }
        await Future.delayed(const Duration(milliseconds: 500));
      }
      if (pinResultList.length == successCount) {
        num total = 0;
        for (var i in pinResultList) {
          total += i;
        }
        label = total / successCount;
        TestRouteAPI().updateRouteDelay(server, label ?? 0);
      } else {
        isTimeOut = true;
      }
      isRun = false;
      onViewChange();
    }
  }

  void disconnectServer() {
    stop = true;
  }
}
