import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/enum/login_enum.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../models/http/api/auth_api.dart';
import '../../../models/http/api/user_info_api.dart';
import '../../../utils/regular_expression_util.dart';
import '../../../views/main_page.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';
import '../../base_view_model.dart';

class UserInfoSettingViewModel extends BaseViewModel {
  UserInfoSettingViewModel(
      {required this.onViewChange, required this.userInfo});

  final onClickFunction onViewChange;
  final UserInfoData userInfo;
  late TextEditingController nickNameController;
  late TextEditingController phoneController;

  void init() {
    nickNameController = TextEditingController(text: userInfo.name);
    phoneController = TextEditingController(text: userInfo.phone);
  }

  String birthday = '';
  String phoneCountry = '';
  String gender = '';

  ValidateResultData nickNameData = ValidateResultData();
  ValidateResultData phoneData = ValidateResultData();
  ValidateResultData birthdayData = ValidateResultData();

  ///MARK: email 可修改
  ValidateResultData emailData = ValidateResultData();
  ValidateResultData emailCodeData = ValidateResultData();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailCodeController = TextEditingController();

  void onNicknameChanged(String value) {
    _checkNickname();
    onViewChange();
  }

  void dispose() {
    nickNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    emailCodeController.dispose();
  }

  ///MARK: 取callBack的生日且重置紅匡
  void setBirthday(String value) {
    birthday = value;
    // 選擇後才reset, DatePicker onTap內要開啟選擇器 故無法直接callBack click
    birthdayData = ValidateResultData();
    onViewChange();
  }

  void setPhoneCountry(String value) {
    phoneCountry = value;
  }

  void setGender(String value) {
    gender = value;
  }

  bool _checkEmptyController() {
    return nickNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  bool _checkData() {
    return nickNameData.result && phoneData.result && birthdayData.result;
  }

  ///MARK: 重置紅框紅字
  void _resetData() {
    nickNameData = ValidateResultData();
    phoneData = ValidateResultData();
    birthdayData = ValidateResultData();
    emailCodeData = ValidateResultData();
    emailData = ValidateResultData();
  }

  void onEmailChange(String value) {
    emailCodeData = ValidateResultData();
    emailData = ValidateResultData();
    onViewChange();
  }

  ///MARK: 檢查暱稱
  void _checkNickname() {
    if (nickNameController.text.isNotEmpty) {
      nickNameData = ValidateResultData(
          result: RegularExpressionUtil()
              .checkFormatNickName(nickNameController.text),
          message: tr('accountLimitHint'));
    } else {
      nickNameData = ValidateResultData();
    }
  }

  void onPressSave(BuildContext context) {
    _resetData();

    ///MARK: 檢查是否有欄位未填
    if (!_checkEmptyController()) {
      nickNameData =
          ValidateResultData(result: nickNameController.text.isNotEmpty);
      phoneData = ValidateResultData(result: phoneController.text.isNotEmpty);
      birthdayData = ValidateResultData(result: birthday.isNotEmpty);
      onViewChange();
      return;
    } else {
      ///MARK: 檢查暱稱是否符合規範
      _checkNickname();

      ///MARK: 如果email有填值 驗證碼應該要有值
      if (emailController.text.isNotEmpty) {
        if (emailCodeController.text.isEmpty) {
          emailCodeData = ValidateResultData(result: false);
          onViewChange();
          return;
        }
      }

      ///MARK: 如果上面的檢查有部分錯誤時return
      if (!_checkData()) {
        onViewChange();
        return;
      }
    }

    ///MARK: 儲存修改的API
    UserInfoAPI(onConnectFail: (message) => onBaseConnectFail(context, message))
        .updatePersonInfo(
            name: nickNameController.text,
            phoneCountry: phoneCountry,
            phone: phoneController.text,
            password: '',
            oldPassword: '',
            gender: gender,
            birthday: birthday,
            email: emailController.text,
            emailVerifyCode:
                emailController.text.isNotEmpty ? emailCodeController.text : '')
        .then((value) async {
      SimpleCustomDialog(context, mainText: tr('success')).show();

      ///MARK: 跳回首頁-個人中心
      pushAndRemoveUntil(
          context, const MainPage(type: AppNavigationBarType.typePersonal));
    });
  }

  onPressSendCode(BuildContext context, UserInfoData userInfo) async {
    if (emailController.text.isNotEmpty) {
      await AuthAPI(
              onConnectFail: (message) => onBaseConnectFail(context, message))
          .sendAuthActionMail(
              userInfo: userInfo,
              email: emailController.text,
              action: LoginAction.bind);
      SimpleCustomDialog(context, mainText: tr('pleaseGotoMailboxReceive'))
          .show();
    }
  }
}
