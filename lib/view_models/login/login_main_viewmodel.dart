// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/models/data/validate_result_data.dart';
import 'package:treasure_nft_project/models/http/api/login_api.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../constant/call_back_function.dart';
import '../../utils/stomp_socket_util.dart';
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

  void onPressLogin(BuildContext context) {
    if (!checkEmptyController()) {
      setState(() {
        accountData =
            ValidateResultData(result: accountController.text.isNotEmpty);
        passwordData =
            ValidateResultData(result: passwordController.text.isNotEmpty);
      });
      return;
    } else {
      ///MARK: 註冊API
      LoginAPI(onConnectFail: (message) => onBaseConnectFail(context, message))
          .login(
              account: accountController.text,
              password: passwordController.text)
          .then((value) async {
        pushOpacityPage(
            context,
            FullAnimationPage(
                limitTimer: 2,
                animationPath: getLoginTimeAnimationPath(),
                runFunction: () async {
                  await saveUserLoginInfo(response: value);
                  StompSocketUtil().connect();
                },
                nextPage: const MainPage(type: AppNavigationBarType.typeMain)));
      });
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
