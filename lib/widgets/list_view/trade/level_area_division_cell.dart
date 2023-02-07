import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:format/format.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/animation_download_util.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../../constant/enum/trade_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/data/trade_model_data.dart';
import '../../../models/http/parameter/check_reservation_info.dart';
import '../../gradient_text.dart';

class DivisionCell extends StatefulWidget {
  const DivisionCell(
      {Key? key,
      required this.reservationAction,
      required this.range,
      required this.level,
      required this.tradeData,
      required this.imageIndex})
      : super(key: key);

  final int level;
  final ReserveRange range;
  final VoidCallback reservationAction;
  final TradeData tradeData;
  final int imageIndex;

  @override
  State<DivisionCell> createState() => _DivisionCellState();
}

class _DivisionCellState extends State<DivisionCell> {
  String getRange() {
    if (GlobalData.userInfo.level == 0) {
      return '${tr("level")} 0';
    }

    dynamic min;
    dynamic max;

    min = widget.range.startPrice;
    max = widget.range.endPrice;

    return '${BaseViewModel().numberCompatFormat(NumberFormatUtil().integerFormat(min, hasSeparator: false), decimalDigits: 0)} - ${BaseViewModel().numberCompatFormat(max.toString(), decimalDigits: 0)}';
  }

  String ifIsBeginnerImg() {
    if (GlobalData.userInfo.level == 0) {
      return AppImagePath.beginner;
    } else {
      return AppImagePath.tetherImg;
    }
  }

  /// 是否解鎖副本 && 開賣狀態動畫顯示
  Widget showImg() {
    if (widget.range.lock == true) {
      return Image.asset(getLockImg());
    } else if (widget.range.used == true) {
      String? path = AnimationDownloadUtil().getAnimationFilePath(showGif());
      return path != null ? Image.file(File(path)) : Image.asset(getLevelImg());
    } else {
      return Image.asset(getLevelImg());
    }
  }

  /// 開賣狀態動畫顯示
  String showGif() {
    if (GlobalData.userInfo.level == 0) {
      return format(AppAnimationPath.reservationAnimation, ({'index': '00'}));
    }
    return format(
        AppAnimationPath.reservationAnimation,
        ({
          'index': NumberFormatUtil().integerTwoFormat(widget.range.index + 1)
        }));
  }

  /// 尚未開賣顯示圖
  String getLockImg() {
    if (GlobalData.userInfo.level == 0) {
      return AppImagePath.level0Locked;
    }
    return format(
        AppImagePath.levelMissionLocked, ({'level': '0${widget.level}'}));
  }

  /// 可預約狀態顯示圖
  String getLevelImg() {
    /// 新手區
    if (GlobalData.userInfo.level == 0) {
      return AppImagePath.level0;
    }
    // int index = widget.range.index ?? 0;
    return format(AppImagePath.divisionLevel,
        ({'level': '0${widget.level}', 'index': '${widget.imageIndex + 1}'}));
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
    }
    return AppColors.textBlack;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500);
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
                    /// if is level hide image
                    Visibility(
                      visible: GlobalData.userInfo.level != 0,
                      child: Image.asset(
                        ifIsBeginnerImg(),
                        width: 25,
                        height: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text(
                      getRange(),
                      style: style,
                    ))
                  ],
                ),
              ),
              Row(
                children: [
                  /// 如果是預約狀態（顯示轉圈動畫）
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: Visibility(
                      visible: widget.range.used,
                      child: _buildReserving(),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                      visible: widget.range.used,
                      child: !widget.range.used
                          ? Container()
                          : GradientText(
                              tr('matching'),
                              size: UIDefine.fontSize14,
                              weight: FontWeight.w500,
                              starColor: AppColors.mainThemeButton,
                              endColor: AppColors.subThemePurple,
                            ))
                ],
              )
            ],
          ),
          Stack(
            children: [
              showImg(),
              Positioned(
                right: 0,
                bottom: 0,
                child: Visibility(
                  /// 未鎖定 且 未預約 且 不是開賣中
                  visible: !widget.range.lock &&
                      !widget.range.used &&
                      widget.tradeData.status != SellingState.Selling,
                  child: ActionButtonWidget(
                      setHeight: 40,
                      isFillWidth: false,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
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

  /// 如果是預約狀態（顯示轉圈動畫）
  Widget _buildReserving() {
    String? path = AnimationDownloadUtil().getAnimationFilePath(
        widget.level == 0
            ? AppAnimationPath.beginnerReserving
            : AppAnimationPath.rotating);

    return path != null ? Lottie.file(File(path)) : const SizedBox();
  }
}
