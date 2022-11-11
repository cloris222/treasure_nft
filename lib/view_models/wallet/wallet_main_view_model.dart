import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/api/user_info_api.dart';
import '../../utils/app_shared_Preferences.dart';
import '../../views/wallet/data/BalanceRecordResponseData.dart';

class WalletMainViewModel extends BaseViewModel {
  WalletMainViewModel({required this.setState});

  final ViewChange setState;

  List<BalanceRecordResponseData> balanceRecordResponseDataList =
      <BalanceRecordResponseData>[];

  void initState() async {
    ///MARK:取得資料
    await AppSharedPreferences.getWalletRecord()
        .then((value) => setState(() => balanceRecordResponseDataList = value));
    List<bool> checkList = List<bool>.generate(3, (index) => false);

    UserInfoAPI().getUserPropertyInfo().then((value) => checkList[0] = true);
    WalletAPI().getBalanceRecharge().then((value) => checkList[1] = true);
    WalletAPI().getBalanceRecord().then((value) {
      balanceRecordResponseDataList = value;
      checkList[2] = true;
    });

    checkFutureTime(
            logKey: 'uploadWalletMain',
            onCheckFinish: () => !checkList.contains(false))
        .then((value) => setState(() {}));
  }
}
