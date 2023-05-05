import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_theme.dart';
import '../../utils/num_length_formatter.dart';

class LoginTextWidget extends StatefulWidget {
  const LoginTextWidget(
      {Key? key,
      required this.hintText,
      this.fontSize,
      this.hintColor = AppColors.textHintGrey,
      this.isSecure = false,
      this.prefixIconAsset = '',
      this.onChanged,
      this.onTap,
      this.enabledColor = AppColors.bolderGrey,
      this.focusedColor = AppColors.bolderGrey,
      this.initColor = AppColors.bolderGrey,
      this.keyboardType,
      required this.controller,
      this.contentPaddingRight,
      this.contentPaddingLeft,
      this.contentPaddingTop,
      this.contentPaddingBottom,
      this.bLimitDecimalLength = false,
      this.bPasswordFormatter = false,
      this.inputFormatters = const [],
      this.bFocusedGradientBolder = false,
      })
      : super(key: key);
  final String hintText;
  final double? fontSize;
  final Color hintColor;
  final bool isSecure;
  final String prefixIconAsset;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final double? contentPaddingRight;
  final double? contentPaddingLeft;
  final double? contentPaddingTop;
  final double? contentPaddingBottom;

  ///MARK: 小數點限制兩位
  final bool bLimitDecimalLength;

  ///MARK: 密碼輸入資訊限制
  final bool bPasswordFormatter;

  ///MARK: 自定義 在前兩者限制為false啟用
  final List<TextInputFormatter> inputFormatters;

  ///控制不同狀態下的框限顏色
  final Color enabledColor; //可用狀態
  final Color focusedColor; //點選中
  final Color initColor; //初始化

  /// 是否開啟漸層框(for 點選中)
  final bool bFocusedGradientBolder;

  @override
  State<LoginTextWidget> createState() => _LoginTextWidgetState();
}

class _LoginTextWidgetState extends State<LoginTextWidget> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: UIDefine.getPixelWidth(60),
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
        child: _buildEdit());
  }

  Widget _buildEdit() {
    return TextField(
        controller: widget.controller,
        inputFormatters: widget.bLimitDecimalLength
            ? [
                NumLengthInputFormatter(decimalLength: 2),
                FilteringTextInputFormatter.allow(RegExp(r"[\d.]")),
              ] // 小數點限制兩位 整數預設99位
            : widget.bPasswordFormatter //英文+數字，且不能超過30個字元
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\d]")),
                    LengthLimitingTextInputFormatter(30),
                  ]
                : widget.inputFormatters,
        obscureText: widget.isSecure && isPasswordVisible,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textInputAction: TextInputAction.next,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        style: AppTextStyle.getBaseStyle(
            color: Colors.black,
            fontSize: widget.fontSize ?? UIDefine.fontSize12),
        decoration: InputDecoration(
            isCollapsed: true,
            hintText: widget.hintText,
            hintStyle: AppTextStyle.getBaseStyle(
                height: 1.1,
                color: widget.hintColor,
                fontSize: widget.fontSize ?? UIDefine.fontSize12),
            labelStyle: AppTextStyle.getBaseStyle(
                color: Colors.black,
                fontSize: widget.fontSize ?? UIDefine.fontSize12),
            alignLabelWithHint: true,
            counterStyle: AppTextStyle.getBaseStyle(
                color: Colors.black,
                fontSize: widget.fontSize ?? UIDefine.fontSize12),
            contentPadding: EdgeInsets.only(
                top: widget.contentPaddingTop ?? UIDefine.getPixelWidth(15),
                bottom:
                    widget.contentPaddingBottom ?? UIDefine.getPixelWidth(15),
                left: widget.contentPaddingLeft ?? UIDefine.getPixelWidth(20),
                right: widget.contentPaddingRight ?? UIDefine.getPixelWidth(0)),
            disabledBorder: AppTheme.style.styleTextEditBorderBackground(
                color: widget.enabledColor, radius: 10),
            enabledBorder: AppTheme.style.styleTextEditBorderBackground(
                color: widget.enabledColor, radius: 10),
            focusedBorder: widget.bFocusedGradientBolder
                ? const GradientOutlineInputBorder(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppColors.gradientBaseColorBg),
                    width: 1.5,
                    borderRadius: BorderRadius.all(Radius.circular(10)))
                : AppTheme.style.styleTextEditBorderBackground(
                    color: widget.focusedColor, radius: 10),
            border: AppTheme.style.styleTextEditBorderBackground(
                color: widget.initColor, radius: 10),
            suffixIcon: widget.isSecure ? _buildSecureView() : null,
            prefixIcon: widget.prefixIconAsset.isNotEmpty
                ? Image.asset(widget.prefixIconAsset)
                : null));
  }

  Widget _buildSecureView() {
    return IconButton(
        icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey),
        onPressed: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        });
  }
}
