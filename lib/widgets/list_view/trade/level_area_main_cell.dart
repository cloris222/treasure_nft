import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/views/trade/trade_division_view.dart';
import '../../../constant/global_data.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/ui_define.dart';
import '../../button/action_button_widget.dart';
import '../../gradient_text.dart';

class LevelMainCell extends StatefulWidget {
  const LevelMainCell({Key? key, required this.level,})
      : super(key: key);

  final int level;

  @override
  State<LevelMainCell> createState() => _LevelMainCellState();
}

class _LevelMainCellState extends State<LevelMainCell> {
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
        //'${int.parse(widget.range?.startPrice.toStringAsFixed(0))} - ${int.parse(widget.range?.endPrice.toStringAsFixed(0))}',
        'Level ${widget.level}',
        style: TextStyle(
            fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
      );
    }
  }

  /// 可預約狀態顯示圖
  String getLevelImg() {
    /// 新手區
    if (GlobalData.userInfo.level == 0) {
      return AppImagePath.level0;
    }
    return format(AppImagePath.levelMission, ({'level': '0${widget.level}'}));
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
    }else if (widget.level == 6) {
      return AppColors.reservationLevel6.withOpacity(0.7);
    }else {
      return AppColors.textBlack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: UIDefine.getWidth() / 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// 新手顯示星星
              Visibility(
                visible: widget.level == 0,
                  child: Image.asset(AppImagePath.beginner)),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: ifIsBeginnerLabel())
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
                    btnText: 'Enter',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TradeDivisionView(
                                    level: widget.level,
                                  )));
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
