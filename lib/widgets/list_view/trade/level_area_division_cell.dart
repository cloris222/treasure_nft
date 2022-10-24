import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:format/format.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/models/data/trade_model_data.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/check_reservation_info.dart';
import '../../gradient_text.dart';

class DivisionCell extends StatefulWidget {
  DivisionCell(
      {Key? key,
      required this.reservationAction,
      this.range,
      required this.level,
      this.isNew = true})
      : super(key: key);

  final int level;
  final bool isNew;
  final ReserveRange? range;
  final VoidCallback reservationAction;

  @override
  State<DivisionCell> createState() => _DivisionCellState();
}

class _DivisionCellState extends State<DivisionCell> {
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


  /// 是否解鎖副本 && 開賣狀態動畫顯示
  showImg() {
    if (widget.range?.lock == true) {
      return getLockImg();
    } else if(widget.range?.used == true){
      return showGif();
    }
    else {
      return getLevelImg();
    }
  }

  /// 開賣狀態動畫顯示
  String showGif() {
    if (GlobalData.userInfo.level == 0) {
      return format(AppAnimationPath.reservationAnimation, ({'level': '00'}));
    }
    return format(
        AppAnimationPath.reservationAnimation, ({'level': '0${widget.level}'}));
  }

  /// 尚未開賣顯示圖
  String getLockImg() {
    if (GlobalData.userInfo.level == 0) {
      return format(AppImagePath.levelMissionLocked, ({'level': '00'}));
    }
    return format(
        AppImagePath.levelMissionLocked, ({'level': '0${widget.level}'}));
  }

  /// 可預約狀態顯示圖
  String getLevelImg() {
    /// 新手區
    if (GlobalData.userInfo.level == 0) {
      return format(AppImagePath.levelMission, ({'level': '00'}));
    }
    int index = widget.range?.index ?? 0;
    return format(AppImagePath.divisionLevel, ({'level': '0${widget.level}','index':'${index + 1}'}));
  }

  Color getReservationBtnColor() {
    /// 新手區
    if (GlobalData.userInfo.level == 0) {
      return AppColors.reservationLevel0.withOpacity(0.7);
    }

    if (widget.level == 0) {
      return AppColors.reservationLevel0.withOpacity(0.7);
    } else if (widget.level == 1) {
      return AppColors.reservationLevel1.withOpacity(0.7);
    } else if (widget.level == 2) {
      return AppColors.reservationLevel2.withOpacity(0.7);
    } else if (widget.level == 3) {
      return AppColors.reservationLevel3.withOpacity(0.7);
    } else if (widget.level == 4) {
      return AppColors.reservationLevel4.withOpacity(0.7);
    } else if (widget.level == 5) {
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
                  Visibility(
                    visible: widget.range!.used,
                    child: Image.asset(widget.level == 0
                        ? AppImagePath.beginnerReserving
                        : AppImagePath.reserving),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  /// 如果是預約狀態（顯示轉圈動畫）
                  Visibility(
                    visible: widget.range!.used,
                      child: !widget.range!.used
                      ? Container():GradientText(
                    tr('matching'),
                    size: UIDefine.fontSize14,
                    weight: FontWeight.bold,
                    starColor: AppColors.mainThemeButton,
                    endColor: AppColors.subThemePurple,
                  )
                  )
                ],
              )
            ],
          ),
          Stack(
            children: [
              Image.asset(showImg()),
              Positioned(
                right: 0,
                bottom: 0,
                child: Visibility(
                  /// is for sale? 等級不夠不顯示 或 已經被預約不顯示
                  visible: !widget.range!.lock && !widget.range!.used,
                  child: ActionButtonWidget(
                      isFillWidth: false,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      setMainColor: getReservationBtnColor(),
                      btnText: tr("match"),

                      /// 按下去後新增預約
                      onPressed: widget.reservationAction),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
