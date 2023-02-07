import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/views/trade/trade_division_view.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../../constant/enum/trade_enum.dart';
import '../../../constant/global_data.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/ui_define.dart';
import '../../../models/data/trade_model_data.dart';
import '../../button/action_button_widget.dart';

class LevelMainCell extends StatefulWidget {
  const LevelMainCell({
    Key? key,
    required this.level,
    required this.tradeData,
  }) : super(key: key);

  final int level;
  final TradeData tradeData;

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

  Widget showLevelLabel() {
    return Text(
      '${tr("level")} ${widget.level}',
      style:
          AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
    );
  }

  getLevelRange() {
    Image etherImg = Image.asset(
      AppImagePath.tetherImg,
      width: UIDefine.fontSize18,
      height: UIDefine.fontSize18,
    );
    SizedBox freeSpace = const SizedBox(
      width: 5,
    );
    TextStyle style =
        AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500);
    if (widget.level == 0) {
      return Row(
        children: [
          Image.asset(AppImagePath.tetherImg),
          freeSpace,
          Visibility(
              visible: widget.level != 0,
              child: Text(
                '',
                style: style,
              ))
        ],
      );
    } else if (widget.level == 1) {
      return Row(
        children: [
          etherImg,
          freeSpace,
          Text(
            '1 - 300',
            style: style,
          )
        ],
      );
    } else if (widget.level == 2) {
      return Row(
        children: [
          etherImg,
          freeSpace,
          Text(
            '300 - 1k',
            style: style,
          )
        ],
      );
    } else if (widget.level == 3) {
      return Row(
        children: [
          etherImg,
          freeSpace,
          Text(
            '1k - 3k',
            style: style,
          )
        ],
      );
    } else if (widget.level == 4) {
      return Row(
        children: [
          etherImg,
          freeSpace,
          Text(
            '3k - 5k',
            style: style,
          )
        ],
      );
    } else if (widget.level == 5) {
      return Row(
        children: [
          etherImg,
          freeSpace,
          Text(
            '5k - 20k',
            style: style,
          )
        ],
      );
    } else if (widget.level == 6) {
      return Row(
        children: [
          etherImg,
          freeSpace,
          Text(
            '20k - 50k',
            style: style,
          )
        ],
      );
    } else {
      return Row(
        children: [
          etherImg,
          freeSpace,
          Text(
            '',
            style: style,
          )
        ],
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
    } else if (widget.level == 6) {
      return AppColors.reservationLevel6.withOpacity(0.7);
    } else {
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  showLevelLabel()
                ],
              ),
              Flexible(child: Container()),
              getLevelRange()
            ],
          ),
          Stack(
            children: [
              Image.asset(getLevelImg()),
              Positioned(
                right: 0,
                bottom: 0,
                child: Visibility(
                  visible: widget.tradeData.status != SellingState.Selling &&  GlobalData.appTradeEnterButtonStatus,
                  child: ActionButtonWidget(
                      setHeight: 40,
                      isFillWidth: false,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      setMainColor: getReservationBtnColor(),
                      btnText: widget.level == 0 ? tr("match") : tr("enter"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TradeDivisionView(
                                      level: widget.level,
                                    )));
                      }),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
