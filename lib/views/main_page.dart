import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/account/account_main_view.dart';
import 'package:treasure_nft_project/views/collection/collection_main_view.dart';
import 'package:treasure_nft_project/views/explore/explore_main_view.dart';
import 'package:treasure_nft_project/views/trade/trade_main_view.dart';
import 'package:treasure_nft_project/views/wallet/wallet_main_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../constant/global_data.dart';
import '../constant/ui_define.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import 'home/home_main_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, this.type = AppNavigationBarType.typeNull})
      : super(key: key);
  final AppNavigationBarType type;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController pageController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  void initState() {
    super.initState();
    int initialPage;
    switch (widget.type) {
      case AppNavigationBarType.typeExplore:
        initialPage = 0;
        break;
      case AppNavigationBarType.typeCollection:
        initialPage = 1;
        break;
      case AppNavigationBarType.typeTrade:
        initialPage = 2;
        break;
      case AppNavigationBarType.typeWallet:
        initialPage = 3;
        break;
      case AppNavigationBarType.typeAccount:
        initialPage = 4;
        break;
      default:
        initialPage = 5;
        break;
    }
    pageController = PageController(initialPage: initialPage);
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
          globalAction: _globalAction,
          mainAction: _mainAction),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ExploreMainView(),
          CollectionMainView(),
          TradeMainView(),
          WalletMainView(),
          AccountMainView(),
          HomeMainView()
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
    setState(() {
      GlobalData.mainBottomType = AppNavigationBarType.typeNull;
      pageController.jumpToPage(5);
    });
  }
}
