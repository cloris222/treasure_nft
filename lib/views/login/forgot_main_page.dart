import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/login/login_common_view.dart';

import '../../view_models/login/forgot_main_viewmodel.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../../widgets/button/login_bolder_button_widget.dart';
import '../../widgets/button/login_button_widget.dart';
import '../custom_appbar_view.dart';
import 'login_param_view.dart';

class ForgotMainPage extends StatefulWidget {
  const ForgotMainPage({Key? key}) : super(key: key);

  @override
  State<ForgotMainPage> createState() => _ForgotMainPageState();
}

class _ForgotMainPageState extends State<ForgotMainPage> {
  late ForgotMainViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ForgotMainViewModel(setState: setState);
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
        title: tr('forgot'),
        body: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          ///MARK:Email
          LoginParamView(
              titleText: tr('email'),
              hintText: tr("placeholder-email'"),
              controller: viewModel.emailController,
              data: viewModel.emailData,
              onTap: viewModel.onTap),
          SizedBox(height: UIDefine.getPixelWidth(10)),
          LoginButtonWidget(
            btnText: tr('confirm'),
            enable: true,
            margin: EdgeInsets.zero,
            fontWeight: FontWeight.w600,
            fontSize: UIDefine.fontSize16,
            onPressed: () => viewModel.onPressConfirm(context),
          ),
          SizedBox(height: UIDefine.getPixelWidth(10)),
          LoginBolderButtonWidget(
            margin: EdgeInsets.zero,
            btnText: tr('cancel'),
            onPressed: () => viewModel.onPressCancel(context),
            fontWeight: FontWeight.w600,
            fontSize: UIDefine.fontSize16,
          ),
        ]);
  }
}
