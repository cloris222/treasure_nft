import 'package:flutter/material.dart';

import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';

class TetherCoinWidget extends StatelessWidget {
  const TetherCoinWidget({Key? key, this.size}) : super(key: key);
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImagePath.tetherImg,
        width: size ?? UIDefine.fontSize22,
        height: size ?? UIDefine.fontSize22,
        fit: BoxFit.contain);
  }
}
