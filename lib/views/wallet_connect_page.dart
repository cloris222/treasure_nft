import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../constant/theme/app_colors.dart';
import '../constant/ui_define.dart';
import '../models/http/api/wallet_connect_api.dart';
import '../widgets/dialog/common_custom_dialog.dart';
import 'custom_appbar_view.dart';
import 'login/login_common_view.dart';

///MARK:選擇綁定的錢包對象
class WalletConnectPage extends ConsumerStatefulWidget {
  const WalletConnectPage({
    Key? key,
    required this.subTitle,
  }) : super(key: key);
  final String subTitle;

  @override
  ConsumerState createState() => _WalletConnectPageState();
}

class _WalletConnectPageState extends ConsumerState<WalletConnectPage> {
  BaseViewModel viewModel = BaseViewModel();

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: GlobalData.mainBottomType,
      body: SingleChildScrollView(
          child: LoginCommonView(
        pageHeight: UIDefine.getPixelWidth(1050),
        title: tr('bindWallet'),
        body: Container(
            margin: EdgeInsets.symmetric(
                vertical: UIDefine.getPixelHeight(10),
                horizontal: UIDefine.getPixelWidth(20)),
            padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
            child: _buildBody()),
      )),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTitle(),
        _buildMetamask(),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      BaseIconWidget(
          imageAssetPath: AppImagePath.walletConnectIcon,
          size: UIDefine.getPixelWidth(30)),
      SizedBox(width: UIDefine.getPixelWidth(5)),
      Text(widget.subTitle,
          style: AppTextStyle.getBaseStyle(
              color: AppColors.textThreeBlack,
              fontSize: UIDefine.fontSize18,
              fontWeight: FontWeight.w600)),
    ]);
  }

  Widget _buildMetamask() {
    return GestureDetector(
      onTap: _bindMetamaskWallet,
      child: Container(
        decoration: AppStyle()
            .styleColorBorderBackground(color: AppColors.bolderGrey, radius: 8),
        padding: EdgeInsets.symmetric(
            horizontal: UIDefine.getPixelWidth(10),
            vertical: UIDefine.getPixelWidth(5)),
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
        child: Row(
          children: [
            BaseIconWidget(
                imageAssetPath: AppImagePath.metamaskIcon,
                size: UIDefine.getPixelWidth(30)),
            SizedBox(width: UIDefine.getPixelWidth(5)),
            Text('Metamask',
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textSixBlack,
                    fontSize: UIDefine.fontSize14,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _bindMetamaskWallet() {
    ref.read(connectWalletProvider.notifier).connectWallet(
        getNonce: (String address) async {
      return await WalletConnectAPI().getUserNonce(address);
    }, getWalletInfo: (WalletInfo walletInfo) async {
      GlobalData.printLog('walletInfo.address:${walletInfo.address}');
      GlobalData.printLog('walletInfo.personalSign:${walletInfo.personalSign}');

      ///MARK: 授權完成後，會回傳此結果
      WalletConnectAPI(
              onConnectFail: (errorMessage) => _bindFailDialog(errorMessage))
          .postCheckWalletVerifySign(walletInfo)
          .then((value) {
        viewModel.onBaseConnectFail(context, tr('appBindSuccess'));
        Navigator.pop(context, walletInfo);
      });
    }, bindWalletFail: () {
      ///MARK: 授權失敗
      viewModel.onBaseConnectFail(context, tr('appBindFail'));
    });
  }

  void _bindFailDialog(String errorMessage) {
    CommonCustomDialog(context,
        type: DialogImageType.fail,
        title: tr('appBindFail'),
        rightBtnText: tr('confirm'),
        content: tr(errorMessage),
        onLeftPress: () {}, onRightPress: () {
      viewModel.popPage(context);
    }).show();
  }
}
