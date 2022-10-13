// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/data/validate_result_data.dart';
import 'package:treasure_nft_project/models/http/api/login_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../constant/call_back_function.dart';
import '../../constant/global_data.dart';
import '../../views/login/forgot_main_page.dart';
import '../../views/login/register_main_page.dart';
import '../../views/main_page.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';

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
        value.printLog();
        await saveUserLoginInfo(response: value);
        GlobalData.mainBottomType = AppNavigationBarType.typeMain;
        pushAndRemoveUntil(context, MainPage(type: GlobalData.mainBottomType));
        SimpleCustomDialog(context, mainText: 'OK').show();
      });
    }
  }

  void onPressRegister(BuildContext context) {
    pushPage(context, const RegisterMainPage());
  }

  onPressForgot(BuildContext context) {
    pushPage(context, const ForgotMainPage());
  }
}
