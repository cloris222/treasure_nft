import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/wallet_connect_api.dart';
import 'package:treasure_nft_project/views/login/login_common_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../../constant/theme/app_colors.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/login/register_main_viewmodel.dart';
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
          ///MARK:通過錢包註冊
          Consumer(builder: (context, ref, _) {
            final connectStatus = ref.watch(connectWalletProvider);
            return SizedBox(
                child: connectStatus.whenOrNull(
              init: () => LoginBolderButtonWidget(
                  btnText: tr('register-via-wallet'),
                  onPressed: () {
                    ref.read(connectWalletProvider.notifier).connectWallet(
                        getNonce: (String address) async {
                      return await WalletConnectAPI().getUserNonce(address);
                    }, getWalletInfo: (WalletInfo walletInfo) async {
                      print('walletInfo.address:${walletInfo.address}');
                      print(
                          'walletInfo.personalSign:${walletInfo.personalSign}');

                      ///MARK: 授權完成後，會回傳此結果
                      WalletConnectAPI(
                              onConnectFail: (errorMessage) => viewModel
                                  .onBaseConnectFail(context, errorMessage))
                          .postCheckWalletVerifySign(walletInfo)
                          .then((value) {
                        viewModel.showToast(context, '授權成功');
                      });
                    }, bindWalletFail: () {
                      ///MARK: 授權失敗
                      viewModel.showToast(context, '授權失敗');
                    });
                  }),
              loading: () => const SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
              data: (wallet) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${tr('walletAddress')} :',
                      style: AppTextStyle.getBaseStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: UIDefine.fontSize14)),
                  Text(
                    wallet.address,
                    style: AppTextStyle.getBaseStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: UIDefine.fontSize14),
                  ),
                ],
              ),
            ));
          }),
          Divider(
              height: UIDefine.getPixelWidth(20),
              color: AppColors.bolderGrey,
              thickness: 1),

          ///MARK:暱稱
          LoginParamView(
              titleText: tr('nickname'),
              hintText: tr("placeholder-nickname'"),
              controller: viewModel.nicknameController,
              data: viewModel.nicknameData,
              onChanged: viewModel.onNicknameChange),

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
