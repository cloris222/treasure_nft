import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/enum/login_enum.dart';
import '../../../constant/global_data.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../models/http/api/auth_api.dart';
import '../../../models/http/api/withdraw_api.dart';
import '../../../models/http/parameter/withdraw_alert_info.dart';
import '../../../views/personal/orders/withdraw/data/withdraw_balance_response_data.dart';
import '../../../widgets/dialog/common_custom_dialog.dart';
import '../../../widgets/dialog/simple_custom_dialog.dart';

class OrderInternalWithdrawViewModel extends BaseViewModel {
  OrderInternalWithdrawViewModel({required this.setState});

  final ViewChange setState;

  TextEditingController accountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailCodeController = TextEditingController();

  ValidateResultData accountData = ValidateResultData();
  ValidateResultData amountData = ValidateResultData();
  ValidateResultData passwordData = ValidateResultData();
  ValidateResultData emailCodeData = ValidateResultData();

  WithdrawBalanceResponseData data = WithdrawBalanceResponseData();

  ///是否判斷過驗證碼
  bool checkEmail = false;
  bool checkExperience = GlobalData.experienceInfo.isExperience;

  initState() {
    Future<WithdrawBalanceResponseData> result =
        WithdrawApi().getWithdrawBalance(null);
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
    accountController.dispose();
    amountController.dispose();
    passwordController.dispose();
    emailCodeController.dispose();
  }

  bool checkEmptyController() {
    return accountController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        // passwordController.text.isNotEmpty &&
        (emailCodeController.text.isNotEmpty || checkExperience);
  }

  bool checkData() {
    return accountData.result &&
        amountData.result &&
        // passwordData.result &&
        emailCodeData.result;
  }

  void _resetData() {
    accountData = ValidateResultData();
    amountData = ValidateResultData();
    // passwordData = ValidateResultData();
    emailCodeData = ValidateResultData();
  }

  ///MARK: 寄出驗證碼
  void onPressSendCode(BuildContext context) async {
    await AuthAPI(
            onConnectFail: (message) => onBaseConnectFail(context, message))
        .sendAuthActionMail(action: LoginAction.withdraw);
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

  void onPressSave(BuildContext context, WithdrawAlertInfo alertInfo) {
    ///MARK: 檢查是否有欄位未填
    if (!checkEmptyController()) {
      setState(() {
        accountData =
            ValidateResultData(result: accountController.text.isNotEmpty);
        amountData =
            ValidateResultData(result: amountController.text.isNotEmpty);
        // passwordData =
        //     ValidateResultData(result: passwordController.text.isNotEmpty);
        emailCodeData =
            ValidateResultData(result: emailCodeController.text.isNotEmpty);
      });
      return;
    } else {
      ///MARK: v0.0.12版 改為與提交時同時送出信箱驗證碼
      // ///MARK: 檢查是否驗證過信箱
      // if (!checkExperience && !checkEmail) {
      //   emailCodeData =
      //       ValidateResultData(result: false, message: tr('rule_mail_valid'));
      // }

      ///MARK: 如果上面的檢查有部分錯誤時return
      if (!checkData()) {
        setState(() {});
        return;
      }

      ///MARK: 提領金額是否大於最低金額
      if (num.parse(amountController.text) < num.parse(data.minAmount)) {
        CommonCustomDialog(context,
            title: tr("point-FAIL'"),
            content: '${tr("errorMinAmount")}${data.minAmount} USDT',
            type: DialogImageType.fail,
            rightBtnText: tr('confirm'),
            onLeftPress: () {}, onRightPress: () {
          Navigator.pop(context);
        }).show();
        return;
      }

      if (alertInfo.isReserve) {
        CommonCustomDialog(context,
            title: tr("reservenotDrawn"),
            content: format(tr('reservenotDrawn-hint-post'),
                {"balance": alertInfo.validAmount}),
            type: DialogImageType.fail,
            rightBtnText: tr('confirm'),
            onLeftPress: () {}, onRightPress: () {
          Navigator.pop(context);
          sendConfirm(context);
        }).show();
      } else {
        sendConfirm(context);
      }
    }
  }

  void sendConfirm(BuildContext context) {
    ///MARK: 打提交API 餘額提現
    WithdrawApi(onConnectFail: (message) => onBaseConnectFail(context, message))
        .submitBalanceWithdraw(
            chain: '',
            address: '',
            amount: amountController.text,
            account: accountController.text,
            emailVerifyCode: emailCodeController.text)
        .then((value) async {
      SimpleCustomDialog(context, mainText: tr('success')).show();
      pushAndRemoveUntil(
          context, const MainPage(type: AppNavigationBarType.typeWallet));
    });
  }
}
