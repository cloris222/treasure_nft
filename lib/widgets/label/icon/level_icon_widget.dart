import 'package:flutter/material.dart';
import 'package:format/format.dart';

import '../../../constant/theme/app_image_path.dart';
import 'base_icon_widget.dart';

class LevelIconWidget extends StatelessWidget {
  const LevelIconWidget(
      {Key? key, required this.level, this.size, this.needBig = false})
      : super(key: key);
  final int level;
  final double? size;
  final bool needBig;

  @override
  Widget build(BuildContext context) {
    var path = format(needBig ? AppImagePath.levelBig : AppImagePath.level,
        ({'level': level + 1}));

    return BaseIconWidget(
      imageAssetPath: path,
      size: size,
      fit: BoxFit.fill,
    );
  }
}
