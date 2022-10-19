import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/wallet_api.dart';

class OrderRechargeViewModel extends BaseViewModel {
  OrderRechargeViewModel({required this.setState});

  final ViewChange setState;

  Map<String, dynamic>? address;
  String currentChain = 'TRON';

  Future<void> initState() async {
    address = await WalletAPI().getBalanceRecharge();
    setState(() {});
  }

  String getCurrentChainText() {
    if (currentChain == 'TRON') {
      return 'USDT-TRC20';
    }
    return 'USDT-BSC';
  }
}
