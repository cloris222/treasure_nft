import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../constant/theme/app_colors.dart';
import '../constant/ui_define.dart';
import '../models/http/api/wallet_connect_api.dart';
import '../widgets/dialog/common_custom_dialog.dart';
import '../widgets/dialog/simple_custom_dialog.dart';
import 'custom_appbar_view.dart';
import 'login/login_common_view.dart';

///MARK:選擇綁定的錢包對象
class WalletConnectPage extends ConsumerStatefulWidget {
  const WalletConnectPage({
    Key? key,
    required this.subTitle,
    required this.needVerifyAPI,
    this.showBindSuccess = true,
  }) : super(key: key);
  final String subTitle;

  ///MARK: 給已登入帳號綁定用
  final bool needVerifyAPI;

  ///MARK: 是否自動顯示已綁定
  final bool showBindSuccess;

  @override
  ConsumerState createState() => _WalletConnectPageState();
}

class _WalletConnectPageState extends ConsumerState<WalletConnectPage> {
  BaseViewModel viewModel = BaseViewModel();

  @override
  void initState() {
    GlobalData.passBindWalletAction = false;
    super.initState();
  }

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
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SingleChildScrollView(
            child: LoginCommonView(
          pageHeight: UIDefine.getPixelWidth(550),
          title: tr('linkedWallet'),
          body: Container(
              margin: EdgeInsets.symmetric(
                  vertical: UIDefine.getPixelHeight(10),
                  horizontal: UIDefine.getPixelWidth(20)),
              padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
              child: _buildBody()),
        )),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        SizedBox(height: UIDefine.getPixelWidth(5)),
        _buildMetamask(),
        SizedBox(height: UIDefine.getPixelWidth(100)),
        _buildCancel(),
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
            vertical: UIDefine.getPixelWidth(10)),
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
        child: Row(
          children: [
            BaseIconWidget(
                imageAssetPath: AppImagePath.metamaskIcon,
                size: UIDefine.getPixelWidth(30)),
            SizedBox(width: UIDefine.getPixelWidth(10)),
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
    }, bindWalletFail: () {
      ///MARK: 授權失敗
      viewModel.onBaseConnectFail(context, tr('appBindFail'));
    }, verifyWalletInfo: (WalletInfo walletInfo) async {
      GlobalData.printLog('walletInfo.address:${walletInfo.address}');
      GlobalData.printLog('walletInfo.personalSign:${walletInfo.personalSign}');

      if (widget.needVerifyAPI) {
        ///MARK: 授權完成後，會回傳此結果
        try {
          await WalletConnectAPI(
                  onConnectFail: (errorMessage) =>
                      _bindFailDialog(errorMessage))
              .postCheckWalletVerifySign(walletInfo);
          GlobalData.printLog('驗證錢包成功');
          return true;
        } catch (e) {
          GlobalData.printLog('驗證錢包失敗');
          return false;
        }
      }
      return true;
    }, getWalletInfo: (WalletInfo walletInfo) async {
      GlobalData.printLog('walletInfo.address:${walletInfo.address}');
      GlobalData.printLog('walletInfo.personalSign:${walletInfo.personalSign}');

      ///MARK:代表授權&驗證都成功了
      if (widget.showBindSuccess) {
        SimpleCustomDialog(context,
                mainText: tr('appBindSuccess'), isSuccess: true)
            .show();
      }
      Navigator.pop(context, walletInfo);
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

  Widget _buildCancel() {
    return LoginBolderButtonWidget(
        btnText: tr('cancel'),
        radius: 22,
        onPressed: () {
          GlobalData.passBindWalletAction = true;
          viewModel.popPage(context);
        });
  }
}
