// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/http/parameter/api_response.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

import '../../constant/global_data.dart';
import '../../models/http/api/login_api.dart';
import '../../models/http/api/user_info_api.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../utils/animation_download_util.dart';
import '../../views/full_animation_page.dart';
import '../../views/main_page.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../../widgets/dialog/common_custom_dialog.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';
import '../../widgets/dialog/wallet_login_hint_dialog.dart';
import '../gobal_provider/user_info_provider.dart';

class WalletBindViewModel extends BaseViewModel {
  Future<bool> registerWithWallet(BuildContext context, WidgetRef ref,
      {required WalletInfo? walletInfo, required String inviteCode}) async {
    clearAllFocus();
    GlobalData.printLog('registerWithWallet=========');
    GlobalData.printLog('walletInfo.address:${walletInfo?.address}');
    GlobalData.printLog('walletInfo.personalSign:${walletInfo?.personalSign}');
    if (walletInfo != null) {
      if (walletInfo.personalSign.isNotEmpty) {
        try {
          bool isAddressRegister =
              await checkWalletAddress(walletInfo, (message) {});
          if (isAddressRegister) {
            showDoubleBindWalletDialog(context);
            return false;
          }
          await LoginAPI(
              onConnectFail: (message) =>
                  onBaseConnectFail(context, message)).register(
              account: '',
              password: '',
              email: '',
              phone: '',
              nickname: '',
              inviteCode: inviteCode,
              country: '',
              emailVerifyCode: '',
              walletInfo: walletInfo);
          String? path = AnimationDownloadUtil()
              .getAnimationFilePath(getLoginTimeAnimationPath());
          if (path != null) {
            pushOpacityPage(
                context,
                FullAnimationPage(
                  limitTimer: 3,
                  animationPath: path,
                  isFile: true,
                  nextPage: const MainPage(),
                  runFunction: () async {
                    await _updateRegisterInfoWithWallet(
                        ref: ref, isLogin: true, walletInfo: walletInfo);
                  },
                ));
          } else {
            await _updateRegisterInfoWithWallet(
                ref: ref, isLogin: true, walletInfo: walletInfo);
          }
          return true;
        } catch (e) {}
      }
    }
    showBindWalletFailDialog(context);
    return false;
  }

  ///更新使用者資料
  Future<void> _updateRegisterInfoWithWallet(
      {required WidgetRef ref,
      required bool isLogin,
      required WalletInfo walletInfo}) async {
    var response = await LoginAPI().login(
        account: walletInfo.address,
        password: walletInfo.personalSign,
        isWallet: true);
    await saveUserLoginInfo(response: response, ref: ref, isLogin: isLogin);
    startUserListener();
  }

  Future<bool> bindWallet(BuildContext context, WidgetRef ref,
      WalletInfo? walletInfo, UserInfoData userInfo) async {
    GlobalData.printLog('bindWallet=========');
    GlobalData.printLog('walletInfo.address:${walletInfo?.address}');
    GlobalData.printLog('walletInfo.personalSign:${walletInfo?.personalSign}');
    if (walletInfo != null) {
      if (walletInfo.personalSign.isNotEmpty) {
        try {
          bool isAddressRegister =
              await checkWalletAddress(walletInfo, (message) {});
          if (isAddressRegister) {
            showDoubleBindWalletDialog(context);
            return false;
          }
          if (userInfo.address.isNotEmpty) {
            showDoubleBindAccountDialog(context);
            return false;
          }
          await UserInfoAPI(
              onConnectFail: (message) =>
                  onBaseConnectFail(context, message)).updatePersonInfo(
              name: userInfo.name,
              phoneCountry: userInfo.phoneCountry,
              phone: userInfo.phone,
              password: '',
              oldPassword: '',
              gender: userInfo.gender,
              birthday: userInfo.birthday,
              address: walletInfo.address,
              signature: walletInfo.personalSign);
          ref.read(userInfoProvider).address = walletInfo.address;
          ref.read(userInfoProvider.notifier).setSharedPreferencesValue();
          ref.read(userInfoProvider.notifier).update();
          showBindSuccess(context);
          return true;
        } catch (e) {}
      }
    }
    showBindWalletFailDialog(context);
    return false;
  }

  Future<bool> loginWithWallet(
      BuildContext context, WidgetRef ref, WalletInfo? walletInfo) async {
    GlobalData.printLog('walletLogin=========');
    GlobalData.printLog('walletInfo.address:${walletInfo?.address}');
    GlobalData.printLog('walletInfo.personalSign:${walletInfo?.personalSign}');
    if (walletInfo != null) {
      if (walletInfo.personalSign.isNotEmpty) {
        bool isAddressRegister =
            await checkWalletAddress(walletInfo, (message) {});
        if (isAddressRegister) {
          try {
            ///MARK: 登入API
            ApiResponse value = await LoginAPI(
                onConnectFail: (message) =>
                    onBaseConnectFail(context, message)).login(
                account: walletInfo.address,
                password: walletInfo.personalSign,
                isWallet: true);
            String? path = AnimationDownloadUtil()
                .getAnimationFilePath(getLoginTimeAnimationPath());
            if (path != null) {
              pushOpacityPage(
                  context,
                  FullAnimationPage(
                      limitTimer: 3,
                      isFile: true,
                      animationPath: path,
                      runFunction: () async {
                        await saveUserLoginInfo(
                            response: value, ref: ref, isLogin: true);
                        startUserListener();
                      },
                      nextPage:
                          const MainPage(type: AppNavigationBarType.typeMain)));
            } else {
              await saveUserLoginInfo(response: value, ref: ref, isLogin: true);
              startUserListener();
              pushAndRemoveUntil(
                  context, const MainPage(type: AppNavigationBarType.typeMain));
            }
            return true;
          } catch (e) {}
        } else {
          WalletLoginHintDialog(context, walletInfo: walletInfo).show();
          return false;
        }
      }
    }
    showBindWalletFailDialog(context);
    return false;
  }

  void showBindSuccess(BuildContext context) {
    SimpleCustomDialog(context, mainText: tr('appBindSuccess')).show();
  }

  ///地址已被綁定
  void showDoubleBindWalletDialog(BuildContext context) {
    CommonCustomDialog(context,
        type: DialogImageType.fail,
        title: tr('appBindFail'),
        rightBtnText: tr('confirm'),
        content: tr('address-bounded-hint'),
        onLeftPress: () {}, onRightPress: () {
      popPage(context);
    }).show();
  }

  ///帳號已綁定地址
  void showDoubleBindAccountDialog(BuildContext context) {
    CommonCustomDialog(context,
        type: DialogImageType.fail,
        title: tr('appBindFail'),
        rightBtnText: tr('confirm'),
        content: tr('appBindAccountHint'),
        onLeftPress: () {}, onRightPress: () {
      popPage(context);
    }).show();
  }

  ///錢包取得簽證失敗
  void showBindWalletFailDialog(BuildContext context) {
    if (!GlobalData.passBindWalletAction) {
      CommonCustomDialog(context,
          type: DialogImageType.fail,
          title: tr('appBindFail'),
          rightBtnText: tr('confirm'),
          content: tr('appBindFailHint'),
          onLeftPress: () {}, onRightPress: () {
        popPage(context);
      }).show();
    }
  }
}
