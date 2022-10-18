import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../widgets/app_bottom_navigation_bar.dart';

///MARK: 我的收益
class OrderBalDetailPage extends StatelessWidget {
  const OrderBalDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('myEarnings')),
      body: Column(
        children: const [PersonalSubUserInfoView()],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typePersonal),
    );
  }
}
