import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';

import '../../constant/theme/app_colors.dart';
import '../../view_models/login/wallet_bind_view_model.dart';

class WalletLoginHintDialog extends BaseDialog {
  WalletLoginHintDialog(super.context, {required this.walletInfo});

  final WalletInfo walletInfo;

  @override
  Widget initContent(
      BuildContext context, StateSetter setState, WidgetRef ref) {
    return Column(children: [
      BaseIconWidget(
          imageAssetPath: AppImagePath.walletConnectCheckIcon,
          size: UIDefine.getPixelWidth(80)),
      SizedBox(height: UIDefine.getPixelWidth(20)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
        child: Text(
          tr('appLoginCheck'),
          textAlign: TextAlign.center,
          style: AppTextStyle.getBaseStyle(
              color: AppColors.textThreeBlack,
              fontWeight: FontWeight.w600,
              fontSize: UIDefine.fontSize16),
        ),
      ),
      SizedBox(height: UIDefine.getPixelWidth(20)),
      LoginButtonWidget(
          radius: 8,
          btnText: tr('appHasAccount'),
          onPressed: _onPressLogin,
          fontWeight: FontWeight.w600,
          fontSize: UIDefine.fontSize14),
      LoginBolderButtonWidget(
          radius: 8,
          btnText: tr('appNotHasAccount'),
          onPressed: () =>
              _onPressRegisterWithWalletInfo(context, ref, walletInfo),
          fontWeight: FontWeight.w600,
          fontSize: UIDefine.fontSize14)
    ]);
  }

  @override
  Widget initTitle() {
    return const SizedBox();
  }

  @override
  Future<void> initValue() async {}

  void _onPressLogin() {
    BaseViewModel().pushPage(context,
        MainPage(type: AppNavigationBarType.typeLogin, walletInfo: walletInfo));
  }

  void _onPressRegisterWithWalletInfo(
      BuildContext context, WidgetRef ref, WalletInfo walletInfo) async {
    WalletBindViewModel().registerWithWallet(context, ref,
        walletInfo: walletInfo, inviteCode: '');
  }
}
