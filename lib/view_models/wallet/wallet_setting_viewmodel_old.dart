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

class WalletSettingViewModelOld extends BaseViewModel {
  WalletSettingViewModelOld({required this.setState});

  final ViewChange setState;

  TextEditingController trcController = TextEditingController();
  TextEditingController bscController = TextEditingController();
  TextEditingController rolloutController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  ValidateResultData codeData = ValidateResultData();

  List<PaymentInfo> payInfo = [];
  bool checkEmail = false;

  Future<void> initState() async {
    payInfo = await WalletAPI().getPaymentInfo();
    trcController.text = getCoinText(CoinEnum.TRON);
    bscController.text = getCoinText(CoinEnum.BSC);
    rolloutController.text = getCoinText(CoinEnum.ROLLOUT);
    setState(() {});
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

  String getCoinText(CoinEnum coin) {
    for (int i = 0; i < payInfo.length; i++) {
      if (payInfo[i].payType == coin.name) {
        return payInfo[i].account;
      }
    }
    return '';
  }

  void sendEmailCode(BuildContext context, UserInfoData userInfo) {
    AuthAPI(
            onConnectFail: (errorMessage) =>
                onBaseConnectFail(context, errorMessage))
        .sendAuthActionMail(action: LoginAction.payment, userInfo: userInfo);
  }

  void checkEmailCode(BuildContext context, UserInfoData userInfo) {
    if (codeController.text.isEmpty) {
      setState(() {
        codeData = ValidateResultData(result: false);
      });
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
      setState(() {
        checkEmail = true;
      });
    });
  }

  void onCheckPayment(BuildContext context) {
    if (checkEmail) {
      CheckWalletSettingDialog(context,
          accountTRON: trcController.text,
          accountBSC: bscController.text,
          accountROLLOUT: rolloutController.text, onConfirm: () {
        onSavePayment(context);
      }).show();
    } else {
      onBaseConnectFail(context, tr('rule_mail_valid'));
    }
  }

  void onSavePayment(BuildContext context) {
    WalletAPI(
            onConnectFail: (errorMessage) =>
                onBaseConnectFail(context, errorMessage))
        .setPaymentInfo(
            accountTRON: trcController.text,
            accountBSC: bscController.text,
            accountROLLOUT: rolloutController.text,
            emailVerifyCode: codeController.text)
        .then((value) {
      popPage(context);
      SimpleCustomDialog(context, isSuccess: true).show();
    });
  }

  void onClearData() {
    setState(() {
      codeData = ValidateResultData();
    });
  }
}
