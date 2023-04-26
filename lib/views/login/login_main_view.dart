// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/login/login_main_viewmodel.dart';
import 'package:treasure_nft_project/views/login/login_common_view.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../../constant/global_data.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/button/wallet_connect_button_widget.dart';
import '../../widgets/dialog/common_custom_dialog.dart';
import '../../widgets/dialog/wallet_login_hint_dialog.dart';
import '../../widgets/label/common_text_widget.dart';
import 'login_param_view.dart';

class LoginMainView extends ConsumerStatefulWidget {
  const LoginMainView({Key? key, this.preWalletInfo}) : super(key: key);

  ///MARK: 代表此次登入需綁定錢包
  final WalletInfo? preWalletInfo;

  @override
  ConsumerState createState() => _LoginMainViewState();
}

class _LoginMainViewState extends ConsumerState<LoginMainView> {
  late LoginMainViewModel viewModel;

  bool get needBindWallet {
    return widget.preWalletInfo != null;
  }

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
          Visibility(
            visible: !needBindWallet,
            child: WalletConnectButtonWidget(
                needChangeText: false,
                btnText: tr('login-via-wallet'),
                bindWalletTitle: tr('login-via-wallet'),
                getWalletInfo: (walletInfo) async {
                  viewModel.onWalletLogin(context, ref, walletInfo);
                }),
          ),
          LoginParamView(
              titleText: tr('account'),
              hintText: tr("placeholder-account'"),
              controller: viewModel.accountController,
              data: viewModel.accountData,
              onTap: viewModel.onTap),
          LoginParamView(
              // bPasswordFormatter: true,
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
            onPressed: () =>
                viewModel.onPressLogin(context, ref, widget.preWalletInfo),
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
