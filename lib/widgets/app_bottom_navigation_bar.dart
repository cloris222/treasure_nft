import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/theme/app_image_path.dart';
import '../views/main_page.dart';

//TODO: 定義主分頁類型
enum AppNavigationBarType {
  typeExplore,
  typeCollection,
  typeTrade,
  typeWallet,
  typeAccount
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
  late AppNavigationBarType currentType;

  @override
  void initState() {
    super.initState();
    currentType = widget.initType;
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
    bool isSelect = (currentType == type);
    double sizeWidth = MediaQuery.of(context).size.width / 20;
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
      case AppNavigationBarType.typeAccount:
        {
          asset = isSelect
              ? AppImagePath.mainTypeAccount
              : AppImagePath.mainTypeAccountOFF;
        }
        break;
    }

    return Image.asset(asset,
        fit: BoxFit.contain, width: sizeWidth, height: sizeWidth);
  }

  _navigationTapped(int index, void Function(VoidCallback fn) setState) {
    currentType = AppNavigationBarType.values[index];
    if (widget.bottomFunction != null) {
      setState(() {
        widget.bottomFunction!(currentType, index);
      });
    } else {
      //清除所有頁面並回到首頁
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => MainPage(type: currentType)),
        ModalRoute.withName('/'),
      );
    }
  }
}
