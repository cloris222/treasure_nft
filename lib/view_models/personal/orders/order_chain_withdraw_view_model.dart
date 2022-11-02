import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/orders/order_withdraw_page.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/enum/coin_enum.dart';
import '../../../constant/enum/login_enum.dart';
import '../../../constant/global_data.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../models/http/api/auth_api.dart';
import '../../../models/http/api/withdraw_api.dart';
import '../../../views/personal/orders/withdraw/data/withdraw_balance_response_data.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';

class OrderChainWithdrawViewModel extends BaseViewModel {
  OrderChainWithdrawViewModel({required this.setState});

  final ViewChange setState;

  CoinEnum currentChain = CoinEnum.TRON;
  TextEditingController addressController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailCodeController = TextEditingController();

  ValidateResultData addressData = ValidateResultData();
  ValidateResultData amountData = ValidateResultData();
  ValidateResultData passwordData = ValidateResultData();
  ValidateResultData emailCodeData = ValidateResultData();

  WithdrawBalanceResponseData data = WithdrawBalanceResponseData();

  ///是否判斷過驗證碼
  bool checkEmail = false;
  bool checkExperience = GlobalData.experienceInfo.isExperience;

  initState() {
    Future<WithdrawBalanceResponseData> result = WithdrawApi().getWithdrawBalance();
    result.then((value) => _setData(value));
  }

  _setData(WithdrawBalanceResponseData resData) {
    setState(() {
      data = resData;
    });
  }

  void onTap() {
    setState(() {
      _resetData();
    });
  }

  bool checkEnable() {
    if (checkExperience) {
      // return passwordController.text.isNotEmpty; // test 體驗號功能未開
      return true;
    }
    return checkEmail;
  }

  void dispose() {
    addressController.dispose();
    amountController.dispose();
    passwordController.dispose();
    emailCodeController.dispose();
  }

  bool checkEmptyController() {
    return addressController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailCodeController.text.isNotEmpty;
  }

  bool checkData() {
    return addressData.result &&
        amountData.result &&
        passwordData.result &&
        emailCodeData.result;
  }

  void _resetData() {
    addressData = ValidateResultData();
    amountData = ValidateResultData();
    passwordData = ValidateResultData();
    emailCodeData = ValidateResultData();
  }

  ///MARK: 寄出驗證碼
  void onPressSendCode(BuildContext context) async {
    await AuthAPI(
        onConnectFail: (message) => onBaseConnectFail(context, message))
        .sendAuthActionMail(action: LoginAction.withdraw);
    SimpleCustomDialog(context, mainText: tr('pleaseGotoMailboxReceive'))
        .show();
  }

  /// MARK: 檢查驗證碼是否正確
  void onPressCheckVerify(BuildContext context) async {
    if (emailCodeController.text.isNotEmpty) {
      await AuthAPI(
          onConnectFail: (message) => onBaseConnectFail(context, message))
          .checkAuthCodeMail(
          mail: GlobalData.userInfo.email,
          action: LoginAction.withdraw,
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

  void onPressSave(BuildContext context) {
    ///MARK: 檢查是否有欄位未填
    if (!checkEmptyController()) {
      setState(() {
        addressData =
            ValidateResultData(result: addressController.text.isNotEmpty);
        amountData =
            ValidateResultData(result: amountController.text.isNotEmpty);
        passwordData =
            ValidateResultData(result: passwordController.text.isNotEmpty);
        emailCodeData =
            ValidateResultData(result: emailCodeController.text.isNotEmpty);
      });
      return;
    } else {
      ///MARK: 檢查是否驗證過信箱
      if (!checkExperience && !checkEmail) {
        emailCodeData =
            ValidateResultData(result: false, message: tr('rule_mail_valid'));
      }

      ///MARK: 如果上面的檢查有部分錯誤時return
      if (!checkData()) {
        setState(() {});
        return;
      }

      ///MARK: 打提交API
      WithdrawApi(onConnectFail: (message) => onBaseConnectFail(context, message))
          .submitBalanceWithdraw(
          address: addressController.text,
          amount: amountController.text)
          .then((value) async {
        SimpleCustomDialog(context, mainText: tr('success')).show();
        pushPage(context, const OrderWithdrawPage());
      });
    }
  }

}