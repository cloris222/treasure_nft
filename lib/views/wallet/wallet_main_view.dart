import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/views/wallet/data/app_purchase.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/bottom_sheet/page_bottom_sheet.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

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
  const WalletMainView({Key? key, required this.onPrePage}) : super(key: key);
  final onClickFunction onPrePage;

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
    return Container(
      color: AppColors.defaultBackgroundSpace,
      child: SingleChildScrollView(
        child: Column(children: [
          _buildWalletInfo(),
          Padding(
            padding: EdgeInsets.only(
                bottom: UIDefine.navigationBarPadding,
                left: UIDefine.getPixelWidth(20),
                right: UIDefine.getPixelWidth(20)),
            child: Wrap(
              runSpacing: UIDefine.getPixelWidth(10),
              children: [
                _buildWalletAddress(),
                _buildWalletFunction(),
                _buildWalletHistory(),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(children: [
      GestureDetector(
        onTap: _onBackView,
        child: Icon(Icons.arrow_back_ios,
            size: UIDefine.getPixelWidth(26), color: Colors.black),
      ),
    ]);
  }

  Widget _buildWalletInfo() {
    return Stack(
      children: [
        SizedBox(
            height: UIDefine.getPixelWidth(280), width: UIDefine.getWidth()),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: UIDefine.getPixelWidth(80),
            child: Container(
                decoration: AppStyle().styleColorsRadiusBackground(
                    color: AppColors.mainThemeButton, radius: 0))),
        Positioned(
            top: UIDefine.getPixelWidth(180),
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                decoration: AppStyle().styleColorsRadiusBackground(
                    color: AppColors.defaultBackgroundSpace, radius: 12))),
        Positioned(
          bottom: UIDefine.getPixelWidth(10),
          left: UIDefine.getPixelWidth(20),
          right: UIDefine.getPixelWidth(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: UIDefine.getPixelWidth(10)),
              _buildTitle(),
              SizedBox(height: UIDefine.getPixelWidth(10)),
              Container(
                width: UIDefine.getWidth(),
                decoration: AppStyle().styleNewUserSetting(),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${tr('uc_myAccount')}(USDT)',
                        style: TextStyle(fontSize: UIDefine.fontSize14)),
                    SizedBox(height: UIDefine.getPixelWidth(20)),
                    Text(
                        NumberFormatUtil().removeTwoPointFormat(
                            GlobalData.userProperty?.totalBalance ?? 0),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize40,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: UIDefine.getPixelWidth(30)),
                    Row(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWalletAddress() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleColorsRadiusBackground(),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Polygon',
                style: TextStyle(
                    fontSize: UIDefine.fontSize12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dialogBlack),
              ),
              SizedBox(width: UIDefine.getPixelWidth(10)),
              Text(
                tr('depositAddress'),
                style: TextStyle(
                    fontSize: UIDefine.fontSize12,
                    color: AppColors.dialogBlack),
              ),
            ],
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
                          fontSize: UIDefine.fontSize12,
                          color: AppColors.homeGrey,
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
    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(),
      child: Row(
        children: [
          _buildWalletFunctionItem(
              title: tr('uc_recharge'),
              assetPath: AppImagePath.walletRechargeIcon,
              onPress: _showRechargePage),
          const SizedBox(width: 15),
          _buildWalletFunctionItem(
              title: Platform.isIOS
                  ? tr("usdt-type-BUY_ITEM'")
                  : tr('uc_withdraw'),
              assetPath: AppImagePath.walletWithdrawIcon,
              onPress: Platform.isIOS ? _showAppPurchase : _showWithdrawPage),
          const SizedBox(width: 15),
          _buildWalletFunctionItem(
              title: tr('uc_setting'),
              assetPath: AppImagePath.walletSettingIcon,
              onPress: _showWalletSettingIcon),
        ],
      ),
    );
  }

  Widget _buildWalletFunctionItem(
      {required String title,
      required String assetPath,
      required GestureTapCallback onPress}) {
    return Expanded(
        child: InkWell(
            onTap: onPress,
            child: Container(
                width: UIDefine.getWidth(),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: UIDefine.getPixelWidth(20),
                    horizontal: UIDefine.getPixelWidth(15)),
                child: Column(children: [
                  Image.asset(assetPath),
                  SizedBox(height: UIDefine.getPixelWidth(10)),
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
    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(),
      padding: EdgeInsets.symmetric(
          vertical: UIDefine.getPixelWidth(20),
          horizontal: UIDefine.getPixelWidth(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Text(tr('historyLog'),
                style: TextStyle(
                    fontSize: UIDefine.fontSize16,
                    fontWeight: FontWeight.w500)),
            Flexible(child: Container()),
            InkWell(
              onTap: _showWalletRecord,
              child: Text(tr('all'),
                  style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textHintBlack)),
            ),
            InkWell(
              onTap: _showWalletRecord,
              child: Image.asset(AppImagePath.rightArrow,
                  width: UIDefine.fontSize22,
                  height: UIDefine.fontSize22,
                  fit: BoxFit.contain),
            )
          ]),
          Visibility(
            visible: viewModel.balanceRecordResponseDataList.isNotEmpty,
            child: Container(
                margin:
                    EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
                width: double.infinity,
                height: 1,
                color: AppColors.searchBar),
          ),
          _buildRecordListView(),
        ],
      ),
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
    PageBottomSheet(context,
            page:
                const OrderRechargePage(type: AppNavigationBarType.typeWallet))
        .show();
  }

  void _showWithdrawPage() {
    PageBottomSheet(context,
            page:
                const OrderWithdrawPage(type: AppNavigationBarType.typeWallet))
        .show();
  }

  void _showWalletSettingIcon() {
    PageBottomSheet(context, page: const WalletSettingPage()).show();
  }

  void _showWalletRecord() {
    viewModel.pushPage(context, const OrderInfoPage(bFromWallet: true));
  }

  void _showAppPurchase() {
    viewModel.pushPage(context, const AppPurchase());
  }

  void _onBackView() {
    widget.onPrePage();
  }
}
