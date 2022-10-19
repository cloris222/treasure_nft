import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../view_models/wallet/wallet_main_viewmodel.dart';
import '../../widgets/label/wallet_info_item.dart';

class WalletMainView extends StatefulWidget {
  const WalletMainView({Key? key}) : super(key: key);

  @override
  State<WalletMainView> createState() => _WalletMainViewState();
}

class _WalletMainViewState extends State<WalletMainView> {
  late WalletMainViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = WalletMainViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const DomainBar(),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          runSpacing: 25,
          children: [
            const SizedBox(width: 1),
            _buildTitle(),
            _buildWalletInfo(),
            _buildWalletAddress(),
            _buildWalletFunction(),
            _buildWalletAccount(),
            _buildWalletHistory(),
            const SizedBox(width: 1),
          ],
        ),
      ),
    ]);
  }

  Widget _buildTitle() {
    return Row(children: [
      Image.asset(
        AppImagePath.walletIcon,
        width: UIDefine.fontSize26,
        height: UIDefine.fontSize26,
        fit: BoxFit.contain,
      ),
      const SizedBox(width: 10),
      Text(
        tr('assets'),
        style: TextStyle(
            fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w600),
      )
    ]);
  }

  Widget _buildWalletInfo() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleUserSetting(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Flexible(
              child: WalletInfoItem(
                  title: tr('totalAccountEarnings'),
                  value: viewModel.userProperty?.income)),
          Flexible(
              child: WalletInfoItem(
                  title: tr('extracted'),
                  value: viewModel.userProperty?.withdraw)),
          Flexible(
              child: WalletInfoItem(
                  title: tr('notExtracted'),
                  value: viewModel.userProperty?.balance)),
        ],
      ),
    );
  }

  Widget _buildWalletAddress() {
    return Container();
  }

  Widget _buildWalletFunction() {
    return Container();
  }

  Widget _buildWalletAccount() {
    return Container();
  }

  Widget _buildWalletHistory() {
    return Container();
  }
}
