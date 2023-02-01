import 'package:flutter/material.dart';
import 'package:format/format.dart';

import '../../../constant/theme/app_image_path.dart';
import 'base_icon_widget.dart';

class LevelIconWidget extends StatelessWidget {
  const LevelIconWidget({Key? key, required this.level, this.size})
      : super(key: key);
  final int level;
  final double? size;

  @override
  Widget build(BuildContext context) {
    var path = format(AppImagePath.level, ({'level': level + 1}));

    return BaseIconWidget(
      imageAssetPath: path,
      size: size,
      fit: BoxFit.fill,
    );
  }
}
