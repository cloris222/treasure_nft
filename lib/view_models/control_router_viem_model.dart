import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

import '../views/main_page.dart';
import '../views/wallet_connect_page.dart';
import 'base_view_model.dart';

class ControlRouterViewModel {
  ///MARK: 推頁面 偷懶用
  void popPage(BuildContext context) {
    Navigator.pop(context);
  }

  ///MARK: 推新的一頁
  Future<void> pushPage(BuildContext context, Widget page) async {
    checkLastAnnounce();
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  ///MARK: 取代當前頁面
  Future<void> pushReplacement(BuildContext context, Widget page) async {
    checkLastAnnounce();
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  ///MARK: 將前面的頁面全部清除只剩此頁面
  Future<void> pushAndRemoveUntil(BuildContext context, Widget page) async {
    await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => page),
      (route) => false,
    );
  }

  ///MARK: 全域切頁面
  Future<void> globalPushAndRemoveUntil(Widget page) async {
    GlobalData.globalKey.currentState?.pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (BuildContext context) => page),
      (route) => false,
    );
  }

  ///MARK: 返回前頁
  Future<void> popPreView(BuildContext context) async {
    await Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              MainPage(type: getPreBottomType())),
      (route) => false,
    );
  }

  void setCurrentBottomType(AppNavigationBarType type) {
    ///MARK:判斷是否為最後一筆
    if (!GlobalData.isPrePage) {
      GlobalData.isPrePage = false;
    }
    if (GlobalData.preTypeList.isNotEmpty) {
      ///MARK: 最後一頁跟前一頁一樣 就不加入
      if (GlobalData.mainBottomType != GlobalData.preTypeList.last) {
        GlobalData.preTypeList.add(GlobalData.mainBottomType);

        ///MARK: 最多只接受10筆
        if (GlobalData.preTypeList.length > 10) {
          GlobalData.preTypeList.removeAt(0);
        }
      }
    } else {
      GlobalData.preTypeList.add(GlobalData.mainBottomType);
    }
    GlobalData.mainBottomType = type;
  }

  AppNavigationBarType getPreBottomType() {
    AppNavigationBarType preType = AppNavigationBarType.typeMain;
    if (GlobalData.preTypeList.isNotEmpty) {
      preType = GlobalData.preTypeList.removeLast();
      if (preType == AppNavigationBarType.typeLogin &&
          BaseViewModel().isLogin()) {
        preType = AppNavigationBarType.typeMain;
      }
    }
    GlobalData.mainBottomType = preType;
    return preType;
  }

  Future<void> pushOtherPersonalInfo(
      BuildContext context, String userId) async {
    // test
    // await pushPage(context, OtherPersonInfoPage(userId: userId));
  }

  ///MARK: 推透明的頁面
  Future<void> pushOpacityPage(BuildContext context, Widget page) async {
    await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        },
        opaque: false));
  }

  Future<WalletInfo?> pushWalletConnectPage(
    BuildContext context, {
    required String subTitle,
    required bool needVerifyAPI,
    bool showBindSuccess = false,
  }) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WalletConnectPage(
                subTitle: subTitle,
                needVerifyAPI: needVerifyAPI,
                showBindSuccess: showBindSuccess)));
  }

  void checkLastAnnounce() {
    if (GlobalData.userToken.isNotEmpty) {
      BaseViewModel().showNoticeView(BaseViewModel().getGlobalContext(), true);
    }
  }
}
