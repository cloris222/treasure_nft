import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/wallet_api.dart';

class OrderRechargeViewModel extends BaseViewModel {
  OrderRechargeViewModel({required this.setState});

  final ViewChange setState;

  Map<String, dynamic>? address;
  String currentChain = 'TRON';
  final String chainTRON = 'TRON';
  final String chainBSC = 'BSC';

  Future<void> initState() async {
    address = await WalletAPI().getBalanceRecharge();
    setState(() {});
  }

  ///MARK: 儲存QR Code
  void saveQrcode() {}
}
