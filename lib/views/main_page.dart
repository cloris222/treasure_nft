// ignore_for_file: use_build_context_synchronously

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/utils/animation_download_util.dart';
import 'package:treasure_nft_project/utils/observer_pattern/custom/language_observer.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/collection/collection_main_view.dart';
import 'package:treasure_nft_project/views/explore/explore_main_view.dart';
import 'package:treasure_nft_project/views/login/login_main_view.dart';
import 'package:treasure_nft_project/views/personal/personal_main_view.dart';
import 'package:treasure_nft_project/views/server_web_page.dart';
import 'package:treasure_nft_project/views/setting_language_page.dart';
import 'package:treasure_nft_project/views/sigin_in_page.dart';
import 'package:treasure_nft_project/views/trade/trade_new_main_view.dart';
import 'package:treasure_nft_project/views/wallet/wallet_main_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/dialog/app_version_update_dialog.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

import '../constant/app_routes.dart';
import '../constant/global_data.dart';
import '../constant/ui_define.dart';
import '../models/http/api/announce_api.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import 'announcement/announcement_dialog_page.dart';
import 'announcement/announcement_main_page.dart';
import 'full_animation_page.dart';
import 'home/home_main_view.dart';

class MainPage extends StatefulWidget {
  const MainPage(
      {Key? key, this.type = AppNavigationBarType.typeMain, this.walletInfo})
      : super(key: key);
  final AppNavigationBarType type;
  final WalletInfo? walletInfo;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController pageController;
  BaseViewModel viewModel = BaseViewModel();
  String _authStatus = 'Unknown';
  late LanguageObserver languageObserver;

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
    if (GlobalData.firstLaunch) {
      GlobalData.firstLaunch = false;
      AnimationDownloadUtil().init();
    }
    languageObserver = LanguageObserver(SubjectKey.keyChangeLanguage,
        onNotify: (notification) {
      if (mounted) {
        if (notification.data) {
          viewModel.pushAndRemoveUntil(
              context, MainPage(type: GlobalData.mainBottomType));
        } else {
          setState(() {});
        }
      }
    });
    GlobalData.languageSubject.registerObserver(languageObserver);
  }

  Future<void> initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => _authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() => _authStatus = '$status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    GlobalData.printLog("UUID: $uuid");
  }

  void showAnimateView() {
    if (GlobalData.needUpdateApp) {
      AppVersionUpdateDialog(context).show();
    } else {
      ///MARK: 代表手機自動登入
      String? path = AnimationDownloadUtil()
          .getAnimationFilePath(viewModel.getLoginTimeAnimationPath());
      if (GlobalData.showLoginAnimate && path != null) {
        GlobalData.showLoginAnimate = false;
        viewModel
            .pushOpacityPage(
                context,
                FullAnimationPage(
                    isFile: true,
                    limitTimer: 3,
                    animationPath: path,
                    nextOpacityPage: true,
                    isPushNextPage: true))
            .then((value) {
          showSignView();
        });
      } else {
        GlobalData.showLoginAnimate = false;
        showSignView();
      }
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
    GlobalData.languageSubject.unregisterObserver(languageObserver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar.mainAppBar(
          isMainPage: true,
          serverAction: _serverAction,
          globalAction: _globalAction,
          mainAction: _mainAction,
          airdropAction: _airdropAction,
          announcementAction: _announcementAction),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),

              ///MARK: 不要放const
              children: [
                // ignore: prefer_const_constructors
                ExploreMainView(),
                // ignore: prefer_const_constructors
                CollectionMainView(),
                // ignore: prefer_const_constructors
                TradeNewMainView(),
                WalletMainView(onPrePage: _onPrePage),
                // ignore: prefer_const_constructors
                PersonalMainView(),
                // ignore: prefer_const_constructors
                HomeMainView(),
                LoginMainView(preWalletInfo: widget.walletInfo)
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
    checkLastAnnounce(type);
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
    await BaseViewModel()
        .pushPage(context, const SettingLanguagePage(isMainPage: true));
    setState(() {});
  }

  void _mainAction() {
    setState(() {
      viewModel.setCurrentBottomType(AppNavigationBarType.typeMain);
      pageController.jumpToPage(getViewIndex(GlobalData.mainBottomType));
      checkLastAnnounce(AppNavigationBarType.typeMain);
    });
  }

  void _onPrePage() {
    setState(() {
      pageController.jumpToPage(getViewIndex(viewModel.getPreBottomType()));
    });
  }

  void _airdropAction() {
    BaseViewModel viewModel = BaseViewModel();
    if (viewModel.isLogin()) {
      AppRoutes.pushAirdrop(context);
    } else {
      viewModel.pushAndRemoveUntil(
          context, const MainPage(type: AppNavigationBarType.typeLogin));
    }
  }

  void _announcementAction() {
    BaseViewModel().isLogin()
        ? BaseViewModel().pushPage(context, const AnnouncementMainPage())
        : BaseViewModel().pushPage(context, const MainPage(type: AppNavigationBarType.typeLogin));
  }

  void checkLastAnnounce(AppNavigationBarType type) {
    if (GlobalData.userToken.isNotEmpty) {
      if(getViewIndex(type) == 5||getViewIndex(type)==2){
        BaseViewModel().showNoticeView(BaseViewModel().getGlobalContext(),false);
      }
    }
  }
}
