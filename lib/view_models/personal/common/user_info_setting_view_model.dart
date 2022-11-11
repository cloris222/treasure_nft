import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/global_data.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../models/http/api/user_info_api.dart';
import '../../../utils/regular_expression_util.dart';
import '../../../views/main_page.dart';
import '../../../views/personal/personal_main_view.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';
import '../../base_view_model.dart';

class UserInfoSettingViewModel extends BaseViewModel {
  UserInfoSettingViewModel({required this.setState});

  final ViewChange setState;

  TextEditingController nickNameController = TextEditingController(text: GlobalData.userInfo.name);
  TextEditingController phoneController =
      TextEditingController(text: GlobalData.userInfo.phone);
  String birthday = '';
  String phoneCountry = '';
  String gender = '';

  ValidateResultData nickNameData = ValidateResultData();
  ValidateResultData phoneData = ValidateResultData();
  ValidateResultData birthdayData = ValidateResultData();

  void onNicknameChanged(String value) {
    setState(() {
      _checkNickname();
    });
  }

  void onTap() {
    setState(() {
      _resetData();
    });
  }

  void dispose() {
    nickNameController.dispose();
    phoneController.dispose();
  }

  ///MARK: 取callBack的生日且重置紅匡
  void setBirthday(String value) {
    birthday = value;
    setState(() {
      // 選擇後才reset, DatePicker onTap內要開啟選擇器 故無法直接callBack click
      _resetData();
    });
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
  }

  ///MARK: 檢查暱稱
  void _checkNickname() {
    if (nickNameController.text.isNotEmpty) {
      nickNameData = ValidateResultData(
          result: RegularExpressionUtil()
              .checkFormatNickName(nickNameController.text),
          message: '無效的用戶名，只能包含英文與數字，必須少於30個字'); // test 這句沒有多國
    } else {
      nickNameData = ValidateResultData();
    }
  }

  void onPressSave(BuildContext context) {
    ///MARK: 檢查是否有欄位未填
    if (!_checkEmptyController()) {
      setState(() {
        nickNameData =
            ValidateResultData(result: nickNameController.text.isNotEmpty);
        phoneData = ValidateResultData(result: phoneController.text.isNotEmpty);
        birthdayData = ValidateResultData(result: birthday.isNotEmpty);
      });
      return;
    } else {
      ///MARK: 如果上面的檢查有部分錯誤時return
      if (!_checkData()) {
        setState(() {});
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
            birthday: birthday)
        .then((value) async {
      SimpleCustomDialog(context, mainText: tr('success')).show();

      ///MARK: 跳回首頁-個人中心
      pushAndRemoveUntil(
          context, const MainPage(type: AppNavigationBarType.typePersonal));
    });
  }
}
