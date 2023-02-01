import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/login/login_main_viewmodel.dart';
import 'package:treasure_nft_project/views/login/login_common_view.dart';

import '../../widgets/button/login_button_widget.dart';
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
