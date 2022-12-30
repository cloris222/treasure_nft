import 'dart:async';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../view_models/base_view_model.dart';
import '../views/main_page.dart';
import 'changenotifiers/bottom_navigation_notifier.dart';

//MARK: 定義主分頁類型
enum AppNavigationBarType {
  typeExplore,
  typeCollection,
  typeTrade,
  typeWallet,
  typePersonal,
  typeMain,
  typeLogin,
}

typedef AppBottomFunction = Function(AppNavigationBarType type);

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar(
      {Key? key,
      required this.initType,
      this.bottomFunction,
      this.bStartTimer = false})
      : super(key: key);

  final bool bStartTimer;
  final AppNavigationBarType initType;
  final AppBottomFunction? bottomFunction;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar>
    with WidgetsBindingObserver {
  Timer? timer;
  late BottomNavigationNotifier _bottomNavigationNotifier; // 收藏未讀數監聽

  @override
  void initState() {
    super.initState();
    GlobalData.mainBottomType = widget.initType;
    _requestUnreadCollection();
    _unreadTimingRequest();

    /// 生命週期
    WidgetsBinding.instance.addObserver(this);

    _bottomNavigationNotifier = GlobalData.bottomNavigationNotifier;
    _bottomNavigationNotifier
        .addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  void dispose() {
    timer?.cancel();
    _bottomNavigationNotifier.removeListener(() {});
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        GlobalData.printLog('-----App onResumed------');
        _requestUnreadCollection();
        _unreadTimingRequest();
        break;

      case AppLifecycleState.paused:
        GlobalData.printLog('-----App paused------');
        timer?.cancel();
        break;

      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
    }
  }

  void _requestUnreadCollection() {
    BaseViewModel().requestUnreadCollection().then((value) {
      if (value > 0) {
        // 未讀數
        setState(() {
          _bottomNavigationNotifier.unreadCount = value.toInt();
        });
      }
    });
  }

  void _unreadTimingRequest() {
    if (widget.bStartTimer) {
      timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (GlobalData.userToken.isNotEmpty) {
          _requestUnreadCollection();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _barBuilder(context);
  }

  Widget _barBuilder(BuildContext context) {
    return Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        color: AppColors.textWhite,
        margin: EdgeInsets.symmetric(
            horizontal: UIDefine.getPixelWidth(40),
            vertical: UIDefine.getPixelHeight(20)),
        child: Row(
          children: [
            buildButton(AppNavigationBarType.typeExplore),
            buildButton(AppNavigationBarType.typeCollection),
            buildButton(AppNavigationBarType.typeTrade),
            buildButton(AppNavigationBarType.typeWallet),
            buildButton(AppNavigationBarType.typePersonal),
          ],
        ));
  }

  Widget buildButton(AppNavigationBarType type) {
    return Expanded(
        child: GestureDetector(
            onTap: () => _navigationTapped(
                AppNavigationBarType.values.indexOf(type), setState),
            child: Stack(
              children: [
                SizedBox(
                  width: UIDefine.getWidth(),
                  height: UIDefine.getPixelWidth(56),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [getIcon(type)]),
                ),
                Positioned(
                    right: UIDefine.getPixelWidth(5),
                    top: UIDefine.getPixelWidth(5),
                    child: Opacity(
                      opacity: (_bottomNavigationNotifier.unreadCount > 0 &&
                              type == AppNavigationBarType.typeCollection)
                          ? 1.0
                          : 0.0,
                      child: Container(
                        alignment: Alignment.center,
                        width: UIDefine.getScreenWidth(5),
                        height: UIDefine.getScreenWidth(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.textRed),
                        child: Text(
                          _bottomNavigationNotifier.unreadCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: UIDefine.fontSize8,
                          ),
                        ),
                      ),
                    ))
              ],
            )));
  }

  Widget getIcon(AppNavigationBarType type) {
    bool isSelect = (GlobalData.mainBottomType == type);
    String asset;
    switch (type) {
      case AppNavigationBarType.typeExplore:
        {
          asset = isSelect
              ? AppImagePath.mainTypeExplore
              : AppImagePath.mainTypeExploreOFF;
        }
        break;
      case AppNavigationBarType.typeCollection:
        {
          asset = isSelect
              ? AppImagePath.mainTypeCollection
              : AppImagePath.mainTypeCollectionOFF;
        }
        break;
      case AppNavigationBarType.typeTrade:
        {
          asset = isSelect
              ? AppImagePath.mainTypeTrade
              : AppImagePath.mainTypeTradeOFF;
        }
        break;
      case AppNavigationBarType.typeWallet:
        {
          asset = isSelect
              ? AppImagePath.mainTypeWallet
              : AppImagePath.mainTypeWalletOFF;
        }
        break;
      case AppNavigationBarType.typePersonal:
        {
          asset = isSelect
              ? AppImagePath.mainTypeAccount
              : AppImagePath.mainTypeAccountOFF;
        }
        break;
      default:
        {
          asset = '';
        }
        break;
    }

    return Image.asset(asset,
        height: UIDefine.getPixelWidth(25), fit: BoxFit.fitHeight);
  }

  _navigationTapped(int index, void Function(VoidCallback fn) setState) {
    GlobalData.mainBottomType = AppNavigationBarType.values[index];
    if ((GlobalData.mainBottomType != AppNavigationBarType.typeMain &&
            GlobalData.mainBottomType != AppNavigationBarType.typeExplore) &&
        !BaseViewModel().isLogin()) {
      index = 6;
      GlobalData.mainBottomType = AppNavigationBarType.typeLogin;
    }

    if (widget.bottomFunction != null) {
      setState(() {
        widget.bottomFunction!(GlobalData.mainBottomType);
      });
    } else {
      //清除所有頁面並回到首頁
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                MainPage(type: GlobalData.mainBottomType)),
        ModalRoute.withName('/'),
      );
    }
  }
}
