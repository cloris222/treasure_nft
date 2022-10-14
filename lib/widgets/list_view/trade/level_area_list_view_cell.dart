import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/check_reservation_info.dart';
import '../../gradient_text.dart';

class LevelListViewCell extends StatefulWidget {
  const LevelListViewCell(
      {Key? key,
      required this.reservationAction,
      this.range,
      this.isNew = true})
      : super(key: key);

  final bool isNew;
  final ReserveRange? range;
  final VoidCallback reservationAction;

  @override
  State<LevelListViewCell> createState() => _LevelListViewCellState();
}

class _LevelListViewCellState extends State<LevelListViewCell> {
  String ifIsBeginnerImg() {
    if (GlobalData.userInfo.level == 0) {
      return AppImagePath.beginner;
    } else {
      return AppImagePath.tetherImg;
    }
  }

  Widget ifIsBeginnerLabel() {
    if (GlobalData.userInfo.level == 0) {
      return GradientText(
        tr('noviceArea'),
        size: UIDefine.fontSize20,
        weight: FontWeight.bold,
        starColor: AppColors.mainThemeButton,
        endColor: AppColors.subThemePurple,
      );
    } else {
      return Text(
        '${int.parse(widget.range?.startPrice.toStringAsFixed(0))} - ${int.parse(widget.range?.endPrice.toStringAsFixed(0))}',
        style: TextStyle(
            fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
      );
    }
  }

  String getLevelImg() {
    /// 新手區
    if (GlobalData.userInfo.level == 0) {
      return format(AppImagePath.levelMission, ({'level': '00'}));
    }
    int index = widget.range?.index ?? 0;
    return format(AppImagePath.levelMission, ({'level': '0${index + 1}'}));
  }

  Color getReservationBtnColor() {
    /// 新手區
    if (GlobalData.userInfo.level == 0) {
      return AppColors.reservationLevel0.withOpacity(0.7);
    }
    int index = widget.range?.index ?? 0;
    index = index + 1;
    if (index == 0) {
      return AppColors.reservationLevel0.withOpacity(0.7);
    } else if (index == 1) {
      return AppColors.reservationLevel1.withOpacity(0.7);
    } else if (index == 2) {
      return AppColors.reservationLevel2.withOpacity(0.7);
    } else if (index == 3) {
      return AppColors.reservationLevel3.withOpacity(0.7);
    } else if (index == 4) {
      return AppColors.reservationLevel4.withOpacity(0.7);
    } else if (index == 5) {
      return AppColors.reservationLevel5.withOpacity(0.7);
    }
    return AppColors.textBlack;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: UIDefine.getWidth() / 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Image.asset(
                      ifIsBeginnerImg(),
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(child: ifIsBeginnerLabel())
                  ],
                ),
              ),
              Row(
                children: [
                  Image.asset(widget.isNew
                      ? AppImagePath.beginnerReserving
                      : AppImagePath.reserving),
                  const SizedBox(
                    width: 5,
                  ),
                  widget.isNew
                      ? GradientText(
                          tr('matching'),
                          size: UIDefine.fontSize14,
                          weight: FontWeight.bold,
                          starColor: AppColors.mainThemeButton,
                          endColor: AppColors.subThemePurple,
                        )
                      : Text(tr('matching'))
                ],
              )
            ],
          ),
          Stack(
            children: [
              Image.asset(getLevelImg()),
              Positioned(
                right: 0,
                bottom: 0,
                child: ActionButtonWidget(
                    isFillWidth: false,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    setMainColor: getReservationBtnColor(),
                    btnText: tr("match"),
                    onPressed: widget.reservationAction),
              )
            ],
          )
        ],
      ),
    );
  }
}
