import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../models/http/api/trade_api.dart';
import '../models/http/parameter/check_reservation_info.dart';
import 'gradient_text.dart';

class CountDownTimer extends StatefulWidget {
  CountDownTimer({Key? key, this.reservationInfo, this.duration})
      : super(key: key);

  late CheckReservationInfo? reservationInfo;
  late Duration? duration;

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits((widget.duration!.inDays));
    final hours = strDigits((widget.duration!.inHours.remainder(24)));
    final minutes = strDigits((widget.duration!.inMinutes.remainder(60)));
    final seconds = strDigits((widget.duration!.inSeconds.remainder(60)));
    return GradientText(
      '$days : $hours : $minutes : $seconds',
      size: UIDefine.fontSize24,
      weight: FontWeight.bold,
      starColor: AppColors.mainThemeButton,
      endColor: AppColors.subThemePurple,
    );
  }
}
