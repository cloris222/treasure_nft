import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/user_property.dart';

class WalletMainViewModel extends BaseViewModel {
  WalletMainViewModel({required this.setState});

  final ViewChange setState;

  UserProperty? userProperty;
  Map<String, dynamic>? address;

  Future<void> initState() async {
    userProperty = await UserInfoAPI().getUserPropertyInfo();
    address = await WalletAPI().getBalanceRecharge();
    setState(() {});
  }
}
