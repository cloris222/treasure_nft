import 'package:treasure_nft_project/models/http/api/trade_api.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/parameter/draw_result_info.dart';
import '../base_view_model.dart';

class TradeDrawResultViewModel extends BaseViewModel {
  TradeDrawResultViewModel({required this.onViewChange});

  final onClickFunction onViewChange;
  DrawResultInfo? drawResultInfo;

  void initState() {
    TradeAPI().getActivityDrawResultInfoAPI().then((value) {
      drawResultInfo = value;
      onViewChange();
    });
  }

  String getActivityChangeTime(String time) {
    if (drawResultInfo != null) {
      return changeTimeZone(time,
          strGmtFormat: '(GMT{}{:d}) ',
          setSystemZone: drawResultInfo!.zone,
          strFormat: 'yyyy/MM/dd HH:mm',
          isShowGmt: true);
    }
    return '(+00:00) 0000/00/00 00:00';
  }

  int getPrizeAmount(int index) {
    if (drawResultInfo != null) {
      for (var element in drawResultInfo!.prizeList) {
        if (element.index == index) {
          return element.amount;
        }
      }
    }
    return 0;
  }
  int getPrizePerson(int index) {
    if (drawResultInfo != null) {
      for (var element in drawResultInfo!.prizeList) {
        if (element.index == index) {
          return element.quota;
        }
      }
    }
    return 0;
  }
}
