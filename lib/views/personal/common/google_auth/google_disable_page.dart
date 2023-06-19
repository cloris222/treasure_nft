
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/view_models/personal/common/google_auth/google_auth_view_model.dart';

import '../../../../constant/theme/app_colors.dart';
import '../../../../constant/theme/app_image_path.dart';
import '../../../../constant/theme/app_style.dart';
import '../../../../constant/ui_define.dart';
import '../../../../models/http/parameter/blacklist_config_data.dart';
import '../../../../models/http/parameter/google_auth_data.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../view_models/base_view_model.dart';
import '../../../../view_models/gobal_provider/global_tag_controller_provider.dart';
import '../../../../view_models/personal/common/google_auth/google_auth_provider.dart';
import '../../../../view_models/personal/common/google_auth/google_disable_view_model.dart';
import '../../../../widgets/app_bottom_navigation_bar.dart';
import '../../../../widgets/appbar/title_app_bar.dart';
import '../../../../widgets/button/login_button_widget.dart';
import '../../../../widgets/label/gradient_bolder_widget.dart';
import '../../../custom_appbar_view.dart';
import '../../../login/login_email_code_view.dart';
import '../../../login/login_param_view.dart';

///MARK: 解除google驗證
class GoogleDisablePage extends ConsumerStatefulWidget {
  const GoogleDisablePage(this.blacklistConfigData, {
    Key? key,
  }) : super(key: key);

  final BlacklistConfigData blacklistConfigData;

  @override
  ConsumerState createState() => _GoogleDisablePageState();
}

class _GoogleDisablePageState extends ConsumerState<GoogleDisablePage> {
  BlacklistConfigData get blacklistConfigData => widget.blacklistConfigData;
  late GoogleDisableViewModel viewModel;

  @override
  void initState() {
    viewModel = GoogleDisableViewModel(ref, setState: setState);
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
              title: tr('liftedGoogle'),
              needCloseIcon: true,
              needArrowIcon: false,
            ),
            SizedBox(height: UIDefine.getPixelHeight(24)),
            _buildHint(),
            SizedBox(height: UIDefine.getPixelHeight(16)),
            _buildPassword(),
            SizedBox(height: UIDefine.getPixelHeight(16)),
            _buildEMailVerify(),
            SizedBox(height: UIDefine.getPixelWidth(50)),
            _buildButton(),
            SizedBox(height: UIDefine.getPixelWidth(100)),
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
        child: Text(format(tr("googleCheckText"),
            {"time": viewModel.formatDuration(
                blacklistConfigData.unableWithdrawByGoogle)}
        ),
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

  ///MARK:信箱驗證碼
  Widget _buildEMailVerify() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Text(tr("email"),
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14,
              color: AppColors.textThreeBlack)),

      LoginEmailCodeView(
        needVerifyButton: false,
        hintText: tr("placeholder-emailCode'"),
        controller: viewModel.verifyController,
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