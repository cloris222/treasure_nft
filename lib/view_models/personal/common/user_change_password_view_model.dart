import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/personal/personal_main_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/enum/login_enum.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../models/http/api/admin_api.dart';
import '../../../models/http/api/auth_api.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';

class UserChangePasswordViewModel extends BaseViewModel {
  UserChangePasswordViewModel({required this.setState});

  final ViewChange setState;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailCodeController = TextEditingController();

  ValidateResultData oldPasswordData = ValidateResultData();
  ValidateResultData newPasswordData = ValidateResultData();
  ValidateResultData rePasswordData = ValidateResultData();
  ValidateResultData emailCodeData = ValidateResultData();

  ///是否判斷過驗證碼
  bool checkEmail = false;

  void onPasswordChanged(String value) {
    setState(() {
      _checkPassword();
    });
  }

  void onTap() {
    setState(() {
      _resetData();
    });
  }

  void dispose() {
    rePasswordController.dispose();
    emailCodeController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
  }

  bool checkEmptyController() {
    return oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty &&
        emailCodeController.text.isNotEmpty;
  }

  bool checkData() {
    return oldPasswordData.result &&
        newPasswordData.result &&
        rePasswordData.result &&
        emailCodeData.result;
  }

  void _resetData() {
    oldPasswordData = ValidateResultData();
    newPasswordData = ValidateResultData();
    rePasswordData = ValidateResultData();
    emailCodeData = ValidateResultData();
  }

  bool checkPress() {
    return checkEmail;
  }

  void _checkPassword() {
    if (newPasswordController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty) {
      rePasswordData = ValidateResultData(
          result:
              newPasswordController.text.compareTo(rePasswordController.text) ==
                  0,
          message: tr('rule_confirmPW'));
    } else {
      newPasswordData = ValidateResultData();
      rePasswordData = ValidateResultData();
    }
  }

  /// MARK: 檢查驗證碼是否正確
  void onPressCheckVerify(BuildContext context) async {
    if (emailCodeController.text.isNotEmpty) {
      await AuthAPI(
              onConnectFail: (message) => onBaseConnectFail(context, message))
          .checkAuthCodeMail(
              mail: GlobalData.userInfo.email,
              action: LoginAction.updatePsw,
              authCode: emailCodeController.text);
      setState(() {
        checkEmail = true;
      });
      SimpleCustomDialog(context).show();
    } else {
      setState(() {
        emailCodeData =
            ValidateResultData(result: emailCodeController.text.isNotEmpty);
      });
    }
  }

  ///MARK: 寄出驗證碼
  void onPressSendCode(BuildContext context) async {
    await AuthAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .sendAuthActionMail(action: LoginAction.updatePsw);
    SimpleCustomDialog(context, mainText: tr('pleaseGotoMailboxReceive'))
        .show();
  }

  void onPressSave(BuildContext context) {
    ///MARK: 檢查是否有欄位未填
    if (!checkEmptyController()) {
      setState(() {
        oldPasswordData =
            ValidateResultData(result: oldPasswordController.text.isNotEmpty);
        newPasswordData =
            ValidateResultData(result: newPasswordController.text.isNotEmpty);
        rePasswordData =
            ValidateResultData(result: rePasswordController.text.isNotEmpty);
        emailCodeData =
            ValidateResultData(result: emailCodeController.text.isNotEmpty);
      });
      return;
    } else {
      ///MARK: 檢查是否驗證過信箱
      if (!checkEmail) {
        emailCodeData =
            ValidateResultData(result: false, message: tr('rule_mail_valid'));
      }

      ///MARK: 檢查密碼是否相符
      _checkPassword();

      ///MARK: 如果上面的檢查有部分錯誤時return
      if (!checkData()) {
        setState(() {});
        return;
      }

      ///MARK: 修改密碼API
      AdminAPI(onConnectFail: (message) => onBaseConnectFail(context, message))
          .updatePassword(
              oldPassword: oldPasswordController.text,
              newPassword: newPasswordController.text)
          .then((value) async {
        SimpleCustomDialog(context, mainText: tr('success')).show();
        pushPage(
            context, const MainPage(type: AppNavigationBarType.typePersonal));
      });
    }
  }
}
