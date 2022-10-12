import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../models/data/validate_result_data.dart';

class RegisterMainViewModel extends BaseViewModel {
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

  bool checkController() {
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
    return checkController() && checkData();
  }

  /// MARK: 檢查驗證碼是否正確
  void onPressCheckVerify() {}

  ///MARK: 寄出驗證碼
  void onPressSendCode() {}

  ///MARK: 註冊
  void onPressRegister() {}

  ///MARK: 切換到登入頁面
  void onPressLogin() {}
}
