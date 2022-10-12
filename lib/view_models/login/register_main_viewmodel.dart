import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/login_enum.dart';
import 'package:treasure_nft_project/models/http/api/auth_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../models/data/validate_result_data.dart';

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
        emailCodeController.text.isNotEmpty &&
        nicknameController.text.isNotEmpty &&
        referralController.text.isNotEmpty;
  }

  bool checkData() {
    return accountData.result &&
        passwordData.result &&
        rePasswordData.result &&
        emailData.result &&
        emailCodeData.result &&
        nicknameData.result &&
        referralData.result;
  }

  bool checkPress() {
    return checkEmptyController() && checkData();
  }

  /// MARK: 檢查驗證碼是否正確
  void onPressCheckVerify() async {
    if (emailCodeController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      await AuthAPI().checkAuthCodeMail(
          mail: emailController.text,
          action: LoginAction.register,
          authCode: emailCodeController.text);
    }
  }

  ///MARK: 寄出驗證碼
  void onPressSendCode() {}

  ///MARK: 註冊
  void onPressRegister() {
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
        nicknameData =
            ValidateResultData(result: nicknameController.text.isNotEmpty);
        referralData =
            ValidateResultData(result: referralController.text.isNotEmpty);
      });
      return;
    }
  }

  ///MARK: 切換到登入頁面
  void onPressLogin(BuildContext context) {
    popPage(context);
  }
}
