import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/account/account_main_view.dart';
import 'package:treasure_nft_project/views/collection/collection_main_view.dart';
import 'package:treasure_nft_project/views/explore/explore_main_view.dart';
import 'package:treasure_nft_project/views/login/login_main_view.dart';
import 'package:treasure_nft_project/views/personal/personal_main_view.dart';
import 'package:treasure_nft_project/views/trade/trade_main_view.dart';
import 'package:treasure_nft_project/views/wallet/wallet_main_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../constant/global_data.dart';
import '../constant/ui_define.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import 'home/home_main_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, this.type = AppNavigationBarType.typeMain})
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
    int initialPage = getViewIndex(widget.type);
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
          HomeMainView(),
          LoginMainView(),
          PersonalMainView(),
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

  void _searchAction() {
    GlobalData.mainBottomType = AppNavigationBarType.typeExplore;
    pageController.jumpToPage(0);
  }

  int getViewIndex(AppNavigationBarType type) {
    switch (type) {
      case AppNavigationBarType.typeExplore:
        return 0;
      case AppNavigationBarType.typeCollection:
        return 1;
      case AppNavigationBarType.typeTrade:
        return 2;
      case AppNavigationBarType.typeWallet:
        return 3;
      case AppNavigationBarType.typeAccount:
        return 4;
      case AppNavigationBarType.typeMain:
        return 5;
      case AppNavigationBarType.typeLogin:
        return 6;
      case AppNavigationBarType.typePersonal:
        return 7;
    }
  }

  void _serverAction() {}

  void _avatarAction() {
    if (GlobalData.login) {
      GlobalData.mainBottomType = AppNavigationBarType.typePersonal;
    } else {
      GlobalData.mainBottomType = AppNavigationBarType.typeLogin;
    }
    pageController.jumpToPage(getViewIndex(GlobalData.mainBottomType));
  }

  void _globalAction() {}

  void _mainAction() {
    setState(() {
      GlobalData.mainBottomType = AppNavigationBarType.typeMain;
      pageController.jumpToPage(getViewIndex(GlobalData.mainBottomType));
    });
  }
}
