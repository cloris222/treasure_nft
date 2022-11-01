import 'package:flutter/cupertino.dart';
import 'chain_withdraw_view.dart';
import 'internal_withdraw_view.dart';

class OrderWithdrawTypePage extends StatefulWidget {
  const OrderWithdrawTypePage({super.key, required this.currentType});

  final String currentType;

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
      return ChainWithdrawView();

    } else {
      return InternalWithdrawView();
    }
  }

}