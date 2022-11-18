import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_activity_reserve.dart';

import '../../constant/call_back_function.dart';
import '../base_view_model.dart';

class ActivityViewModel extends BaseViewModel {
  ActivityViewModel({required this.setState,});

  final onClickFunction setState;
  ActivityReserveInfo? canReserve;

  void initState() async{
    canReserve = await TradeAPI().getActivityReserveAPI();
  }
}
