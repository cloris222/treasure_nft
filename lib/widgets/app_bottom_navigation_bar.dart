import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../view_models/base_view_model.dart';
import '../views/login/login_main_view.dart';
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

typedef AppBottomFunction = Function(AppNavigationBarType type, int pageIndex);

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
    return StatefulBuilder(builder: _barBuilder);
  }

  Widget _barBuilder(BuildContext context, StateSetter setState) {
    return CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: AppColors.dialogGrey,
        inactiveColor: AppColors.dialogGrey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Center(child: getIcon(AppNavigationBarType.typeExplore)),
              label: tr('Explore'),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Center(child: getIcon(AppNavigationBarType.typeCollection)),
              label: tr('Collection'),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: getIcon(AppNavigationBarType.typeTrade),
              label: tr('Trade'),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Center(child: getIcon(AppNavigationBarType.typeWallet)),
              label: tr('Wallet'),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Center(child: getIcon(AppNavigationBarType.typePersonal)),
              label: tr('Account'),
              backgroundColor: Colors.white),
        ],
        onTap: (index) {
          _navigationTapped(index, setState);
        });
  }

  Widget getIcon(AppNavigationBarType type) {
    bool isSelect = (GlobalData.mainBottomType == type);
    double sizeWidth = MediaQuery.of(context).size.width / 15;
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
          sizeWidth = MediaQuery.of(context).size.width / 5;
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
        fit: BoxFit.contain, width: sizeWidth, height: sizeWidth);
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
        widget.bottomFunction!(GlobalData.mainBottomType, index);
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
