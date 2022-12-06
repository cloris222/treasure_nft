import 'package:flutter/cupertino.dart';
import '../../../../models/http/parameter/withdraw_alert_info.dart';
import 'chain_withdraw_view.dart';
import 'internal_withdraw_view.dart';

class OrderWithdrawTypePage extends StatefulWidget {
  const OrderWithdrawTypePage(
      {super.key, required this.currentType, required this.getWalletAlert});

  final String currentType;
  final WithdrawAlertInfo Function() getWalletAlert;

  @override
  State<StatefulWidget> createState() => _OrderWithdrawTypePage();
}

class _OrderWithdrawTypePage extends State<OrderWithdrawTypePage> {
  String get currentType {
    return widget.currentType;
  }

  @override
  Widget build(BuildContext context) {
    return _initView();
  }

  Widget _initView() {
    if (currentType == 'Chain') {
      return ChainWithdrawView(getWalletAlert: widget.getWalletAlert);
    } else {
      return InternalWithdrawView(getWalletAlert: widget.getWalletAlert);
    }
  }
}
