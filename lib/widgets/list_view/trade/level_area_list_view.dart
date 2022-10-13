import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../gradient_text.dart';

class LevelListViewCell extends StatefulWidget {
  const LevelListViewCell({Key? key, this.isBeginner = true}) : super(key: key);

  final bool isBeginner;

  @override
  State<LevelListViewCell> createState() => _LevelListViewCellState();
}

class _LevelListViewCellState extends State<LevelListViewCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.isBeginner
                      ? AppImagePath.beginner
                      : AppImagePath.tetherImg,
                ),
                const SizedBox(
                  width: 10,
                ),
                widget.isBeginner
                    ? GradientText(
                        tr('noviceArea'),
                        size: UIDefine.fontSize24,
                        weight: FontWeight.bold,
                        starColor: AppColors.mainThemeButton,
                        endColor: AppColors.subThemePurple,
                      )
                    : Text('1 - 50')
              ],
            ),
            Row(
              children: [
                Image.asset(widget.isBeginner
                    ?AppImagePath.beginnerReserving : AppImagePath.reserving),
                widget.isBeginner
                    ?
                GradientText(
                  tr('matching'),
                  size: UIDefine.fontSize16,
                  weight: FontWeight.bold,
                  starColor: AppColors.mainThemeButton,
                  endColor: AppColors.subThemePurple,
                ) : Text( tr('matching'))
              ],
            )
          ],
        )
      ],
    );
  }
}
