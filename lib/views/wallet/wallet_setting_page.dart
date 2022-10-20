import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/coin_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_theme.dart';
import '../../view_models/wallet/wallet_setting_viewmodel.dart';
import '../../widgets/label/coin/base_coin_widget.dart';
import '../../widgets/label/gradient_bolder_widget.dart';

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
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('uc_setting')),
      body: SingleChildScrollView(child: _buildBody()),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typeWallet),
    );
  }

  Widget _buildBody() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          _buildSettingParam(CoinEnum.TRON, viewModel.trcController),
          _buildSettingParam(CoinEnum.BSC, viewModel.bscController),
          _buildSettingParam(CoinEnum.ROLLOUT, viewModel.rolloutController),
        ]));
  }

  Widget _buildSettingParam(CoinEnum coin, TextEditingController controller) {
    return GradientBolderWidget(
        height: UIDefine.getHeight() / 4,
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  BaseCoinWidget(imageAssetPath: viewModel.getCoinImage(coin)),
                  Text(viewModel.getCoinTitle(coin))
                ],
              ),
              Text(tr('address')),
              TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(
                        10, UIDefine.getScreenWidth(4.16), 0, 0),
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
