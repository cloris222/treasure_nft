import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/login/login_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/text_field/login_text_widget.dart';

import '../../widgets/domain_bar.dart';
import '../../widgets/label/error_text_widget.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DomainBar(),
        Text(tr('account'),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
        LoginTextWidget(
            hintText: tr('placeholder-account\''),
            controller: accountController),
        ErrorTextWidget(data: viewModel.accountData),
        Text(tr('password'),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)),
        LoginTextWidget(
            hintText: tr('placeholder-password'),
            controller: passwordController),
        ErrorTextWidget(data: viewModel.passwordData),
      ],
    );
  }
}
