// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/data/validate_result_data.dart';
import 'package:treasure_nft_project/models/http/api/login_api.dart';
import 'package:treasure_nft_project/utils/animation_download_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';
import 'package:treasure_nft_project/view_models/login/wallet_bind_view_model.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

import '../../constant/call_back_function.dart';
import '../../views/full_animation_page.dart';
import '../../views/login/forgot_main_page.dart';
import '../../views/login/register_main_page.dart';
import '../../views/main_page.dart';

class LoginMainViewModel extends BaseViewModel {
  LoginMainViewModel({required this.setState});

  final ViewChange setState;
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValidateResultData accountData = ValidateResultData();
  ValidateResultData passwordData = ValidateResultData();

  void dispose() {
    accountController.dispose();
    passwordController.dispose();
  }

  bool checkEmptyController() {
    return accountController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  bool checkData() {
    return accountData.result && passwordData.result;
  }

  bool loginWait = false;

  void onPressLogin(BuildContext context, WidgetRef ref, WalletInfo? walletInfo) async {
    if (!loginWait) {
      if (!checkEmptyController()) {
        setState(() {
          accountData = ValidateResultData(result: accountController.text.isNotEmpty);
          passwordData = ValidateResultData(result: passwordController.text.isNotEmpty);
        });
        loginWait = false;
        return;
      }
      showLoadingPage(context);
      /// 將執行的程序往前
      scheduleMicrotask(()async {
      try {
        ///MARK: 註冊API
        await LoginAPI().login(account: accountController.text, password: passwordController.text, isWallet: false).then((value) async {
          String? path = AnimationDownloadUtil().getAnimationFilePath(getLoginTimeAnimationPath());
          if (path != null) {
            pushOpacityPage(
                context,
                FullAnimationPage(
                    limitTimer: 3,
                    isFile: true,
                    animationPath: path,
                    runFunction: () async {
                      await saveUserLoginInfo(response: value, ref: ref, isLogin: true);

                      ///MARK:代表需要進行錢包綁定
                      if (walletInfo != null) {
                        await WalletBindViewModel().bindWallet(context, ref, walletInfo, ref.read(userInfoProvider));
                      }
                      startUserListener();
                    },
                    nextPage: const MainPage(type: AppNavigationBarType.typeMain)));
          } else {
            await saveUserLoginInfo(response: value, ref: ref, isLogin: true);
            startUserListener();
            pushAndRemoveUntil(context, const MainPage(type: AppNavigationBarType.typeMain));
          }
        });
      } catch (e) {}
      setState(() {
        loginWait = false;
      });
      closeLoadingPage();
      });
    }
  }

  void onWalletLogin(
      BuildContext context, WidgetRef ref, WalletInfo? walletInfo) async {
    if (!loginWait) {
      loginWait = true;
      await WalletBindViewModel().loginWithWallet(context, ref, walletInfo);
      loginWait = false;
    }
  }

  void onPressRegister(BuildContext context) {
    pushPage(context, const RegisterMainPage());
  }

  onPressForgot(BuildContext context) {
    pushPage(context, const ForgotMainPage());
  }

  void onTap() {
    setState(() {
      accountData = ValidateResultData();
      passwordData = ValidateResultData();
    });
  }
}
