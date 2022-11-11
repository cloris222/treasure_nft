import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/user_property.dart';
import '../../views/wallet/data/BalanceRecordResponseData.dart';

class WalletMainViewModel extends BaseViewModel {
  WalletMainViewModel({required this.setState});

  final ViewChange setState;

  Map<String, dynamic>? address;
  List<BalanceRecordResponseData> balanceRecordResponseDataList =
      <BalanceRecordResponseData>[];

  void initState() {
    UserInfoAPI().getUserPropertyInfo().then((value) => setState(() {}));
    WalletAPI()
        .getBalanceRecharge()
        .then((value) => setState(() => address = value));
    WalletAPI()
        .getBalanceRecord()
        .then((value) => setState(() => balanceRecordResponseDataList = value));
  }
}
