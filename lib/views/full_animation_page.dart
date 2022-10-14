import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

/// MARK: 滿版動畫
class FullAnimationPage extends StatefulWidget {
  const FullAnimationPage(
      {Key? key,
      required this.animationPath,
      this.runFunction,
      this.limitTimer = 5,
      this.nextPage})
      : super(key: key);

  ///MARK: 動畫路徑
  final String animationPath;

  ///MARK: 背景讀取 未設置就不作用
  final BackgroundFunction? runFunction;

  ///MARK: 動作關閉時間 0為不處理
  final int limitTimer;

  ///MARK: 如果有就推到下一頁，沒有就直接清掉此頁面
  final Widget? nextPage;

  @override
  State<FullAnimationPage> createState() => _FullAnimationPageState();
}

class _FullAnimationPageState extends State<FullAnimationPage> {
  late Timer _countdownTimer;
  int _currentSecond = 0;

  /// 判斷背景程式是否執行完成
  bool runEnd = true;

  @override
  void initState() {
    super.initState();
    if (widget.limitTimer != 0 || widget.runFunction != null) {
      ///倒數判斷
      _currentSecond = widget.limitTimer;

      ///如果沒有背景程式就不關閉
      runEnd = (widget.runFunction == null);
      if (widget.runFunction != null) {
        widget.runFunction!().then((value) => runEnd = true);
      }
      countdownFunction();
    }
  }

  @override
  void dispose() {
    super.dispose();
    try {
      _countdownTimer.cancel();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Lottie.asset(widget.animationPath,
            width: UIDefine.getWidth(), height: UIDefine.getHeight()),
        Positioned(
            top: 0, right: 0, child: Image.asset(AppImagePath.closeDialogBtn))
      ],
    ));
  }

  void countdownFunction() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSecond > 0 || runEnd) {
        if (_currentSecond != 0) {
          _currentSecond -= 1;
        }
      } else {
        _countdownTimer.cancel();
        _countdownFinish();
      }
    });
  }

  ///MARK: 倒數完成
  void _countdownFinish() {
    if (_currentSecond == 0 && runEnd) {
      if (widget.nextPage != null) {
        BaseViewModel().pushAndRemoveUntil(context, widget.nextPage!);
      } else {
        BaseViewModel().popPage(context);
      }
    }
  }
}
