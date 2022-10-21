import 'package:flutter/material.dart';
import '../../../constant/ui_define.dart';

class BaseIconWidget extends StatelessWidget {
  const BaseIconWidget({Key? key, this.size, required this.imageAssetPath})
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
