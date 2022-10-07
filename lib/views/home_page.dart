import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/account/account_main_view.dart';
import 'package:treasure_nft_project/views/collection/collection_main_view.dart';
import 'package:treasure_nft_project/views/explore/explore_main_view.dart';
import 'package:treasure_nft_project/views/trade/trade_main_view.dart';
import 'package:treasure_nft_project/views/wallet/wallet_main_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../constant/ui_define.dart';
import '../widgets/app_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.type = AppNavigationBarType.typeExplore})
      : super(key: key);
  final AppNavigationBarType type;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.mainAppBar(
          searchAction: _searchAction,
          serverAction: _serverAction,
          avatarAction: _avatarAction,
          globalAction: _globalAction, mainAction: _mainAction),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ExploreMainView(),
          CollectionMainView(),
          TradeMainView(),
          WalletMainView(),
          AccountMainView(),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        initType: widget.type,
        bottomFunction: _changePage,
      ),
    );
  }

  _changePage(AppNavigationBarType type, int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  void _searchAction() {}

  void _serverAction() {}

  void _avatarAction() {}

  void _globalAction() {}

  void _mainAction() {
  }
}
