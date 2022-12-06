import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../../constant/enum/task_enum.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../utils/number_format_util.dart';

class MedalIconWidget extends StatelessWidget {
  const MedalIconWidget(
      {Key? key, required this.medal, this.size, this.enable = true})
      : super(key: key);
  final String medal;
  final double? size;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    for (int i = 0; i < AchievementCode.values.length; i++) {
      if (AchievementCode.values[i].name == medal) {
        index = i;
        break;
      }
    }

    String path = enable
        ? format(AppImagePath.medalIcon,
            {'mainNumber': NumberFormatUtil().integerTwoFormat(index + 1)})
        : AppImagePath.unableMedalIcon;
    return BaseIconWidget(imageAssetPath: path, size: size);
  }
}
