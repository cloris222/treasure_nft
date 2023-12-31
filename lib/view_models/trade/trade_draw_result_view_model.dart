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
          strGmtFormat: '(GMT{}{:02d}{:02d}) ',
          setSystemZone: drawResultInfo!.zone,
          strFormat: 'yyyy-MM-dd HH:mm:ss',
          isShowGmt: true);
    }
    return '(+00:00) 0000-00-00 00:00';
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

  String getPrize(int index) {
    switch (index) {
      case 1:
        return '1st';
      case 2:
        return '2nd';
      case 3:
        return '3rd';
    }
    return '';
  }

  String getFullPrize(int index) {
    switch (index) {
      case 1:
        return 'First';
      case 2:
        return 'Second';
      case 3:
        return 'Third';
    }
    return '';
  }
}
