import 'package:flutter/cupertino.dart';

import '../../../view_models/personal/orders/order_detail_viewmodel.dart';
import '../../../widgets/card/item_info_card.dart';

class OrderDetailAll extends StatefulWidget {
  const OrderDetailAll({Key? key}) : super(key: key);

  @override
  State<OrderDetailAll> createState() => _OrderDetailAllState();
}

class _OrderDetailAllState extends State<OrderDetailAll> {
  late OrderDetailViewModel viewModel;

  @override
  initState() {
    super.initState();
    viewModel = OrderDetailViewModel(
      onListChange: () {
        setState(() {});
      },
    );
    viewModel.initState();
  }
  @override
  Widget build(BuildContext context) {
    return viewModel.buildListView();
  }
}
