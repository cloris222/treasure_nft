import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../../constant/ui_define.dart';

class AnimationDialog extends BaseDialog {
  AnimationDialog(super.context, this.animationPathJson);

  final String animationPathJson;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Stack(
      children: [
        Container(
          height: UIDefine.getHeight()/1.8,),
        Lottie.asset(animationPathJson),
        Positioned(
          bottom: 0,
            left: 0,
            right: 0,
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr("reserve-success'"),
              style: TextStyle(fontSize: UIDefine.fontSize22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              tr("reserve-success-text'"),
              style: TextStyle(fontSize: UIDefine.fontSize16),
            ),
            ActionButtonWidget(
                margin:
                    EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 5),
                isBorderStyle: false,
                btnText: tr("confirm"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ))
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
