import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/collection/collection_main_view.dart';
import 'package:treasure_nft_project/views/explore/explore_main_view.dart';
import 'package:treasure_nft_project/views/login/login_main_view.dart';
import 'package:treasure_nft_project/views/personal/personal_main_view.dart';
import 'package:treasure_nft_project/views/setting_language_page.dart';
import 'package:treasure_nft_project/views/sigin_in_page.dart';
import 'package:treasure_nft_project/views/trade/trade_main_view.dart';
import 'package:treasure_nft_project/views/wallet/wallet_main_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../constant/global_data.dart';
import '../constant/ui_define.dart';
import '../models/http/parameter/sign_in_data.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import 'full_animation_page.dart';
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
    debugPrint('initialPage:$initialPage');
    debugPrint('widget.type:${widget.type}');
    GlobalData.mainBottomType = widget.type;
    pageController = PageController(initialPage: initialPage);
    BaseViewModel viewModel = BaseViewModel();
    viewModel.showLoginAnimate((SignInData data) {
      ///MARK: 如果需要顯示的時候
      // viewModel.pushOpacityPage(
      //     context,
      //     FullAnimationPage(
      //         limitTimer: 2,
      //         animationPath: viewModel.getLoginTimeAnimationPath(),
      //         nextOpacityPage: true,
      //         isPushNextPage: true,
      //         nextPage: SignInPage(data: data)));
    });
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
          PersonalMainView(),
          HomeMainView(),
          LoginMainView()
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
      case AppNavigationBarType.typePersonal:
        return 4;
      case AppNavigationBarType.typeMain:
        return 5;
      case AppNavigationBarType.typeLogin:
        return 6;
    }
  }

  void _serverAction() {}

  void _avatarAction() {
    setState(() {
      if (BaseViewModel().isLogin()) {
        GlobalData.mainBottomType = AppNavigationBarType.typePersonal;
      } else {
        GlobalData.mainBottomType = AppNavigationBarType.typeLogin;
      }
      pageController.jumpToPage(getViewIndex(GlobalData.mainBottomType));
    });
  }

  void _globalAction() async {
    await BaseViewModel().pushPage(context, SettingLanguagePage());
    print('setState');
    setState(() {});
  }

  void _mainAction() {
    setState(() {
      GlobalData.mainBottomType = AppNavigationBarType.typeMain;
      pageController.jumpToPage(getViewIndex(GlobalData.mainBottomType));
    });
  }
}
