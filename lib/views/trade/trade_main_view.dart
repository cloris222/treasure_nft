import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../widgets/dialog/custom_amount_dialog.dart';
import '../../widgets/dialog/edit_avatar_dialog.dart';

class TradeMainView extends StatelessWidget {
  const TradeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      DomainBar()
    ],),);
  }

  Widget _countDownView(BuildContext context) {
    return Stack(children: [

    ],);
  }
}
