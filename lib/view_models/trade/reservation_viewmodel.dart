import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/models/http/parameter/check_reserve_deposit.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

class ReservationViewModel extends BaseViewModel {
  late CheckReserveDeposit checkReserve;

  Future<void> initState(int? index, double? startPrice, double? endPrice) async {
    checkReserve = await TradeAPI()
        .getCheckReserveDepositAPI(index!, startPrice!, endPrice!);
  }
}
