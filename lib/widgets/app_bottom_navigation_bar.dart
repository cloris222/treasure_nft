import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/theme/app_style.dart';
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
      {Key? key, required this.initType, this.bottomFunction, this.bStartTimer = false})
      : super(key: key);

  final bool bStartTimer;
  final AppNavigationBarType initType;
  final AppBottomFunction? bottomFunction;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> with WidgetsBindingObserver {

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
    _bottomNavigationNotifier.addListener(() => mounted ? setState(() {}) : null);
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
      if (value > 0) { // 未讀數
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
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: SizedBox(
            height: itemHeight,
            width: UIDefine.getWidth(),
            child: Stack(alignment: Alignment.center, children: [
              ///MARK: 拉出空間
              SizedBox(width: UIDefine.getWidth(), height: itemHeight),

              ///MARK: 背後bar
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  height: itemHeight - spaceHeight,
                  color: Colors.white,
                  child: Row(
                    children: [
                      buildText(AppNavigationBarType.typeExplore),
                      buildText(AppNavigationBarType.typeCollection),
                      buildText(AppNavigationBarType.typeTrade),
                      buildText(AppNavigationBarType.typeWallet),
                      buildText(AppNavigationBarType.typePersonal),
                    ],
                  ),
                ),
              ),

              ///MARK: 正中間凸出
              Positioned(top: 0, child: _buildCenter())
            ])));
  }

  // final double itemHeight = kBottomNavigationBarHeight * 1.4;  // 78.4
  // final double spaceHeight = kBottomNavigationBarHeight * 0.35;  // 19.6
  // final double textHeight = kBottomNavigationBarHeight * 0.3;  // 16.8
  // final double iconHeight = kBottomNavigationBarHeight * 0.44;  // 24.64
  // final double paddingSpace = kBottomNavigationBarHeight * 0.12;  // 6.72
  // final double textSize = kBottomNavigationBarHeight * 0.21;  // 11.76

  final double itemHeight = UIDefine.getScreenWidth(20.9);  // 78.4
  final double spaceHeight = UIDefine.getScreenWidth(5.22);  // 19.6
  final double textHeight = UIDefine.getScreenWidth(4.48);  // 16.8
  final double iconHeight = UIDefine.getScreenWidth(6.57);  // 24.64
  final double paddingSpace = UIDefine.getScreenWidth(1.79);  // 6.72
  final double textSize = UIDefine.getScreenWidth(3.13);  // 11.76

  Widget buildText(AppNavigationBarType type) {
    return Expanded(
        child: GestureDetector(
            onTap: () => _navigationTapped(
                AppNavigationBarType.values.indexOf(type), setState),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              (type == AppNavigationBarType.typeTrade)
                  ? const SizedBox()
                  : getIcon(type),
              const SizedBox(height: 1),
              Container(child: getText(type)),
              const SizedBox(height: 2)
            ]))
    );
  }

  Widget _getCollectionIcon(bool isSelect) {
    String asset = isSelect
        ? AppImagePath.mainTypeCollection
        : AppImagePath.mainTypeCollectionOFF;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: UIDefine.getScreenWidth(2.5), right: UIDefine.getScreenWidth(2.75)),
          child:  Image.asset(asset, height: iconHeight, fit: BoxFit.fitHeight)
        ),

        Positioned(
          right: 0, top: 0,
          child: Opacity(
            opacity: _bottomNavigationNotifier.unreadCount > 0 ? 1.0 : 0.0, // 0.0=透明
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
    );
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
        return _getCollectionIcon(isSelect);

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

    return Image.asset(asset, height: iconHeight, fit: BoxFit.fitHeight);
  }

  Widget _buildCenter() {
    bool isSelect =
        (GlobalData.mainBottomType == AppNavigationBarType.typeTrade);
    return GestureDetector(
        onTap: () => _navigationTapped(
            AppNavigationBarType.values.indexOf(AppNavigationBarType.typeTrade),
            setState),
        child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.white),
            padding: EdgeInsets.only(
                left: paddingSpace, right: paddingSpace, top: paddingSpace),
            child: Container(
                decoration: isSelect
                    ? AppStyle().baseGradient(radius: 100)
                    : AppStyle().styleColorsRadiusBackground(
                        color: AppColors.transParentHalf, radius: 100),
                padding: const EdgeInsets.all(2.5),
                child: Container(
                    padding: EdgeInsets.all(paddingSpace * 0.7),
                    decoration: AppStyle().styleColorsRadiusBackground(
                        color: Colors.white, radius: 100),
                    child: Image.asset(AppImagePath.mainTypeTrade,
                        height: iconHeight * 0.95, fit: BoxFit.fitHeight)))));
  }

  Widget getText(AppNavigationBarType type) {
    String text = '';
    switch (type) {
      case AppNavigationBarType.typeExplore:
        {
          text = tr('Explore');
        }
        break;
      case AppNavigationBarType.typeCollection:
        return _getCollectionText();

      case AppNavigationBarType.typeTrade:
        {
          text = tr('Trade');
        }
        break;
      case AppNavigationBarType.typeWallet:
        {
          text = tr('Wallet');
        }
        break;
      case AppNavigationBarType.typePersonal:
        {
          text = tr('Account');
        }
        break;
      default:
        {
          text = '';
        }
        break;
    }

    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: TextStyle(
            fontSize: textSize,
            color: AppColors.barFont01,
            fontWeight: FontWeight.w400));
  }

  Widget _getCollectionText() {
    return Padding(
        padding: EdgeInsets.only(right: UIDefine.getScreenWidth(2.75)),
        child: Text(tr('Collection'),
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: textSize,
                color: AppColors.barFont01,
                fontWeight: FontWeight.w400))
    );
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
