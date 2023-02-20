import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../models/http/parameter/check_reservation_info.dart';
import 'gradient_text.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer(
      {Key? key, this.reservationInfo, this.duration, this.isNewType = false})
      : super(key: key);

  final CheckReservationInfo? reservationInfo;
  final Duration? duration;
  final bool isNewType;

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits((widget.duration?.inDays ?? 0));
    final hours = strDigits((widget.duration?.inHours.remainder(24) ?? 0));
    final minutes = strDigits((widget.duration?.inMinutes.remainder(60) ?? 0));
    final seconds = strDigits((widget.duration?.inSeconds.remainder(60) ?? 0));
    return widget.isNewType
        ? _buildNewType(days, hours, minutes, seconds)
        : GradientText(
            '$days : $hours : $minutes : $seconds',
            size: UIDefine.fontSize24,
            weight: FontWeight.w500,
            starColor: AppColors.mainThemeButton,
            endColor: AppColors.subThemePurple,
          );
  }

  Widget _buildNewType(
      String days, String hours, String minutes, String seconds) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildNewTypeItem(days),
        _buildNewTypeSpace(),
        _buildNewTypeItem(hours),
        _buildNewTypeSpace(),
        _buildNewTypeItem(minutes),
        _buildNewTypeSpace(),
        _buildNewTypeItem(seconds),
      ],
    );
  }

  Widget _buildNewTypeItem(String context) {
    return Container(
      width: UIDefine.getPixelWidth(40),
      height: UIDefine.getPixelWidth(40),
      alignment: Alignment.center,
      decoration: AppStyle().styleColorsRadiusBackground(
          color: const Color(0xFFF5F8FB), radius: 8),
      child: Text(context,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildNewTypeSpace() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
      child: Text(':',
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize20,
              fontWeight: FontWeight.w600,
              color: AppColors.textThreeBlack)),
    );
  }
}
