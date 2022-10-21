import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/coin_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/models/http/api/auth_api.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/call_back_function.dart';
import '../../constant/enum/login_enum.dart';
import '../../models/data/validate_result_data.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';

class WalletSettingViewModel extends BaseViewModel {
  WalletSettingViewModel({required this.setState});

  final ViewChange setState;

  TextEditingController trcController = TextEditingController();
  TextEditingController bscController = TextEditingController();
  TextEditingController rolloutController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  ValidateResultData codeData = ValidateResultData();

  Map<String, dynamic>? payInfo;
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
    return payInfo?[coin.name] ?? '';
  }

  void sendEmailCode(BuildContext context) {
    AuthAPI(
            onConnectFail: (errorMessage) =>
                onBaseConnectFail(context, errorMessage))
        .sendAuthActionMail(action: LoginAction.payment);
  }

  void checkEmailCode(BuildContext context) {
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
            mail: GlobalData.userInfo.email,
            action: LoginAction.payment,
            authCode: codeController.text)
        .then((value) {
      SimpleCustomDialog(context, isSuccess: true).show();
      setState(() {
        checkEmail = true;
      });
    });
  }

  void onSavePayment(BuildContext context) async {
    await WalletAPI(
            onConnectFail: (errorMessage) =>
                onBaseConnectFail(context, errorMessage))
        .setPaymentInfo(
            accountTRON: trcController.text,
            accountBSC: bscController.text,
            accountROLLOUT: rolloutController.text)
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
