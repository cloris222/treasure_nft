import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/coin_enum.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';

import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_theme.dart';
import '../../view_models/wallet/wallet_setting_viewmodel.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/label/icon/base_icon_widget.dart';
import '../../widgets/label/gradient_bolder_widget.dart';
import '../custom_appbar_view.dart';
import '../login/login_email_code_view.dart';

///MARK: 支付設置
class WalletSettingPage extends StatefulWidget {
  const WalletSettingPage({Key? key}) : super(key: key);

  @override
  State<WalletSettingPage> createState() => _WalletSettingPageState();
}

class _WalletSettingPageState extends State<WalletSettingPage> {
  late WalletSettingViewModel viewModel;

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
      body: SingleChildScrollView(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () => viewModel.clearAllFocus(),
      child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAppBar(title: tr("uc_setting")),
              _buildSettingParam(CoinEnum.TRON, viewModel.trcController),
              const SizedBox(height: 20),
              _buildSettingParam(CoinEnum.BSC, viewModel.bscController),
              const SizedBox(height: 20),
              _buildSettingParam(CoinEnum.ROLLOUT, viewModel.rolloutController),
              const SizedBox(height: 20),
              Text(tr('emailValid'),
                  style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w500)),
              LoginEmailCodeView(
                  countdownSecond: 60,
                  onEditTap: viewModel.onClearData,
                  btnGetText: tr('get'),
                  hintText: tr("placeholder-emailCode'"),
                  hintColor: AppColors.searchBar,
                  controller: viewModel.codeController,
                  data: viewModel.codeData,
                  onPressSendCode: () => viewModel.sendEmailCode(context),
                  onPressCheckVerify: () => viewModel.checkEmailCode(context)),
              const SizedBox(height: 10),
              LoginButtonWidget(
                  isGradient: false,
                  btnText: tr('save'),
                  onPressed: () => viewModel.onSavePayment(context),
                  enable: viewModel.checkEmail),
              SizedBox(height: UIDefine.navigationBarPadding)
            ],
          )),
    );
  }

  Widget _buildSettingParam(CoinEnum coin, TextEditingController controller) {
    return GradientBolderWidget(
        bolderWith: 3,
        autoHeight: true,
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: UIDefine.getScreenWidth(2.7),
                vertical: UIDefine.getScreenWidth(2.7)),
            child: Wrap(runSpacing: UIDefine.getScreenWidth(4), children: [
              Row(children: [
                BaseIconWidget(
                    imageAssetPath: viewModel.getCoinImage(coin),
                    size: UIDefine.fontSize26),
                const SizedBox(width: 8),
                SizedBox(
                    width: UIDefine.getScreenWidth(68),
                    child: Text(viewModel.getCoinTitle(coin),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w500)))
              ]),
              const SizedBox(height: 5),
              Text(tr('address'),
                  style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w500)),
              TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(
                        UIDefine.getScreenWidth(2.77),
                        UIDefine.getScreenWidth(4.16),
                        0,
                        0),
                    hintText: viewModel.getCoinHintText(coin),
                    hintStyle: const TextStyle(
                        height: 1.6, color: AppColors.searchBar),
                    labelStyle: const TextStyle(color: Colors.black),
                    alignLabelWithHint: true,
                    border: AppTheme.style.styleTextEditBorderBackground(
                        color: AppColors.searchBar, radius: 10),
                    focusedBorder: AppTheme.style.styleTextEditBorderBackground(
                        color: AppColors.searchBar, radius: 10),
                    enabledBorder: AppTheme.style.styleTextEditBorderBackground(
                        color: AppColors.searchBar, radius: 10),
                  ))
            ])));
  }
}
