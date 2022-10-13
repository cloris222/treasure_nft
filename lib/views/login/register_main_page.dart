import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../view_models/login/register_main_viewmodel.dart';
import '../../widgets/button/countdown_button_widget.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/label/common_text_widget.dart';
import '../../widgets/label/error_text_widget.dart';
import '../../widgets/text_field/login_text_widget.dart';
import 'login_email_code_view.dart';
import 'login_param_view.dart';

class RegisterMainPage extends StatefulWidget {
  const RegisterMainPage({Key? key}) : super(key: key);

  @override
  State<RegisterMainPage> createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {
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
    return Scaffold(
      appBar: CustomAppBar.getCornerAppBar(
        () {
          BaseViewModel().popPage(context);
        },
        tr('register'),
        fontSize: UIDefine.fontSize24,
        arrowFontSize: UIDefine.fontSize34,
        circular: 40,
        appBarHeight: 120,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: _buildBody())),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typeLogin),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ///MARK:帳號
        LoginParamView(
            titleText: tr('account'),
            hintText: tr("placeholder-account'"),
            controller: viewModel.accountController,
            data: viewModel.accountData),

        ///MARK:密碼
        LoginParamView(
            titleText: tr('password'),
            hintText: tr("placeholder-password"),
            controller: viewModel.passwordController,
            isSecure: true,
            data: viewModel.passwordData),

        ///MARK:再次確認密碼
        LoginParamView(
            titleText: tr("placeholder-password-again'"),
            hintText: tr("placeholder-password-again'"),
            controller: viewModel.rePasswordController,
            isSecure: true,
            data: viewModel.rePasswordData),

        ///MARK:Email
        LoginParamView(
            titleText: tr('email'),
            hintText: tr("placeholder-email'"),
            controller: viewModel.emailController,
            data: viewModel.emailData),

        ///MARK:驗證碼
        LoginEmailCodeView(
            hintText: tr("placeholder-emailCode'"),
            controller: viewModel.emailCodeController,
            onPressSendCode: viewModel.onPressSendCode,
            onPressCheckVerify: ()=>viewModel.onPressCheckVerify(context),
            data: viewModel.emailCodeData),

        ///MARK:暱稱
        LoginParamView(
            titleText: tr('nickname'),
            hintText: tr("placeholder-nickname'"),
            controller: viewModel.nicknameController,
            data: viewModel.nicknameData),

        ///MARK:邀請瑪

        LoginParamView(
            titleText: tr('referralCode'),
            hintText: tr("placeholder-referralCode'"),
            controller: viewModel.referralController,
            data: viewModel.referralData),

        ///MARK: 註冊按鈕
        LoginButtonWidget(
          btnText: tr('register'),
          enable: viewModel.checkPress(),
          onPressed: viewModel.onPressRegister,
        ),
        Row(
          children: [
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
                    onPress: () => viewModel.onPressLogin(context))),
          ],
        ),
      ],
    );
  }
}
