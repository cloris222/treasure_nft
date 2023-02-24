import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/login/login_main_viewmodel.dart';
import 'package:treasure_nft_project/views/login/login_common_view.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../../constant/global_data.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/button/wallet_connect_button_widget.dart';
import '../../widgets/label/common_text_widget.dart';
import 'login_param_view.dart';

class LoginMainView extends ConsumerStatefulWidget {
  const LoginMainView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginMainViewState();
}

class _LoginMainViewState extends ConsumerState<LoginMainView> {
  late LoginMainViewModel viewModel;

  @override
  void initState() {
    viewModel = LoginMainViewModel(setState: setState);
    Future.delayed(const Duration(milliseconds: 300)).then((value) =>
        ref.read(connectWalletProvider.notifier).initConnectWallet());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: LoginCommonView(
            title: tr('signin'),
            body: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
              padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
              child: _buildBottom(),
            )));
  }

  Widget _buildBottom() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          WalletConnectButtonWidget(
              needChangeText: false,
              btnText: tr('login-via-wallet'),
              bindWalletTitle: tr('login-via-wallet'),
              getWalletInfo: (walletInfo) {
                GlobalData.printLog(
                    'walletInfo.address:${walletInfo?.address}');
                GlobalData.printLog(
                    'walletInfo.personalSign:${walletInfo?.personalSign}');
                if (walletInfo != null) {
                  viewModel.onWalletLogin(context, walletInfo, ref);
                }
              }),
          LoginParamView(
              titleText: tr('account'),
              hintText: tr("placeholder-account'"),
              controller: viewModel.accountController,
              data: viewModel.accountData,
              onTap: viewModel.onTap),
          LoginParamView(
              bPasswordFormatter: true,
              titleText: tr('password'),
              hintText: tr("placeholder-password"),
              controller: viewModel.passwordController,
              data: viewModel.passwordData,
              onTap: viewModel.onTap,
              isSecure: true),
          CommonTextWidget(
            text: "${tr('forgot')}?",
            alignment: Alignment.centerRight,
            onPress: () => viewModel.onPressForgot(context),
          ),
          LoginButtonWidget(
            btnText: tr('Login'),
            enable: true,
            fontSize: UIDefine.fontSize16,
            fontWeight: FontWeight.w600,
            radius: 22,
            onPressed: () => viewModel.onPressLogin(context, ref),
          ),
          Row(children: [
            Flexible(
                flex: 3,
                child: CommonTextWidget(
                  text: tr('withoutAccount'),
                  alignment: Alignment.centerRight,
                )),
            const SizedBox(width: 20),
            Flexible(
                flex: 2,
                child: CommonTextWidget(
                    text: tr('register'),
                    fillWidth: false,
                    onPress: () => viewModel.onPressRegister(context)))
          ])
        ]);
  }
}
