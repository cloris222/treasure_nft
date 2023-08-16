
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/models/http/parameter/blacklist_config_data.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../../constant/theme/app_style.dart';
import '../../../../constant/ui_define.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../view_models/personal/common/google_auth/google_disable_view_model.dart';
import '../../../../widgets/app_bottom_navigation_bar.dart';
import '../../../../widgets/appbar/title_app_bar.dart';
import '../../../../widgets/button/login_button_widget.dart';
import '../../../view_models/personal/common/modify_email_viewmodel.dart';
import '../../custom_appbar_view.dart';
import '../../login/login_email_code_view.dart';
import '../../login/login_param_view.dart';

///MARK: 更改信箱
class ModifyEmailPage extends ConsumerStatefulWidget {
  const ModifyEmailPage(this.blacklistConfigData, {
    Key? key,
  }) : super(key: key);

  final BlacklistConfigData blacklistConfigData;

  @override
  ConsumerState createState() => _ModifyEmailPageState();
}

class _ModifyEmailPageState extends ConsumerState<ModifyEmailPage> {
  BlacklistConfigData get blacklistConfigData => widget.blacklistConfigData;
  late ModifyEmailViewModel viewModel;

  @override
  void initState() {
    viewModel = ModifyEmailViewModel(ref, blacklistConfigData, setState: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        needCover: true,
        needScrollView: true,
        type: AppNavigationBarType.typePersonal,
        body: Container(
          padding:  EdgeInsets.symmetric(
              horizontal: UIDefine.getPixelWidth(16)),
          child:Column(children: [
            TitleAppBar(
              title: tr("editEmail"),
              needCloseIcon: true,
              needArrowIcon: false,
            ),
            SizedBox(height: UIDefine.getPixelHeight(24)),
            _buildHint(),
            SizedBox(height: UIDefine.getPixelHeight(16)),
            _buildPassword(),
            SizedBox(height: UIDefine.getPixelHeight(16)),
            _buildGoogleAuth(),
            SizedBox(height: UIDefine.getPixelHeight(16)),
            _buildEMailVerify(),
            SizedBox(height: UIDefine.getPixelHeight(50)),
            _buildButton(),
            SizedBox(height: UIDefine.getPixelHeight(100)),
          ]),
        ),
        onLanguageChange: () {
          if (mounted) {
            setState(() {});
          }});
  }

  Widget _buildHint() {
    return Container(
        padding: EdgeInsets.all(UIDefine.getPixelHeight(15)),
        decoration: AppStyle().styleColorsRadiusBackground(
            color: AppColors.textBlack.withOpacity(0.06), radius: 12),
        child: Text(format(tr("emailCheckText"),
            {"time": viewModel.formatDuration(
                blacklistConfigData.unableWithdrawByEmail)}),
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.dialogBlack))
    );
  }

  Widget _buildPassword() {
    return LoginParamView(
      titleText: tr("loginPassword"),
      hintText: tr("placeholder-password"),
      controller: viewModel.passwordController,
      data: viewModel.passwordData,
      keyboardType:TextInputType.text,
      inputFormatters: denySpace(),
    );
  }

  Widget _buildGoogleAuth() {
    return LoginParamView(
      titleText: tr("googleValid"),
      hintText: tr("enterGoogle_verify"),
      controller: viewModel.googleCodeController,
      data: viewModel.googleCodeData,
      keyboardType:TextInputType.text,
      inputFormatters: denySpace(),
    );
  }

  Widget _buildEMailVerify() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///MARK:信箱
          LoginParamView(
            titleText: tr('email'),
            hintText: tr("placeholder-email'"),
            controller: viewModel.emailController,
            data: viewModel.emailCodeData,
            onChanged: viewModel.onEmailChange,
            inputFormatters: denySpace(),
          ),

          ///MARK:信箱驗證碼
          LoginEmailCodeView(
            needVerifyButton: false,
            hintText: tr("placeholder-emailCode'"),
            controller: viewModel.emailCodeController,
            onPressSendCode: () => viewModel.onPressSendCode(context),
            onPressCheckVerify: () {},
            data: viewModel.emailCodeData,
            onChanged: (value) => viewModel.initResult(viewModel.tagEmailCode),
            btnVerifyText: tr('verify'),
            btnGetText: tr('get'),
            // onPressVerification: viewModel.checkEmailFormat,
          )
        ]);
  }

  Widget _buildButton() {
    return LoginButtonWidget(
      // Confirm按鈕
        isShowProgress: viewModel.isProcess,
        btnText: tr('confirm'),
        radius: 30,
        onPressed: () => viewModel.onPressConfirm(context));
  }

  List<TextInputFormatter> denySpace() {
    return [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
  }

}