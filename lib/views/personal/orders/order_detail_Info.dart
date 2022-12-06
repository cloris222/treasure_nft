import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';

import '../../../view_models/personal/orders/order_detail_viewmodel.dart';

class OrderDetailInfo extends StatefulWidget {
  const OrderDetailInfo({Key? key, required this.viewModel, required this.type})
      : super(key: key);
  final OrderDetailViewModel viewModel;
  final EarningIncomeType type;

  @override
  State<OrderDetailInfo> createState() => _OrderDetailInfoState();
}

class _OrderDetailInfoState extends State<OrderDetailInfo> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.viewModel.buildListView();
  }
}
