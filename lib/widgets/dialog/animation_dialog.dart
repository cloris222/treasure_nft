import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

class AnimationDialog extends BaseDialog {
  AnimationDialog(super.context, this.animationPathJson);

  final String animationPathJson;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(animationPathJson),
      ],
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  void initValue() {
    // TODO: implement initValue
  }
}
