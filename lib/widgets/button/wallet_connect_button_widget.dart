import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import 'icon_bolder_button_widget.dart';
import 'login_bolder_button_widget.dart';

class WalletConnectButtonWidget extends ConsumerWidget {
  const WalletConnectButtonWidget({
    required this.btnText,
    required this.bindWalletTitle,
    required this.getWalletInfo,
    required this.needChangeText,
    Key? key,
  }) : super(key: key);
  final Function(WalletInfo? walletInfo) getWalletInfo;
  final String btnText;
  final String bindWalletTitle;
  final bool needChangeText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget walletIcon = BaseIconWidget(
        imageAssetPath: AppImagePath.walletConnectIcon,
        size: UIDefine.getPixelWidth(25));

    ///MARK:通過錢包註冊
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer(builder: (context, ref, _) {
          final connectStatus = ref.watch(connectWalletProvider);
          return SizedBox(
              child: connectStatus.whenOrNull(
            init: () => IconBolderButtonWidget(
                icon: walletIcon,
                btnText: btnText,
                radius: 8,
                onPressed: () async {
                  getWalletInfo(await BaseViewModel().pushWalletConnectPage(
                    context,
                    subTitle: bindWalletTitle,
                    needVerifyAPI: false,
                  ));
                }),
            loading: () => IconBolderButtonWidget(
                icon: walletIcon,
                btnText: btnText,
                radius: 8,
                onPressed: () async {
                  getWalletInfo(await BaseViewModel().pushWalletConnectPage(
                    context,
                    subTitle: bindWalletTitle,
                    needVerifyAPI: false,
                  ));
                }),
            data: (wallet) => needChangeText
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${tr('walletAddress')} :',
                          style: AppTextStyle.getBaseStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: UIDefine.fontSize14)),
                      Text(
                        wallet.address,
                        style: AppTextStyle.getBaseStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: UIDefine.fontSize14),
                      ),
                    ],
                  )
                : LoginBolderButtonWidget(
                    btnText: btnText,
                    onPressed: () async {
                      getWalletInfo(await BaseViewModel().pushWalletConnectPage(
                        context,
                        subTitle: bindWalletTitle,
                        needVerifyAPI: false,
                      ));
                    }),
          ));
        }),
        Divider(
            height: UIDefine.getPixelWidth(30),
            color: AppColors.bolderGrey,
            thickness: 1)
      ],
    );
  }
}
