import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import '../constant/theme/app_image_path.dart';
import '../views/login/login_main_page.dart';
import '../views/main_page.dart';

//MARK: 定義主分頁類型
enum AppNavigationBarType {
  typeExplore,
  typeCollection,
  typeTrade,
  typeWallet,
  typeAccount,
  typeNull
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Center(child: getIcon(AppNavigationBarType.typeExplore)),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Center(child: getIcon(AppNavigationBarType.typeCollection)),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: getIcon(AppNavigationBarType.typeTrade),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Center(child: getIcon(AppNavigationBarType.typeWallet)),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Center(child: getIcon(AppNavigationBarType.typeAccount)),
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
      case AppNavigationBarType.typeAccount:
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

    ///MARK: 未登入
    if ((GlobalData.mainBottomType != AppNavigationBarType.typeNull &&
            GlobalData.mainBottomType != AppNavigationBarType.typeExplore) &&
        false) {
      GlobalData.mainBottomType = AppNavigationBarType.typeNull;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginMainPage()));
    } else {
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
}
