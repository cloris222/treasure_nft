// ignore_for_file: use_build_context_synchronously

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/collection/collection_main_view.dart';
import 'package:treasure_nft_project/views/explore/explore_main_view.dart';
import 'package:treasure_nft_project/views/login/login_main_view.dart';
import 'package:treasure_nft_project/views/personal/personal_main_view.dart';
import 'package:treasure_nft_project/views/server_web_page.dart';
import 'package:treasure_nft_project/views/setting_language_page.dart';
import 'package:treasure_nft_project/views/sigin_in_page.dart';
import 'package:treasure_nft_project/views/trade/trade_main_view.dart';
import 'package:treasure_nft_project/views/wallet/wallet_main_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../constant/global_data.dart';
import '../constant/ui_define.dart';
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
  BaseViewModel viewModel = BaseViewModel();
  String _authStatus = 'Unknown';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UIDefine.initial(MediaQuery.of(context));
  }

  @override
  void initState() {
    super.initState();
    initPlugin();
    int initialPage = getViewIndex(widget.type);
    viewModel.setCurrentBottomType(widget.type);
    if ((GlobalData.mainBottomType != AppNavigationBarType.typeMain &&
            GlobalData.mainBottomType != AppNavigationBarType.typeExplore) &&
        !BaseViewModel().isLogin()) {
      initialPage = 6;
      viewModel.setCurrentBottomType(AppNavigationBarType.typeLogin);
    }

    pageController = PageController(initialPage: initialPage);
    Future.delayed(const Duration(seconds: 2))
        .then((value) => showAnimateView());
  }

  Future<void> initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => _authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() => _authStatus = '$status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    GlobalData.printLog("UUID: $uuid");
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing ads. '
            'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
            'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      );

  void showAnimateView() {
    ///MARK: 代表手機自動登入
    if (GlobalData.showLoginAnimate) {
      GlobalData.showLoginAnimate = false;
      viewModel
          .pushOpacityPage(
              context,
              FullAnimationPage(
                  limitTimer: 3,
                  animationPath: viewModel.getLoginTimeAnimationPath(),
                  nextOpacityPage: true,
                  isPushNextPage: true))
          .then((value) {
        showSignView();
      });
    } else {
      showSignView();
    }
  }

  void showSignView() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (GlobalData.signInInfo != null) {
        viewModel
            .pushOpacityPage(
                context,
                SignInPage(
                  data: GlobalData.signInInfo!,
                ))
            .then((value) => viewModel.setSignIn(context));
      }
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar.mainAppBar(
          serverAction: _serverAction,
          globalAction: _globalAction,
          mainAction: _mainAction),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const ExploreMainView(),
                const CollectionMainView(),
                const TradeMainView(),
                WalletMainView(onPrePage: _onPrePage),
                PersonalMainView(onViewChange: () => setState(() {})),
                const HomeMainView(),
                const LoginMainView()
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: AppBottomNavigationBar(
                initType: GlobalData.mainBottomType,
                bottomFunction: _changePage,
                bStartTimer: true,
              ))
        ],
      ),
      extendBody: true,
    );
  }

  _changePage(AppNavigationBarType type) {
    viewModel.setCurrentBottomType(type);
    pageController.jumpToPage(getViewIndex(type));
  }

  void _searchAction() {
    viewModel.setCurrentBottomType(AppNavigationBarType.typeExplore);
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

  void _serverAction() {
    viewModel.pushPage(context, const ServerWebPage());
    // viewModel.pushPage(context, const SplashScreenPage());
  }

  void _avatarAction() {
    setState(() {
      if (BaseViewModel().isLogin()) {
        viewModel.setCurrentBottomType(AppNavigationBarType.typePersonal);
      } else {
        viewModel.setCurrentBottomType(AppNavigationBarType.typeLogin);
      }
      pageController.jumpToPage(getViewIndex(GlobalData.mainBottomType));
    });
  }

  void _globalAction() async {
    await BaseViewModel().pushPage(context, const SettingLanguagePage());
    setState(() {});
  }

  void _mainAction() {
    setState(() {
      viewModel.setCurrentBottomType(AppNavigationBarType.typeMain);
      pageController.jumpToPage(getViewIndex(GlobalData.mainBottomType));
    });
  }

  void _onPrePage() {
    setState(() {
      pageController.jumpToPage(getViewIndex(viewModel.getPreBottomType()));
    });
  }
}
