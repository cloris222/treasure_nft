import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';

import '../../../constant/enum/coin_enum.dart';
import '../../../constant/global_data.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_style.dart';
import '../../../constant/theme/app_theme.dart';
import '../../../view_models/personal/orders/order_recharge_viewmodel.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/dialog/common_custom_dialog.dart';
import '../../../widgets/label/coin/tether_coin_widget.dart';

///MARK: 充值
class OrderRechargePage extends StatefulWidget {
  const OrderRechargePage(
      {Key? key, this.type = AppNavigationBarType.typePersonal})
      : super(key: key);
  final AppNavigationBarType type;

  @override
  State<OrderRechargePage> createState() => _OrderRechargePageState();
}

class _OrderRechargePageState extends State<OrderRechargePage> {
  late OrderRechargeViewModel viewModel;
  GlobalKey repaintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    viewModel = OrderRechargeViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
            child:
                TitleAppBar(title: tr('walletRecharge'), needArrowIcon: false),
          ),
          Expanded(child: SingleChildScrollView(child: _buildBody())),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
      child: Column(
        children: [
          SizedBox(height: UIDefine.getScreenWidth(0.97)),
          _buildChoseAddress(),
          Wrap(
            runSpacing: 20,
            children: [
              const SizedBox(width: 1),
              _buildAddressInfo(),
              _buildAddressPath(),
              _buildAddressChain(),
              const SizedBox(width: 1),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChoseAddress() {
    return DropdownButtonFormField(
        icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
        onChanged: (newValue) {
          setState(() {
            viewModel.currentChain = newValue!;
          });
        },
        value: viewModel.currentChain,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
              UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
          hintStyle:  AppTextStyle.getBaseStyle(height: 1.6, color: AppColors.textBlack),
          border: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.searchBar, radius: 10),
          focusedBorder: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.searchBar, radius: 10),
          enabledBorder: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.searchBar, radius: 10),
        ),
        items: [
          DropdownMenuItem(
              value: CoinEnum.TRON,
              child: Row(children: [
                TetherCoinWidget(size: UIDefine.fontSize24),
                Text('  USDT-TRC20',
                    style: AppTextStyle.getBaseStyle(
                        color: viewModel.currentChain == CoinEnum.TRON
                            ? AppColors.deepBlue
                            : AppColors.searchBar))
              ])),
          DropdownMenuItem(
              value: CoinEnum.BSC,
              child: Row(children: [
                TetherCoinWidget(size: UIDefine.fontSize24),
                Text('  USDT-BSC',
                    style: AppTextStyle.getBaseStyle(
                        color: viewModel.currentChain == CoinEnum.BSC
                            ? AppColors.deepBlue
                            : AppColors.searchBar))
              ]))
        ]);
  }

  Widget _buildAddressInfo() {
    return Wrap(
      runSpacing: 10,
      children: [
        Text(tr('rechargeNetwork'),
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize16,
                color: AppColors.dialogBlack,
                fontWeight: FontWeight.w500)),
        _buildAddressHint(),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(10)),
          child: Column(
            children: [
              const SizedBox(height: 5),
              RepaintBoundary(
                key: repaintKey,
                child: QrImage(
                  errorStateBuilder: (context, error) => Text(error.toString()),
                  data:
                      GlobalData.userWalletInfo?[viewModel.currentChain.name] ??
                          '',
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.mainThemeButton,
                  size: UIDefine.getWidth() / 2,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () => _onSaveQRCode(),
                child: Container(
                  decoration: AppStyle().styleUserSetting(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(tr('saveQrcode')),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        Text("${tr("recharge-hint-1'")} ${tr("recharge-hint-2'")}",
            maxLines: 2,
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.homeGrey)),
        const SizedBox(width: 1),
      ],
    );
  }

  Widget _buildAddressPath() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleUserSetting(),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('rechargeUaddr'),
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.dialogBlack,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                  child: Text(
                      GlobalData.userWalletInfo?[viewModel.currentChain.name] ??
                          '',
                      maxLines: 2,
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize12,
                          color: AppColors.dialogGrey,
                          fontWeight: FontWeight.w500))),
              const SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    viewModel.copyText(
                        copyText: GlobalData
                            .userWalletInfo?[viewModel.currentChain.name]);
                    viewModel.showToast(context, tr('copiedSuccess'));
                  },
                  child: Image.asset(AppImagePath.copyIcon))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAddressChain() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleUserSetting(),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Row(
        children: [
          Text(
            tr('chain'),
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.dialogBlack,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 5),
          Text(
              viewModel.currentChain == CoinEnum.TRON
                  ? 'TRON (TRC-20)'
                  : 'BSC (BEP-20)',
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12,
                  color: AppColors.textHintBlack,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  Widget _buildAddressHint() {
    return Column(children: [
      Row(
        children: [
          Text(tr("minimum-rechargeAmount'"),
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12, color: AppColors.homeGrey)),
          SizedBox(width: UIDefine.getPixelWidth(5)),
          Text('10 USDT',
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12, color: AppColors.homeGrey))
        ],
      ),
      SizedBox(height: UIDefine.getScreenWidth(2.77)),
      Text(
          '${tr("minimum-rechargeAmount-start'")} ${viewModel.currentChain == CoinEnum.TRON ? 'USDT-TRC20' : 'USDT-BSC'} ${tr("minimum-rechargeAmount-end'")}',
          maxLines: 2,
          textAlign: TextAlign.start,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12, color: AppColors.textRed)),
      SizedBox(height: UIDefine.getScreenWidth(6)),
    ]);
  }

  Future<PermissionStatus> _getStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      final result = await Permission.storage.request();
      return result;
    } else {
      return status;
    }
  }

  void showStorageDialog() {
    CommonCustomDialog(context,
        bOneButton: false,
        type: DialogImageType.warning,
        title: tr("G_0403"),
        content: tr('goPermissionStorage'),
        leftBtnText: tr('cancel'),
        rightBtnText: tr('confirm'), onLeftPress: () {
      Navigator.pop(context);
    }, onRightPress: () {
      openAppSettings();
      Navigator.pop(context);
    }).show();
  }

  void _onSaveQRCode() async {
    PermissionStatus status = await _getStoragePermission();
    if (status == PermissionStatus.permanentlyDenied) {
      showStorageDialog();
    }

    if (status.isGranted) {
      // 檢查權限
      if (mounted) {
        viewModel.onSaveQrcode(context, repaintKey);
      }
    }
  }
}
