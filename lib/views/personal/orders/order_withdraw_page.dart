import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../widgets/app_bottom_center_button.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';

///MARK: 提領
class OrderWithdrawPage extends StatelessWidget {
  const OrderWithdrawPage(
      {Key? key, this.type = AppNavigationBarType.typePersonal})
      : super(key: key);
  final AppNavigationBarType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('walletWithdraw')),
      bottomNavigationBar: AppBottomNavigationBar(initType: type),
      floatingActionButton: const AppBottomCenterButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
