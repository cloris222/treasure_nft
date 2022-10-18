import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../../widgets/app_bottom_navigation_bar.dart';

///MARK: 我的NFT
class OrdersNftPage extends StatelessWidget {
  const OrdersNftPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.mainAppBar(
          searchAction: () {},
          serverAction: () {},
          avatarAction: () {},
          mainAction: () {},
          globalAction: () {}),
      body: Column(
        children: const [DomainBar()],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typePersonal),
    );
  }
}
