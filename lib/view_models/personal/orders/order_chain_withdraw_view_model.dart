import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/enum/coin_enum.dart';
import '../../../constant/enum/login_enum.dart';
import '../../../constant/global_data.dart';
import '../../../models/data/validate_result_data.dart';
import '../../../models/http/api/auth_api.dart';
import '../../../models/http/api/withdraw_api.dart';
import '../../../models/http/parameter/withdraw_alert_info.dart';
import '../../../views/personal/orders/withdraw/data/withdraw_balance_response_data.dart';
import '../../../views/personal/orders/withdraw/order_withdraw_confirm_dialog_view.dart';
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

  ///MARK: 實際手續費
  num currentAmount = 0;

  requestAPI() {
    Future<WithdrawBalanceResponseData> result =
        WithdrawApi().getWithdrawBalance(currentChain.name);
    result.then((value) => _setData(value));
  }

  _setData(WithdrawBalanceResponseData resData) {
    setState(() {
      data = resData;
      currentAmount = num.parse(data.fee);
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
        // passwordController.text.isNotEmpty &&
        (emailCodeController.text.isNotEmpty || checkExperience);
  }

  bool checkData() {
    return addressData.result &&
        amountData.result &&
        // passwordData.result &&
        emailCodeData.result;
  }

  void _resetData() {
    addressData = ValidateResultData();
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
    clearAllFocus();
    ///MARK: 檢查是否有欄位未填
    if (!checkEmptyController()) {
      setState(() {
        addressData =
            ValidateResultData(result: addressController.text.isNotEmpty);
        amountData =
            ValidateResultData(result: amountController.text.isNotEmpty);
        // passwordData =
        //     ValidateResultData(result: passwordController.text.isNotEmpty);
        emailCodeData =
            ValidateResultData(result: emailCodeController.text.isNotEmpty);
      });
      return;
    } else {
      ///MARK: v0.0.12版 改為與提交時同送出信箱驗證碼
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

      ///MARK: 提領金額是否大於手續費
      if (num.parse(amountController.text) < currentAmount) {
        CommonCustomDialog(context,
            title: tr("point-FAIL'"),
            content: tr('APP_0067'),
            type: DialogImageType.fail,
            rightBtnText: tr('confirm'),
            onLeftPress: () {}, onRightPress: () {
          Navigator.pop(context);
        }).show();
        return;
      }

      ///MARK: 提領金額是否大於最低金額
      if (num.parse(amountController.text) < num.parse(data.minAmount)) {
        CommonCustomDialog(context,
            title: tr("point-FAIL'"),
            content: format(tr("errorMinAmount"), {"amount": data.minAmount}),
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
          _showWithdrawConfirm(context);
        }).show();
      } else {
        _showWithdrawConfirm(context);
      }
    }
  }

  void _showWithdrawConfirm(BuildContext context) {
    ///MARK: 最後確認地址的Dialog
    OrderWithdrawConfirmDialogView(context,
        chain: _getChainName(currentChain),
        address: addressController.text,
        onLeftPress: () => Navigator.pop(context),
        onRightPress: () =>
            {_submitRequestApi(context), Navigator.pop(context)}).show();
  }

  void _submitRequestApi(BuildContext context) {
    ///MARK: 打提交API
    WithdrawApi(onConnectFail: (message) => onBaseConnectFail(context, message))
        .submitBalanceWithdraw(
            chain: currentChain.name,
            address: addressController.text,
            amount: amountController.text,
            account: '',
            emailVerifyCode: emailCodeController.text)
        .then((value) async {
      SimpleCustomDialog(context, mainText: tr('success')).show();
      pushAndRemoveUntil(
          context, MainPage(type: AppNavigationBarType.typeWallet));
    });
  }

  String _getChainName(CoinEnum currentChain) {
    switch (currentChain) {
      case CoinEnum.TRON:
        return 'TRC-20';
      case CoinEnum.BSC:
        return 'BSC';
      case CoinEnum.ROLLOUT: // 這裡沒這選項
        break;
    }
    return '';
  }

  void onAmountChange(String value) {
    ///提現金額 * 手續費(%) + 手續費(固定點數) 取到小數第二位無條件捨去
    setState(() {
      if (value.isEmpty) {
        currentAmount = num.parse(data.fee);
      } else {
        currentAmount = (num.parse(value) * num.parse(data.feeRate) / 100) +
            num.parse(data.fee);
      }
    });
  }
}
