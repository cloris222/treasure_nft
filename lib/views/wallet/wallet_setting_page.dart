import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/coin_enum.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_theme.dart';
import '../../view_models/wallet/wallet_setting_viewmodel.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/label/icon/base_icon_widget.dart';
import '../login/login_email_code_view.dart';

///MARK: 支付設置
class WalletSettingPage extends StatefulWidget {
  const WalletSettingPage({Key? key}) : super(key: key);

  @override
  State<WalletSettingPage> createState() => _WalletSettingPageState();
}

class _WalletSettingPageState extends State<WalletSettingPage> {
  late WalletSettingViewModel viewModel;
  EdgeInsetsGeometry mainPadding = EdgeInsets.symmetric(
      horizontal: UIDefine.getPixelWidth(20),
      vertical: UIDefine.getPixelWidth(10));

  @override
  void initState() {
    super.initState();
    viewModel = WalletSettingViewModel(setState: setState);
    viewModel.initState();
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
      type: AppNavigationBarType.typeWallet,
      body: Column(
        children: [
          Container(
              margin:
                  EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
              child:
                  TitleAppBar(title: tr("uc_setting"), needCloseIcon: false)),
          Expanded(child: SingleChildScrollView(child: _buildBody())),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () => viewModel.clearAllFocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSettingEdit(),
          Container(
              width: UIDefine.getWidth(),
              height: UIDefine.getPixelWidth(5),
              color: AppColors.defaultBackgroundSpace),
          _buildEmailValid(),
          Container(
              width: double.infinity,
              height: UIDefine.getPixelWidth(2),
              color: AppColors.defaultBackgroundSpace),
          Padding(
            padding: mainPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LoginButtonWidget(
                    isFillWidth: false,
                    btnText: tr('Next'),
                    onPressed: () => viewModel.onCheckPayment(context),
                    enable: viewModel.checkEmail),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingParam(CoinEnum coin, TextEditingController controller) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: UIDefine.getScreenWidth(2.7),
            vertical: UIDefine.getPixelWidth(5)),
        child: Wrap(runSpacing: UIDefine.getScreenWidth(4), children: [
          Row(children: [
            BaseIconWidget(
                imageAssetPath: viewModel.getCoinImage(coin),
                size: UIDefine.fontSize26),
            const SizedBox(width: 8),
            SizedBox(
                width: UIDefine.getScreenWidth(68),
                child: Text(viewModel.getCoinTitle(coin),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize14,
                        fontWeight: FontWeight.w600)))
          ]),
          const SizedBox(height: 5),
          Text(tr('address'),
              style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14)),
          TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(
                    UIDefine.getScreenWidth(2.77),
                    UIDefine.getScreenWidth(4.16),
                    0,
                    0),
                hintText: viewModel.getCoinHintText(coin),
                hintStyle: AppTextStyle.getBaseStyle(
                    height: 1.6, color: AppColors.bolderGrey),
                labelStyle: AppTextStyle.getBaseStyle(color: Colors.black),
                alignLabelWithHint: true,
                border: AppTheme.style.styleTextEditBorderBackground(
                    color: AppColors.bolderGrey, radius: 10),
                focusedBorder: AppTheme.style.styleTextEditBorderBackground(
                    color: AppColors.bolderGrey, radius: 10),
                enabledBorder: AppTheme.style.styleTextEditBorderBackground(
                    color: AppColors.bolderGrey, radius: 10),
              ))
        ]));
  }

  Widget _buildSettingEdit() {
    return Padding(
      padding: mainPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSettingParam(CoinEnum.TRON, viewModel.trcController),
          SizedBox(height: UIDefine.getPixelWidth(15)),
          _buildSettingParam(CoinEnum.BSC, viewModel.bscController),
          SizedBox(height: UIDefine.getPixelWidth(15)),
          _buildSettingParam(CoinEnum.ROLLOUT, viewModel.rolloutController),
          SizedBox(height: UIDefine.getPixelWidth(15)),
        ],
      ),
    );
  }

  Widget _buildEmailValid() {
    return Padding(
      padding: mainPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('emailValid'),
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500)),
          LoginEmailCodeView(
              countdownSecond: 60,
              onEditTap: viewModel.onClearData,
              btnGetText: tr('get'),
              hintText: tr("placeholder-emailCode'"),
              controller: viewModel.codeController,
              data: viewModel.codeData,
              onPressSendCode: () => viewModel.sendEmailCode(context),
              onPressCheckVerify: () => viewModel.checkEmailCode(context)),
        ],
      ),
    );
  }
}
