import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/login/login_main_viewmodel.dart';

import '../../widgets/button/login_button_widget.dart';
import '../../widgets/domain_bar.dart';
import '../../widgets/label/common_text_widget.dart';
import 'login_param_view.dart';

class LoginMainView extends StatefulWidget {
  const LoginMainView({Key? key}) : super(key: key);

  @override
  State<LoginMainView> createState() => _LoginMainViewState();
}

class _LoginMainViewState extends State<LoginMainView> {
  late LoginMainViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LoginMainViewModel(setState: setState);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const DomainBar(),
      _buildTop(),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: _buildBottom())
    ]));
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
              top: 0,
              bottom: 0,
              left: 20,
              right: UIDefine.getWidth() / 4,
              child: Container(
                alignment: Alignment.centerLeft,
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
                ])),
              )),
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
          LoginParamView(
              titleText: tr('account'),
              hintText: tr("placeholder-account'"),
              controller: viewModel.accountController,
              data: viewModel.accountData,
              onTap: viewModel.onTap),
          LoginParamView(
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
            onPressed: () => viewModel.onPressLogin(context),
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
