import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/login/login_common_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/wallet_connect_button_widget.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../../constant/global_data.dart';
import '../../view_models/login/register_main_viewmodel.dart';
import '../../view_models/login/wallet_bind_view_model.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/label/common_text_widget.dart';
import '../custom_appbar_view.dart';
import '../personal/common/phone_param_view.dart';
import 'login_email_code_view.dart';
import 'login_param_view.dart';

class RegisterMainPage extends ConsumerStatefulWidget {
  const RegisterMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends ConsumerState<RegisterMainPage> {
  late RegisterMainViewModel viewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300)).then((value) =>
        ref.read(connectWalletProvider.notifier).initConnectWallet());
    viewModel = RegisterMainViewModel(setState: setState);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: AppNavigationBarType.typeLogin,
      body: SingleChildScrollView(
          child: LoginCommonView(
        pageHeight: UIDefine.getPixelWidth(1050),
        title: tr('register'),
        body: Container(
            margin: EdgeInsets.symmetric(
                vertical: UIDefine.getPixelHeight(10),
                horizontal: UIDefine.getPixelWidth(20)),
            padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
            child: _buildBody()),
      )),
    );
  }

  Widget _buildBody() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          WalletConnectButtonWidget(
              needChangeText: false,
              btnText: tr('register-via-wallet'),
              bindWalletTitle: tr('register-via-wallet'),
              getWalletInfo: (walletInfo) {
                WalletBindViewModel().registerWithWallet(context, ref,
                    walletInfo: walletInfo,
                    inviteCode: viewModel.referralController.text);
              }),

          // ///MARK:暱稱
          // LoginParamView(
          //     titleText: tr('nickname'),
          //     hintText: tr("placeholder-nickname'"),
          //     controller: viewModel.nicknameController,
          //     data: viewModel.nicknameData,
          //     onChanged: viewModel.onNicknameChange),

          ///MARK: 帳號
          LoginParamView(
            titleText: tr('account'),
            hintText: tr("placeholder-account'"),
            controller: viewModel.accountController,
            data: viewModel.accountData,
            onChanged: viewModel.onAccountChanged,
          ),

          ///MARK:密碼
          LoginParamView(
              bPasswordFormatter: true,
              titleText: tr('password'),
              hintText: tr("placeholder-password"),
              controller: viewModel.passwordController,
              isSecure: true,
              data: viewModel.passwordData,
              onChanged: viewModel.onPasswordChanged),

          ///MARK:再次確認密碼
          LoginParamView(
              bPasswordFormatter: true,
              titleText: tr("placeholder-password-again'"),
              hintText: tr("placeholder-password-again'"),
              controller: viewModel.rePasswordController,
              isSecure: true,
              data: viewModel.rePasswordData,
              onChanged: viewModel.onPasswordChanged),

          PhoneParamView(
              titleText: tr('phone'),
              hintText: tr("placeholder-phone'"),
              controller: viewModel.phoneController,
              data: viewModel.phoneData,
              getDropDownValue: (String value) {
                viewModel.setPhoneCountry(value);
              }),

          ///MARK:Email
          LoginParamView(
            titleText: tr('email'),
            hintText: tr("placeholder-email'"),
            controller: viewModel.emailController,
            data: viewModel.emailData,
            onChanged: viewModel.onEmailChange,
          ),

          ///MARK:驗證碼
          LoginEmailCodeView(
            needVerifyButton: false,
            hintText: tr("placeholder-emailCode'"),
            btnVerifyText: tr('verify'),
            btnGetText: tr('get'),
            controller: viewModel.emailCodeController,
            onPressSendCode: () => viewModel.onPressSendCode(context),
            onPressCheckVerify: () => viewModel.onPressCheckVerify(context),
            data: viewModel.emailCodeData,
            onPressVerification: viewModel.checkEmailFormat,
          ),

          ///MARK:邀請瑪
          LoginParamView(
              titleText: '${tr('referralCode')} (${tr('optional')})',
              hintText: tr("placeholder-referralCode'"),
              controller: viewModel.referralController,
              data: viewModel.referralData),

          ///MARK: 註冊按鈕
          LoginButtonWidget(
            btnText: tr('register'),
            // enable: viewModel.checkPress(),
            onPressed: () => viewModel.onPressRegister(context, ref),
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
                    text: tr('Login'),
                    fillWidth: false,
                    onPress: () => viewModel.onPressLogin(context)))
          ])
        ]);
  }
}
