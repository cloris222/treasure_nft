import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../view_models/base_view_model.dart';
import '../../view_models/login/forgot_main_viewmodel.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../../widgets/appbar/custom_app_bar.dart';
import '../../widgets/button/login_bolder_button_widget.dart';
import '../../widgets/button/login_button_widget.dart';
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
    return Scaffold(
        appBar: CustomAppBar.getCommonAppBar(() {
          BaseViewModel().popPage(context);
        }, tr('forgot')),
        body: SingleChildScrollView(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: _buildBody())),
        bottomNavigationBar: const AppBottomNavigationBar(
            initType: AppNavigationBarType.typeLogin));
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
              data: viewModel.accountData,
              onTap: viewModel.onTap),

          ///MARK:Email
          LoginParamView(
              titleText: tr('email'),
              hintText: tr("placeholder-email'"),
              controller: viewModel.emailController,
              data: viewModel.emailData,
              onTap: viewModel.onTap),
          Row(children: [
            Flexible(
                child: LoginBolderButtonWidget(
              btnText: tr('cancel'),
              onPressed: viewModel.onPressCancel,
            )),
            const SizedBox(
              width: 20,
            ),
            Flexible(
                child: LoginButtonWidget(
              btnText: tr('confirm'),
              enable: true,
              onPressed: () => viewModel.onPressConfirm(context),
            ))
          ])
        ]);
  }
}
