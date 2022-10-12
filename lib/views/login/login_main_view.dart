import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/login/login_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/text_field/login_text_widget.dart';

import '../../constant/theme/app_colors.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/domain_bar.dart';
import '../../widgets/label/error_text_widget.dart';
import '../../widgets/label/common_text_widget.dart';

class LoginMainView extends StatefulWidget {
  const LoginMainView({Key? key}) : super(key: key);

  @override
  State<LoginMainView> createState() => _LoginMainViewState();
}

class _LoginMainViewState extends State<LoginMainView> {
  late LoginMainViewModel viewModel;
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = LoginMainViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    accountController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DomainBar(),
          _buildTop(),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildBottom()),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.centerLeft,
        child: Stack(children: [
          SizedBox(
              width: UIDefine.getWidth(), height: UIDefine.getHeight() / 3),
          Positioned(
              child: Image.asset(AppImagePath.loginBg,
                  height: UIDefine.getHeight() / 3, fit: BoxFit.fill)),
          Positioned(
              top: UIDefine.getWidth() / 5,
              bottom: UIDefine.getWidth() / 5,
              left: 25,
              right: UIDefine.getWidth() / 4,
              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '${tr('welcomeBack')} ,\n',
                    style: TextStyle(
                        fontSize: UIDefine.fontSize24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    text: tr('Login'),
                    style: TextStyle(
                        fontSize: UIDefine.fontSize34,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))
              ]))),
          Positioned(
              bottom: 0,
              right: 10,
              child: Image.asset(AppImagePath.loginPhoto,
                  width: UIDefine.getWidth() / 2, fit: BoxFit.fill))
        ]));
  }

  Widget _buildBottom() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(tr('account'),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
          LoginTextWidget(
              hintText: tr('placeholder-account\''),
              controller: accountController,
              focusedColor: AppColors.mainThemeButton),
          ErrorTextWidget(
              data: viewModel.accountData, alignment: Alignment.center),
          Text(tr('password'),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
          LoginTextWidget(
              hintText: tr('placeholder-password'),
              controller: passwordController,
              focusedColor: AppColors.mainThemeButton),
          ErrorTextWidget(
              data: viewModel.passwordData, alignment: Alignment.center),
          CommonTextWidget(
            text: "${tr('forgot')}?",
            alignment: Alignment.centerRight,
          ),
          LoginButtonWidget(
            btnText: tr('Login'),
            enable: viewModel.checkPress(
                accountController.text, passwordController.text),
            onPressed: () {},
          )
        ]);
  }
}
