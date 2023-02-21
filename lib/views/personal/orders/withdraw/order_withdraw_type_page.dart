import 'package:flutter/cupertino.dart';
import '../../../../models/http/parameter/withdraw_alert_info.dart';
import 'chain_withdraw_view.dart';
import 'internal_withdraw_view.dart';

class OrderWithdrawTypePage extends StatelessWidget {
  const OrderWithdrawTypePage(
      {super.key,
      required this.currentType,
      required this.getWalletAlert,
      required this.experienceMoney});

  final String currentType;
  final WithdrawAlertInfo Function() getWalletAlert;
  final num experienceMoney;

  @override
  Widget build(BuildContext context) {
    if (currentType == 'Chain') {
      return ChainWithdrawView(
          getWalletAlert: getWalletAlert, experienceMoney: experienceMoney);
    } else {
      return InternalWithdrawView(
          getWalletAlert: getWalletAlert, experienceMoney: experienceMoney);
    }
  }
}
