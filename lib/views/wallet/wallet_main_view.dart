import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/views/wallet/data/app_purchase.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../constant/global_data.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../view_models/wallet/wallet_main_view_model.dart';
import '../../widgets/label/coin/tether_coin_widget.dart';
import '../../widgets/label/wallet_info_item.dart';
import '../personal/orders/order_info_page.dart';
import '../personal/orders/order_recharge_page.dart';
import '../personal/orders/order_withdraw_page.dart';
import 'balance_record_item_view.dart';
import 'wallet_setting_page.dart';

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
    return SingleChildScrollView(
      child: Column(children: [
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
              // Visibility(
              //   visible: Platform.isIOS,
              //     child: _appPurchase()),
              _buildWalletAccount(),
              _buildWalletHistory(),
              _buildRecordListView(),
              _bottomMargin()
            ],
          ),
        ),
      ]),
    );
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
            fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
      )
    ]);
  }

  Widget _buildWalletInfo() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleUserSetting(),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Row(
        children: [
          Flexible(
              child: WalletInfoItem(
                  title: tr('totalAccountEarnings'),
                  value: GlobalData.userProperty?.income)),
          Flexible(
              child: WalletInfoItem(
                  title: tr('extracted'),
                  value: GlobalData.userProperty?.withdraw)),
          Flexible(
              child: WalletInfoItem(
                  title: tr('notExtracted'),
                  value: GlobalData.userProperty?.balance)),
        ],
      ),
    );
  }

  Widget _buildWalletAddress() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleUserSetting(),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${tr('rechargeUaddr')}(TRC-20)',
            style: TextStyle(
                fontSize: UIDefine.fontSize16, color: AppColors.dialogBlack),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                  child: Text(
                      GlobalData.userWalletInfo != null
                          ? GlobalData.userWalletInfo!['TRON']
                          : '',
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: UIDefine.fontSize14,
                          color: AppColors.dialogBlack,
                          fontWeight: FontWeight.w400))),
              const SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    viewModel.copyText(
                        copyText: GlobalData.userWalletInfo?['TRON']);
                    viewModel.showToast(context, tr('copiedSuccess'));
                  },
                  child: Image.asset(AppImagePath.copyIcon))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWalletFunction() {
    return Row(
      children: [
        _buildWalletFunctionItem(
            title: tr('uc_recharge'),
            assetPath: AppImagePath.walletRechargeIcon,
            onPress: _showRechargePage),
        const SizedBox(width: 15),
        _buildWalletFunctionItem(
            title:
                Platform.isIOS ? tr("usdt-type-BUY_ITEM'") : tr('uc_withdraw'),
            assetPath: AppImagePath.walletWithdrawIcon,
            onPress: Platform.isIOS ? _showAppPurchase : _showWithdrawPage),
        const SizedBox(width: 15),
        _buildWalletFunctionItem(
            title: tr('uc_setting'),
            assetPath: AppImagePath.walletSettingIcon,
            onPress: _showWalletSettingIcon),
      ],
    );
  }

  Widget _buildWalletFunctionItem(
      {required String title,
      required String assetPath,
      required GestureTapCallback onPress}) {
    return Flexible(
        child: InkWell(
            onTap: onPress,
            child: Container(
                width: UIDefine.getWidth(),
                alignment: Alignment.center,
                decoration: AppStyle().styleUserSetting(),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(children: [
                  Image.asset(assetPath),
                  Text(title,
                      style: TextStyle(
                          fontSize: UIDefine.fontSize14,
                          color: AppColors.dialogGrey))
                ]))));
  }

  Widget _appPurchase() {
    return LoginButtonWidget(
        btnText: tr("usdt-type-BUY_ITEM'"),
        showIcon: true,
        onPressed: _showAppPurchase);
  }

  Widget _buildWalletAccount() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(tr('uc_myAccount'),
          style: TextStyle(
              fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500)),
      const SizedBox(height: 10),
      Row(children: [
        TetherCoinWidget(size: UIDefine.fontSize26),
        const SizedBox(width: 5),
        Text(tr('usdt'),
            style: TextStyle(
                fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500)),
        Flexible(child: Container()),
        Text(
            NumberFormatUtil()
                .removeTwoPointFormat(GlobalData.userProperty?.balance),
            style: TextStyle(
                fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500))
      ])
    ]);
  }

  Widget _buildWalletHistory() {
    return Row(
      children: [
        Text(tr('historyLog'),
            style: TextStyle(
                fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500)),
        Flexible(child: Container()),
        InkWell(
          onTap: _showWalletRecord,
          child: Image.asset(AppImagePath.walletLogIcon,
              width: UIDefine.fontSize22,
              height: UIDefine.fontSize22,
              fit: BoxFit.contain),
        )
      ],
    );
  }

  Widget _buildRecordListView() {
    // 顯示最近的15筆紀錄, 訂單信息功能才顯示完整所有紀錄
    return Visibility(
      visible: viewModel.balanceRecordResponseDataList.isNotEmpty,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.balanceRecordResponseDataList.length,
          itemBuilder: (context, index) {
            return BalanceRecordItemView(
                data: viewModel.balanceRecordResponseDataList[index]);
          }),
    );
  }

  Widget _bottomMargin() {
    return Visibility(
        visible: viewModel.balanceRecordResponseDataList.isEmpty,
        child: const SizedBox(width: 1));
  }

  void _showRechargePage() {
    viewModel.pushPage(context,
        const OrderRechargePage(type: AppNavigationBarType.typeWallet));
  }

  void _showWithdrawPage() {
    viewModel.pushPage(context,
        const OrderWithdrawPage(type: AppNavigationBarType.typeWallet));
  }

  void _showWalletSettingIcon() {
    viewModel.pushPage(context, const WalletSettingPage());
  }

  void _showWalletRecord() {
    viewModel.pushPage(context, const OrderInfoPage(bFromWallet: true));
  }

  void _showAppPurchase() {
    viewModel.pushPage(context, const AppPurchase());
  }
}
