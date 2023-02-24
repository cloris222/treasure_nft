import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:wallet_connect_plugin/model/wallet_info.dart';
import 'package:wallet_connect_plugin/provider/begin_provider.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import 'login_bolder_button_widget.dart';

class WalletConnectButtonWidget extends ConsumerWidget {
  const WalletConnectButtonWidget({
    required this.btnText,
    required this.bindWalletTitle,
    required this.getWalletInfo,
    Key? key,
  }) : super(key: key);
  final Function(WalletInfo? walletInfo) getWalletInfo;
  final String btnText;
  final String bindWalletTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///MARK:通過錢包註冊
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer(builder: (context, ref, _) {
          final connectStatus = ref.watch(connectWalletProvider);
          return SizedBox(
              child: connectStatus.whenOrNull(
            init: () => LoginBolderButtonWidget(
                btnText: btnText,
                onPressed: () async {
                  getWalletInfo(await BaseViewModel().pushWalletConnectPage(
                    context,
                    subTitle: bindWalletTitle,
                  ));
                }),
            loading: () => const SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
            data: (wallet) => Column(
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
            ),
          ));
        }),
        Divider(
            height: UIDefine.getPixelWidth(20),
            color: AppColors.bolderGrey,
            thickness: 1)
      ],
    );
  }
}
