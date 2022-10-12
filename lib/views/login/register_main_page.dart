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
    viewModel = RegisterMainViewModel();
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
        Text(tr('account'),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
        LoginTextWidget(
            hintText: tr('placeholder-account\''),
            controller: viewModel.accountController,
            focusedColor: AppColors.mainThemeButton),
        ErrorTextWidget(
            data: viewModel.accountData, alignment: Alignment.center),

        ///MARK:密碼
        Text(tr('password'),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
        LoginTextWidget(
          hintText: tr('placeholder-password'),
          controller: viewModel.passwordController,
          focusedColor: AppColors.mainThemeButton,
          isSecure: true,
        ),
        ErrorTextWidget(
            data: viewModel.passwordData, alignment: Alignment.center),

        ///MARK:再次確認密碼
        Text(tr("placeholder-password-again'"),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
        LoginTextWidget(
          hintText: tr("placeholder-password-again'"),
          controller: viewModel.rePasswordController,
          focusedColor: AppColors.mainThemeButton,
          isSecure: true,
        ),
        ErrorTextWidget(
            data: viewModel.rePasswordData, alignment: Alignment.center),

        ///MARK:Email
        Text(tr('email'),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
        LoginTextWidget(
          hintText: tr("placeholder-email'"),
          controller: viewModel.emailController,
          focusedColor: AppColors.mainThemeButton,
        ),
        ErrorTextWidget(
            data: viewModel.passwordData, alignment: Alignment.center),

        ///MARK:驗證碼
        Row(
          children: [
            Flexible(
              child: LoginTextWidget(
                  hintText: tr("placeholder-emailCode'"),
                  controller: viewModel.emailCodeController),
            ),
            CountdownButtonWidget(
              buttonType: 2,
              countdownSecond: 180,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              btnText: tr('get'),
              isFillWidth: false,
              setHeight: 50,
              onPress: viewModel.onPressSendCode,
            ),
            ActionButtonWidget(
                btnText: tr('verify'),
                isFillWidth: false,
                setHeight: 50,
                onPressed: viewModel.onPressCheckVerify)
          ],
        ),

        ///MARK:暱稱
        Text(tr('nickname'),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
        LoginTextWidget(
          hintText: tr("placeholder-nickname'"),
          controller: viewModel.nicknameController,
          focusedColor: AppColors.mainThemeButton,
        ),
        ErrorTextWidget(
            data: viewModel.passwordData, alignment: Alignment.center),

        ///MARK:邀請瑪
        Text(tr('referralCode'),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
        LoginTextWidget(
          hintText: tr("placeholder-referralCode'"),
          controller: viewModel.referralController,
          focusedColor: AppColors.mainThemeButton,
        ),
        ErrorTextWidget(
            data: viewModel.passwordData, alignment: Alignment.center),

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
                    onPress: viewModel.onPressLogin)),
          ],
        )
      ],
    );
  }


}
