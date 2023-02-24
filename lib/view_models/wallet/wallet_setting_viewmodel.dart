import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/coin_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/models/http/api/auth_api.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/dialog/check_wallet_setting_dialog.dart';

import '../../constant/call_back_function.dart';
import '../../constant/enum/login_enum.dart';
import '../../models/data/validate_result_data.dart';
import '../../models/http/parameter/payment_info.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';

class WalletSettingViewModel extends BaseViewModel {
  WalletSettingViewModel({required this.onViewChange});

  final onClickFunction onViewChange;

  TextEditingController trcController = TextEditingController();
  TextEditingController bscController = TextEditingController();
  TextEditingController rolloutController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  ValidateResultData codeData = ValidateResultData();

  bool checkEmail = false;

  void setTextController(List<PaymentInfo> list, String defaultAddress) {
    if (list.isNotEmpty) {
      ///MARK:清除更新controller
      trcController.text = getCoinText(list, CoinEnum.TRON, defaultAddress);
      bscController.text = getCoinText(list, CoinEnum.BSC, defaultAddress);
      rolloutController.text =
          getCoinText(list, CoinEnum.ROLLOUT, defaultAddress);
    }
  }

  void dispose() {
    trcController.dispose();
    bscController.dispose();
    rolloutController.dispose();
    codeController.dispose();
  }

  String getCoinImage(CoinEnum coin) {
    switch (coin) {
      case CoinEnum.TRON:
        return AppImagePath.tronImg;
      case CoinEnum.BSC:
        return AppImagePath.binanceImg;
      case CoinEnum.ROLLOUT:
        return AppImagePath.polyImg;
    }
  }

  String getCoinTitle(CoinEnum coin) {
    switch (coin) {
      case CoinEnum.TRON:
        return 'USDT (TRC-20)';
      case CoinEnum.BSC:
        return 'USDT (BSC)';
      case CoinEnum.ROLLOUT:
        return tr("NFT Transfer(Polygon)'");
    }
  }

  String getCoinHintText(CoinEnum coin) {
    switch (coin) {
      case CoinEnum.TRON:
        return tr("USDT20-placeholder'");
      case CoinEnum.BSC:
        return tr("USDT(BSC)-placeholder'");
      case CoinEnum.ROLLOUT:
        return tr("NFT Transfer(Polygon)-placeholder'");
    }
  }

  String getCoinText(
      List<PaymentInfo> list, CoinEnum coin, String defaultAddress) {
    String text = '';
    for (int i = 0; i < list.length; i++) {
      if (list[i].payType == coin.name) {
        text = list[i].account;
        break;
      }
    }
    if (text.isEmpty && (coin == CoinEnum.ROLLOUT || coin == CoinEnum.BSC)) {
      return defaultAddress;
    }
    return text;
  }

  void sendEmailCode(BuildContext context, UserInfoData userInfo) {
    AuthAPI(
            onConnectFail: (errorMessage) =>
                onBaseConnectFail(context, errorMessage))
        .sendAuthActionMail(action: LoginAction.payment, userInfo: userInfo);
  }

  void checkEmailCode(BuildContext context, UserInfoData userInfo) {
    if (codeController.text.isEmpty) {
      codeData = ValidateResultData(result: false);
      onViewChange();
      return;
    }
    AuthAPI(
            onConnectFail: (errorMessage) =>
                onBaseConnectFail(context, errorMessage))
        .checkAuthCodeMail(
            mail: userInfo.email,
            action: LoginAction.payment,
            authCode: codeController.text)
        .then((value) {
      SimpleCustomDialog(context, isSuccess: true).show();

      checkEmail = true;
      onViewChange();
    });
  }

  // ///工單716 移除先檢查驗證碼
  // void onCheckPayment(BuildContext context) {
  //   if (checkEmail) {
  //     CheckWalletSettingDialog(context,
  //         accountTRON: trcController.text,
  //         accountBSC: bscController.text,
  //         accountROLLOUT: rolloutController.text, onConfirm: () {
  //       onSavePayment(context);
  //     }).show();
  //   } else {
  //     onBaseConnectFail(context, tr('rule_mail_valid'));
  //   }
  // }

  void onSavePayment(BuildContext context,
      {Function(String accountTRON, String accountBSC, String accountROLLOUT)?
          saveSetting}) {
    String accountTRON = trcController.text;
    String accountBSC = bscController.text;
    String accountROLLOUT = rolloutController.text;
    WalletAPI(
            onConnectFail: (errorMessage) =>
                onBaseConnectFail(context, errorMessage))
        .setPaymentInfo(
            accountTRON: accountTRON,
            accountBSC: accountBSC,
            accountROLLOUT: accountROLLOUT,
            emailVerifyCode: codeController.text)
        .then((value) {
      popPage(context);
      if (saveSetting != null) {
        saveSetting(accountTRON, accountBSC, accountROLLOUT);
      }
      SimpleCustomDialog(context, isSuccess: true).show();
    });
  }

  void onClearData() {
    codeData = ValidateResultData();
    onViewChange();
  }
}
