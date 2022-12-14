import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../../constant/ui_define.dart';

class AnimationDialog extends BaseDialog {
  AnimationDialog(super.context, this.animationPathJson);

  final String animationPathJson;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
                constraints:
                    BoxConstraints(minHeight: UIDefine.getPixelHeight(280),minWidth: UIDefine.getWidth()*0.9),
                child: Lottie.asset(animationPathJson)),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Text(
                  tr("reserve-success'"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: UIDefine.fontSize22),
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
              style: TextStyle(
                  fontSize: UIDefine.fontSize14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            ActionButtonWidget(
                isFillWidth: false,
                isBorderStyle: false,
                btnText: tr("confirm"),
                onPressed: () {
                  Navigator.pop(context);
                })
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
