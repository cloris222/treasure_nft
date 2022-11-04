import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../constant/theme/app_colors.dart';

/// MARK: 滿版動畫
class FullAnimationPage extends StatefulWidget {
  const FullAnimationPage(
      {Key? key,
      required this.animationPath,
      this.runFunction,
      this.limitTimer = 5,
      this.nextPage,
      this.isGIF = false,
      this.isPushNextPage = false,
      this.nextOpacityPage = false})
      : super(key: key);

  ///MARK: 判斷是否為GIF
  final bool isGIF;

  ///MARK: 動畫路徑
  final String animationPath;

  ///MARK: 背景讀取 未設置就不作用
  final BackgroundFunction? runFunction;

  ///MARK: 動作關閉時間 0為不處理
  final int limitTimer;

  ///MARK: 如果有就推到下一頁，沒有就直接清掉此頁面
  final Widget? nextPage;

  ///MARK: 判斷下一頁是不是透明的
  ///true:用透明的方式推下一頁 false 一般方式推下一頁
  final bool nextOpacityPage;

  ///MARK: 判斷是要推下一頁還是清除全部
  ///true:僅推一頁 false:直接清除其他頁面，推下一頁
  final bool isPushNextPage;

  @override
  State<FullAnimationPage> createState() => _FullAnimationPageState();
}

class _FullAnimationPageState extends State<FullAnimationPage>
    with TickerProviderStateMixin {
  late Timer _countdownTimer;
  int _currentSecond = 0;

  /// 判斷背景程式是否執行完成
  bool runEnd = true;

  late GifController gifController;

  @override
  void initState() {
    super.initState();
    gifController = GifController(vsync: this);
    gifController.value = 0;
    if (widget.limitTimer != 0 || widget.runFunction != null) {
      ///倒數判斷
      _currentSecond = widget.limitTimer;

      ///如果沒有背景程式就不進行
      runEnd = (widget.runFunction == null);
      if (widget.runFunction != null) {
        widget.runFunction!().then((value) => runEnd = true);
      }
      countdownFunction();
    }
  }

  @override
  void dispose() {
    try {
      _countdownTimer.cancel();
    } catch (error) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,

        ///MARK: 禁止返回前頁
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(padding),
            child: Stack(
              children: [
                widget.isGIF
                    ? Gif(
                        autostart: Autostart.loop,
                        controller: gifController,
                        image: AssetImage(widget.animationPath),
                      )
                    : Lottie.asset(widget.animationPath, fit: BoxFit.contain),
                Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                        onTap: () => _countdownFinish(),
                        child: Image.asset(AppImagePath.closeDialogBtn)))
              ],
            ),
          ),
        ));
  }

  void countdownFunction() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSecond > 0 || !runEnd) {
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
    if (runEnd) {
      if (_countdownTimer.isActive) {
        _countdownTimer.cancel();
      }
      if (widget.nextPage != null) {
        widget.isPushNextPage
            ? widget.nextOpacityPage
                ? BaseViewModel().pushOpacityPage(context, widget.nextPage!)
                : BaseViewModel().pushPage(context, widget.nextPage!)
            : BaseViewModel().pushAndRemoveUntil(context, widget.nextPage!);
      } else {
        BaseViewModel().popPage(context);
      }
    }
  }
}
