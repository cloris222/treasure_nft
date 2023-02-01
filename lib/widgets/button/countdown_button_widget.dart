import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import 'action_button_widget.dart';

class CountdownButtonWidget extends StatefulWidget {
  const CountdownButtonWidget(
      {Key? key,
      this.btnText = '',
      required this.onPress,
      this.countdownSecond = 60,
      this.showCountdownText = false,
      this.initEnable = true,
      this.buttonType = 4,
      this.setHeight,
      this.fontSize,
      this.margin = const EdgeInsets.only(left: 5, top: 10),
      this.padding,
      this.isFillWidth = false,
      this.onPressVerification})
      : super(key: key);
  final int countdownSecond; //倒數秒數
  final String btnText; //一開始顯示文字
  final bool initEnable; //一開始是否可按
  final bool showCountdownText; //倒數時是否顯示文字
  final int buttonType; //0: 藍框->灰底白框 ,1: 僅藍框,2:籃框白底->灰底籃框
  final VoidCallback onPress;
  final double? setHeight;
  final double? fontSize;
  final bool isFillWidth;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? padding;

  ///檢查資料是否正確可按
  final PressVerification? onPressVerification;

  @override
  State<CountdownButtonWidget> createState() => _CountdownButtonWidgetState();
}

class _CountdownButtonWidgetState extends State<CountdownButtonWidget> {
  int _currentSecond = 0;
  late String _currentText;
  bool _enableButton = false;
  late Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    if (widget.initEnable) {
      //等待觸發後可按
      updateStatus();
    } else {
      //自動觸發
      _currentSecond = widget.countdownSecond;
      updateStatus();
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
    switch (widget.buttonType) {
      case 0:
        {
          return ActionButtonWidget(
              btnText: _currentText,
              onPressed: () {
                _onPressed();
              },
              setMainColor: _enableButton
                  ? AppColors.mainThemeButton
                  : AppColors.buttonGrey,
              setSubColor:
                  _enableButton ? Colors.transparent : AppColors.textWhite,
              setTransColor:
                  _enableButton ? Colors.transparent : AppColors.textWhite,
              fontSize: widget.fontSize ?? UIDefine.fontSize16,
              margin: widget.margin,
              padding: widget.padding,
              isBorderStyle: _enableButton,
              isFillWidth: widget.isFillWidth);
        }
      case 2:
        {
          return ActionButtonWidget(
              btnText: _currentText,
              onPressed: () {
                _onPressed();
              },
              setMainColor: _enableButton
                  ? AppColors.mainThemeButton
                  : AppColors.buttonGrey,
              setSubColor: AppColors.textWhite,
              setTransColor:
                  _enableButton ? Colors.transparent : AppColors.textWhite,
              setHeight: widget.setHeight,
              fontSize: widget.fontSize,
              margin: widget.margin,
              padding: widget.padding,
              isBorderStyle: _enableButton,
              isFillWidth: widget.isFillWidth);
        }
      case 3:
        {
          return ActionButtonWidget(
              btnText: _currentText,
              onPressed: () {
                _onPressed();
              },
              setMainColor: _enableButton
                  ? AppColors.mainThemeButton
                  : AppColors.textGrey,
              setSubColor: AppColors.textWhite,
              setTransColor:
                  _enableButton ? Colors.transparent : AppColors.textWhite,
              fontSize: widget.fontSize,
              margin: widget.margin,
              padding: widget.padding,
              isFillWidth: widget.isFillWidth);
        }
      case 4:
        {
          return _enableButton
              ? LoginBolderButtonWidget(
                  btnText: _currentText,
                  onPressed: () {
                    _onPressed();
                  },
                  height: widget.setHeight,
                  fontSize: widget.fontSize,
                  margin: widget.margin,
                  padding: widget.padding,
                  isFillWidth: widget.isFillWidth)
              : LoginButtonWidget(
                  enable: false,
                  isGradient: false,
                  btnText: _currentText,
                  onPressed: () {
                    _onPressed();
                  },
                  height: widget.setHeight,
                  fontSize: widget.fontSize,
                  margin: widget.margin,
                  padding: widget.padding,
                  isFillWidth: widget.isFillWidth);
        }
      case 1:
      default:
        {
          return ActionButtonWidget(
              btnText: _currentText,
              onPressed: () {
                _onPressed();
              },
              setHeight: widget.setHeight,
              fontSize: widget.fontSize,
              margin: widget.margin,
              padding: widget.padding,
              isFillWidth: widget.isFillWidth);
        }
    }
  }

  Future<void> _onPressed() async {
    bool press = true;
    if (widget.onPressVerification != null) {
      press = await widget.onPressVerification!();
    }
    if (press) {
      if (widget.initEnable && _enableButton) {
        _enableButton = false;
        setState(() {
          _currentSecond = widget.countdownSecond;
          updateStatus();
        });
        countdownFunction();
        widget.onPress();
      } else if (!widget.initEnable && _enableButton) {
        widget.onPress();
      }
    }
  }

  void countdownFunction() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSecond > 0) {
        //顯示倒數
        setState(() {
          _currentSecond -= 1;
          updateStatus();
        });
      } else {
        _countdownTimer.cancel();
      }
    });
  }

  void updateStatus() {
    if (_currentSecond != 0) {
      _enableButton = false;
      _currentText = widget.showCountdownText
          ? '${getBtnText()}($_currentSecond)'
          : '$_currentSecond';
    } else {
      _enableButton = true;
      _currentText = getBtnText();
    }
  }

  String getBtnText() {
    if (widget.btnText.isEmpty) {
      return tr('send');
    }
    return widget.btnText;
  }
}
