import 'package:treasure_nft_project/models/http/parameter/check_reservation_info.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/trade_api.dart';

class TradeMainViewModel extends BaseViewModel {
  TradeMainViewModel({required this.setState});

  final ViewChange setState;
  CheckReservationInfo? info;

  Future<void> initState() async {
    info = await TradeAPI().getCheckReservationInfoAPI();
    setState((){});
  }
}
