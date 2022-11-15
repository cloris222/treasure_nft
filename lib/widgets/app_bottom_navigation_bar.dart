import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/theme/app_style.dart';
import '../view_models/base_view_model.dart';
import '../views/main_page.dart';

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
      {Key? key, required this.initType, this.bottomFunction})
      : super(key: key);
  final AppNavigationBarType initType;
  final AppBottomFunction? bottomFunction;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  void initState() {
    super.initState();
    GlobalData.mainBottomType = widget.initType;
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
                bottom: 0,
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

  final double itemHeight = kBottomNavigationBarHeight * 1.4;
  final double spaceHeight = kBottomNavigationBarHeight * 0.35;
  final double textHeight = kBottomNavigationBarHeight * 0.3;
  final double iconHeight = kBottomNavigationBarHeight * 0.5;
  final double paddingSpace = kBottomNavigationBarHeight * 0.12;

  Widget buildText(AppNavigationBarType type) {
    return Expanded(
        child: GestureDetector(
            onTap: () => _navigationTapped(
                AppNavigationBarType.values.indexOf(type), setState),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              (type == AppNavigationBarType.typeTrade)
                  ? const SizedBox()
                  : getIcon(type),
              Container(child: getText(type)),
              SizedBox(height: 2)
            ])));
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
                    padding: EdgeInsets.all(paddingSpace * 0.5),
                    decoration: AppStyle().styleColorsRadiusBackground(
                        color: Colors.white, radius: 100),
                    child: Image.asset(AppImagePath.mainTypeTrade,
                        height: iconHeight, fit: BoxFit.fitHeight)))));
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
        {
          text = tr('Collection');
        }
        break;
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
            fontSize: UIDefine.fontSize12,
            color: AppColors.dialogGrey,
            fontWeight: FontWeight.w400));
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
