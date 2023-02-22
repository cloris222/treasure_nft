import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

class AppVersionUpdateDialog extends BaseDialog {
  AppVersionUpdateDialog(super.context, {super.isDialogCancel = false});

  @override
  Widget initContent(BuildContext context, StateSetter setState,WidgetRef ref) {
    return Column(
      children: [
        Image.asset(AppImagePath.appUpdateImage),
        SizedBox(height: UIDefine.getPixelWidth(5)),
        Text(
          tr('appUpdateTitle'),
          style: AppTextStyle.getBaseStyle(
              color: AppColors.textThreeBlack,
              fontSize: UIDefine.fontSize16,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: UIDefine.getPixelWidth(5)),
        Text(
          tr('appUpdateContext'),
          style: AppTextStyle.getBaseStyle(
              color: AppColors.textThreeBlack,
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: UIDefine.getPixelWidth(30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginButtonWidget(
                isFillWidth: false,
                btnText: tr('confirm'),
                fontWeight: FontWeight.w600,
                fontSize: UIDefine.fontSize14,
                onPressed: () => _onPressStore(context)),
          ],
        )
      ],
    );
  }

  @override
  Widget initTitle() {
    return const SizedBox();
  }

  @override
  Future<void> initValue() async {}

  void _onPressStore(BuildContext context) {
    BaseViewModel().launchInBrowser(Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=com.wanda.treasurenft&hl=en&gl=US"
        : "https://apps.apple.com/us/app/treasure-nft/id6444782351");
  }
}
