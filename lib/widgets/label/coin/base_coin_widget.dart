import 'package:flutter/material.dart';

import '../../../constant/theme/app_image_path.dart';
import '../../../constant/ui_define.dart';

class BaseCoinWidget extends StatelessWidget {
  const BaseCoinWidget({Key? key, this.size, required this.imageAssetPath})
      : super(key: key);
  final double? size;
  final String imageAssetPath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(imageAssetPath,
        width: size ?? UIDefine.fontSize22,
        height: size ?? UIDefine.fontSize22,
        fit: BoxFit.contain);
  }
}
