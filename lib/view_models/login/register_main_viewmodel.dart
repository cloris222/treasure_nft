// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/login_enum.dart';
import 'package:treasure_nft_project/models/http/api/auth_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/data/validate_result_data.dart';
import '../../models/http/api/login_api.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';

class RegisterMainViewModel extends BaseViewModel {
  RegisterMainViewModel({required this.setState});

  final ViewChange setState;

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailCodeController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  ValidateResultData accountData = ValidateResultData();
  ValidateResultData passwordData = ValidateResultData();
  ValidateResultData rePasswordData = ValidateResultData();
  ValidateResultData emailData = ValidateResultData();
  ValidateResultData emailCodeData = ValidateResultData();
  ValidateResultData nicknameData = ValidateResultData();
  ValidateResultData referralData = ValidateResultData();

  ///是否判斷過驗證碼
  bool checkEmail = false;

  void dispose() {
    accountController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    emailController.dispose();
    emailCodeController.dispose();
    nicknameController.dispose();
    referralController.dispose();
  }

  bool checkEmptyController() {
    return accountController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        emailCodeController.text.isNotEmpty;
  }

  bool checkData() {
    return accountData.result &&
        passwordData.result &&
        rePasswordData.result &&
        emailData.result &&
        emailCodeData.result;
  }

  void resetData() {
    accountData = ValidateResultData();
    passwordData = ValidateResultData();
    rePasswordData = ValidateResultData();
    emailData = ValidateResultData();
    emailCodeData = ValidateResultData();
    nicknameData = ValidateResultData();
    referralData = ValidateResultData();
  }

  bool checkPress() {
    return checkEmptyController() && checkData();
  }

  /// MARK: 檢查驗證碼是否正確
  void onPressCheckVerify(BuildContext context) async {
    if (emailCodeController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      await AuthAPI(
              onConnectFail: (message) => onBaseConnectFail(context, message))
          .checkAuthCodeMail(
              mail: emailController.text,
              action: LoginAction.register,
              authCode: emailCodeController.text);
      SimpleCustomDialog(context).show();
    }
  }

  ///MARK: 寄出驗證碼
  void onPressSendCode(BuildContext context) async {
    if (emailController.text.isNotEmpty) {
      await AuthAPI(
              onConnectFail: (message) => onBaseConnectFail(context, message))
          .sendAuthRegisterMail(mail: emailController.text);
      SimpleCustomDialog(context, mainText: tr('pleaseGotoMailboxReceive'))
          .show();
    }
  }

  ///MARK: 註冊
  void onPressRegister(BuildContext context) {
    ///MARK: 檢查是否有欄位未填
    if (!checkEmptyController()) {
      setState(() {
        accountData =
            ValidateResultData(result: accountController.text.isNotEmpty);
        passwordData =
            ValidateResultData(result: passwordController.text.isNotEmpty);
        rePasswordData =
            ValidateResultData(result: rePasswordController.text.isNotEmpty);
        emailData = ValidateResultData(result: emailController.text.isNotEmpty);
        emailCodeData =
            ValidateResultData(result: emailCodeController.text.isNotEmpty);
      });
      return;
    }

    ///MARK: 檢查是否驗證過信箱
    else if (checkEmail) {
      return;
    } else {
      LoginAPI(onConnectFail: (message) => onBaseConnectFail(context, message))
          .register(
              account: accountController.text, email: emailController.text)
          .then((value) async {
        SimpleCustomDialog(context).show();
      });
    }
  }

  ///MARK: 切換到登入頁面
  void onPressLogin(BuildContext context) {
    popPage(context);
  }

  void onTap() {
    setState(() {
      resetData();
    });
  }
}
