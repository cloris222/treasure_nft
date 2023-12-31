// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/login_enum.dart';
import 'package:treasure_nft_project/models/http/api/auth_api.dart';
import 'package:treasure_nft_project/utils/regular_expression_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

import '../../constant/call_back_function.dart';
import '../../models/data/validate_result_data.dart';
import '../../models/http/api/login_api.dart';
import '../../utils/animation_download_util.dart';
import '../../views/full_animation_page.dart';
import '../../views/main_page.dart';
import '../../widgets/dialog/common_custom_dialog.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';

class RegisterMainViewModel extends BaseViewModel {
  RegisterMainViewModel({required this.setState});

  final ViewChange setState;
  WalletInfo? walletInfo;
  String currentCountry="";

  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailCodeController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ValidateResultData accountData = ValidateResultData();
  ValidateResultData passwordData = ValidateResultData();
  ValidateResultData rePasswordData = ValidateResultData();
  ValidateResultData emailData = ValidateResultData();
  ValidateResultData emailCodeData = ValidateResultData();
  ValidateResultData nicknameData = ValidateResultData();
  ValidateResultData referralData = ValidateResultData();
  ValidateResultData countryData = ValidateResultData();
  ValidateResultData phoneData = ValidateResultData();

  ///是否判斷過驗證碼
  bool checkEmail = false;
  String validateEmail = '';

  void dispose() {
    accountController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    emailController.dispose();
    emailCodeController.dispose();
    nicknameController.dispose();
    referralController.dispose();
    phoneController.dispose();
  }

  bool checkEmptyController(int currentIndex) {
    return accountController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        emailCodeController.text.isNotEmpty &&

        currentIndex == 0
        ? phoneController.text.isEmpty
        : phoneController.text.isNotEmpty;
  }

  bool checkData() {
    return accountData.result &&
        passwordData.result &&
        rePasswordData.result &&
        emailData.result &&
        emailCodeData.result &&
        nicknameData.result &&
        referralData.result &&
        countryData.result;
  }

  void resetData() {
    accountData = ValidateResultData();
    passwordData = ValidateResultData();
    rePasswordData = ValidateResultData();
    emailData = ValidateResultData();
    emailCodeData = ValidateResultData();
    nicknameData = ValidateResultData();
    referralData = ValidateResultData();
    countryData = ValidateResultData();
    phoneData = ValidateResultData();
  }

  bool checkPress() {
    return checkEmail;
  }

  void checkPassword() {
    if (passwordController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty) {
      rePasswordData = ValidateResultData(
          result:
              passwordController.text.compareTo(rePasswordController.text) == 0,
          message: tr('rule_confirmPW'));
    } else {
      passwordData = ValidateResultData();
      rePasswordData = ValidateResultData();
    }
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
      setState(() {
        checkEmail = true;
        validateEmail = emailController.text;
      });
      SimpleCustomDialog(context).show();
    } else {
      setState(() {
        emailData = ValidateResultData(result: emailController.text.isNotEmpty);
        emailCodeData =
            ValidateResultData(result: emailCodeController.text.isNotEmpty);
      });
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
  void onPressRegister(BuildContext context, WidgetRef ref, currentIndex) async {
    resetData();
    clearAllFocus();

    ///MARK: 檢查是否有欄位未填
    if (!checkEmptyController(currentIndex)) {
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

        if(currentIndex == 0) {
          showToast(getGlobalContext(), tr("placeholder-register-country"));
        }

        phoneData = ValidateResultData(result:
          currentCountry == tr("placeholder-register-country")
            ? phoneController.text.isEmpty
            : phoneController.text.isNotEmpty
        );

      });
      return;
    } else {
      ///MARK: v0.0.12版 改為與提交同時送出信箱驗證碼
      // ///MARK: 檢查是否驗證過信箱
      // if (!checkEmail) {
      //   emailCodeData =
      //       ValidateResultData(result: false, message: tr('EO_002_2'));
      // }

      ///MARK: 檢查帳號&暱稱是否符合規範
      accountData = checkAccount(accountController.text);
      nicknameData = checkAccount(nicknameController.text);

      ///MARK: 檢查密碼是否相符
      checkPassword();

      ///MARK: 如果檢查有部分錯誤時
      if (!checkData()) {
        setState(() {});
        return;
      }

      ///MARK: 沒選擇國家時清空
      if(currentIndex == 0) {
        currentCountry = "";
      }
      LoginAPI(onConnectFail: (message) {
        if(message == tr("APP_0104")){
          _onIpFail(context, message);
        }else{
          onBaseConnectFail(context, message);
        }
      }).register(
              account: accountController.text,
              password: passwordController.text,
              email: emailController.text,
              nickname: nicknameController.text,
              inviteCode: referralController.text,
              phone: phoneController.text,
              country: currentCountry,
              emailVerifyCode: emailCodeController.text,
              walletInfo: walletInfo)
          .then((value) async {
        ///MARK: 註冊成功動畫

        String? path = AnimationDownloadUtil()
            .getAnimationFilePath(getLoginTimeAnimationPath());
        if (path != null) {
          BaseViewModel().pushOpacityPage(
              context,
              FullAnimationPage(
                limitTimer: 3,
                animationPath: path,
                isFile: true,
                nextPage: const MainPage(),
                runFunction: () async {
                  await _updateRegisterInfo(ref: ref, isLogin: true);
                },
              ));
        } else {
          await _updateRegisterInfo(ref: ref, isLogin: true);
          BaseViewModel().pushAndRemoveUntil(context, const MainPage());
        }
      });
    }
  }

  ///MARK: 切換到登入頁面
  void onPressLogin(BuildContext context) {
    popPage(context);
  }

  @Deprecated("不要了")
  void onTap() {
    setState(() {
      resetData();
    });
  }

  // Future<bool> checkEmailFormat() async {
  //   if (emailController.text.isNotEmpty) {
  //     var result =
  //         RegularExpressionUtil().checkFormatEmail(emailController.text);
  //     setState(() {
  //       emailData =
  //           ValidateResultData(result: result, message: tr('rule_email'));
  //     });
  //     return result;
  //   } else {
  //     setState(() {
  //       emailData = ValidateResultData(result: false);
  //     });
  //   }
  //   return false;
  // }

  void onPasswordChanged(String value) {
    setState(() {
      checkPassword();
    });
  }

  void onEmailChange(String value) {
    setState(() {
      if (value.isNotEmpty) {
        checkEmail = (validateEmail.compareTo(value) == 0);
      } else {
        checkEmail = false;
      }
    });
  }

  void onPhoneChange(String value) {
    phoneData = ValidateResultData(result: phoneController.text.isNotEmpty);
    setState(() {});
  }

  void onPhoneCheck(int index) {
    setState(() {});
  }

  ///更新使用者資料
  Future<void> _updateRegisterInfo(
      {required WidgetRef ref, required bool isLogin}) async {
    var response = await LoginAPI().login(
        account: accountController.text,
        password: passwordController.text,
        isWallet: false);
    await saveUserLoginInfo(response: response, ref: ref, isLogin: isLogin);
    startUserListener();
  }

  ValidateResultData checkAccount(String value) {
    if (value.isNotEmpty) {
      return ValidateResultData(
          result: RegularExpressionUtil().checkFormatNickName(value),
          message: tr('accountLimitHint'));
    } else {
      return ValidateResultData();
    }
  }

  void onAccountChanged(String value) {
    setState(() {
      accountData = checkAccount(value);
    });
  }

  void onNicknameChange(String value) {
    setState(() {
      nicknameData = checkAccount(value);
    });
  }

  _onIpFail(BuildContext context, String message) {
    CommonCustomDialog(context,
      type: DialogImageType.fail,
      title: tr("notAvailable"),
      content: tr('APP_0104'),
      rightBtnText: tr('confirm'),
      bOneButton: true,
      onLeftPress: () {}, onRightPress: () {
        popPage(context);
      }).show();
  }
}
