import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/personal/common/user_change_password_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/button/login_button_widget.dart';
import '../../custom_appbar_view.dart';
import '../../login/login_email_code_view.dart';
import '../../login/login_param_view.dart';

/// 修改密碼
class UserChangePasswordPage extends StatefulWidget {
  const UserChangePasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserChangePasswordPage();
}

class _UserChangePasswordPage extends State<UserChangePasswordPage> {
  late UserChangePasswordViewModel viewModel;

  @override
  initState() {
    super.initState();
    viewModel = UserChangePasswordViewModel(setState: setState);
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
      type: AppNavigationBarType.typePersonal,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleAppBar(title: tr('changePassword')),
            LoginParamView(
                isSecure: true,
                bPasswordFormatter: true,
                titleText: tr('oldPassword'),
                hintText: tr("placeholder-old-password'"),
                controller: viewModel.oldPasswordController,
                data: viewModel.oldPasswordData,
                onTap: viewModel.onTap),
            SizedBox(height: UIDefine.getScreenWidth(4.16)),
            LoginParamView(
                isSecure: true,
                bPasswordFormatter: true,
                titleText: tr('newPassword'),
                hintText: tr("placeholder-new-password'"),
                controller: viewModel.newPasswordController,
                data: viewModel.newPasswordData,
                onTap: viewModel.onTap),
            SizedBox(height: UIDefine.getScreenWidth(4.16)),
            LoginParamView(
                isSecure: true,
                bPasswordFormatter: true,
                titleText: tr('confirmPW'),
                hintText: tr("placeholder-password-again'"),
                controller: viewModel.rePasswordController,
                data: viewModel.rePasswordData,
                onTap: viewModel.onTap,
                onChanged: viewModel.onPasswordChanged),
            SizedBox(height: UIDefine.getScreenWidth(5.5)),
            Text(tr('emailValid'),
                style: TextStyle(
                    fontSize: UIDefine.fontSize14,
                    fontWeight: FontWeight.w500)),
            LoginEmailCodeView(
                countdownSecond: 60,
                btnGetText: tr('get'),
                hintText: tr("placeholder-emailCode'"),
                controller: viewModel.emailCodeController,
                data: viewModel.emailCodeData,
                onPressSendCode: () => viewModel.onPressSendCode(context),
                onPressCheckVerify: () =>
                    viewModel.onPressCheckVerify(context)),
            SizedBox(height: UIDefine.getScreenWidth(8.32)),
            LoginButtonWidget(
                // Save按鈕
                isGradient: false,
                btnText: tr('save'),
                onPressed: () => viewModel.onPressSave(context),
                enable: viewModel.checkEmail),
            SizedBox(height: UIDefine.navigationBarPadding)
          ],
        ),
      )),
    );
  }
}
