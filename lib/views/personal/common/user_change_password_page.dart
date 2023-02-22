import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/gobal_provider/user_info_provider.dart';
import '../../../view_models/personal/common/user_change_password_view_model.dart';
import '../../../widgets/button/login_button_widget.dart';
import '../../login/login_email_code_view.dart';
import '../../login/login_param_view.dart';

/// 修改密碼
class UserChangePasswordPage extends ConsumerStatefulWidget {
  const UserChangePasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserChangePasswordPageState();
}

class _UserChangePasswordPageState
    extends ConsumerState<UserChangePasswordPage> {
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
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: AppNavigationBarType.typePersonal,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleAppBar(title: tr('changePassword'), needCloseIcon: false),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14,
                            fontWeight: FontWeight.w500)),
                    LoginEmailCodeView(
                        needVerifyButton: false,
                        countdownSecond: 60,
                        btnGetText: tr('get'),
                        btnVerifyText: tr('verify'),
                        hintText: tr("placeholder-emailCode'"),
                        controller: viewModel.emailCodeController,
                        data: viewModel.emailCodeData,
                        onPressSendCode: () => viewModel.onPressSendCode(
                            context, ref.watch(userInfoProvider)),
                        onPressCheckVerify: () => viewModel.onPressCheckVerify(
                            context, ref.watch(userInfoProvider))),
                    SizedBox(height: UIDefine.getScreenWidth(8.32)),
                    Container(
                        width: double.infinity,
                        height: UIDefine.getPixelWidth(1),
                        color: AppColors.personalBar),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LoginButtonWidget(
                          // Save按鈕
                          padding: EdgeInsets.symmetric(
                              vertical: UIDefine.getPixelWidth(10),
                              horizontal: UIDefine.getPixelWidth(20)),
                          margin: EdgeInsets.symmetric(
                              vertical: UIDefine.getPixelWidth(15)),
                          isFillWidth: false,
                          radius: 17,
                          btnText: tr('save'),
                          onPressed: () => viewModel.onPressSave(context),
                          // enable: viewModel.checkEmail,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: UIDefine.navigationBarPadding,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
