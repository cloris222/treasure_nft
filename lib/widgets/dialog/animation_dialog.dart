import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/utils/animation_download_util.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/ui_define.dart';

class AnimationDialog extends BaseDialog {
  AnimationDialog(super.context, this.animationPathJson);

  final String animationPathJson;

  @override
  Widget initContent(BuildContext context, StateSetter setState,WidgetRef ref) {
    String? path =
        AnimationDownloadUtil().getAnimationFilePath(animationPathJson);

    return Column(
      children: [
        Stack(
          children: [
            Container(
                constraints: BoxConstraints(
                    minHeight: UIDefine.getPixelHeight(280),
                    minWidth: UIDefine.getWidth() * 0.9),
                child:
                    path != null ? Lottie.file(File(path)) : const SizedBox()),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Text(
                  tr("reserve-success'"),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize22),
                ))
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              tr("reserve-success-text'"),
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginButtonWidget(
                    isFillWidth: false,
                    btnText: tr("confirm"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            )
          ],
        )
      ],
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  Future<void> initValue() async {
    // TODO: implement initValue
  }
}
