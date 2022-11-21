import 'package:easy_localization/easy_localization.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_activity_reserve.dart';
import 'package:treasure_nft_project/utils/timer_util.dart';
import 'package:treasure_nft_project/utils/trade_timer_util.dart';

import '../../constant/call_back_function.dart';
import '../base_view_model.dart';

class ActivityViewModel extends BaseViewModel {
  ActivityViewModel({
    required this.setState,
  });

  final onClickFunction setState;
  ActivityReserveInfo? canReserve;
  String startTime = '00:00:00';
  String endTime = '22:59:59';
  bool isOpen = true;
  String localTime = '2022-11-21 11:24:00';
  String drawTime = '2022-11-18 16:13:00';

  void initState() async {
    canReserve = await TradeAPI().getActivityReserveAPI();
    startTime = canReserve?.startTime ?? '00:00:00';
    endTime = canReserve?.endTime ?? '22:59:59';
    localTime = canReserve?.localTime ?? '2022-11-21 11:24:00';
    drawTime = canReserve?.drawTime ?? '2022-11-18 16:13:00';
  }

  String getEndTimeLabel() {
    if (isOpen = false) {
      return tr("over");
    } else {
      return endTime;
    }
  }

  _countdownTimer(){

  }

}
