import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_theme.dart';
import '../../utils/num_length_formatter.dart';

class LoginTextWidget extends StatefulWidget {
  const LoginTextWidget(
      {Key? key,
      required this.hintText,
      this.hintColor = AppColors.textGrey,
      this.isSecure = false,
      this.prefixIconAsset = '',
      this.onChanged,
      this.onTap,
      this.enabledColor = AppColors.bolderGrey,
      this.focusedColor = AppColors.bolderGrey,
      this.initColor = AppColors.bolderGrey,
      this.keyboardType,
      required this.controller,
      this.contentPaddingRight = 0,
      this.bLimitDecimalLength = false,
      this.bPasswordFormatter = false,
      this.inputFormatters = const [],
      this.bFocusedGradientBolder = false})
      : super(key: key);
  final String hintText;
  final Color hintColor;
  final bool isSecure;
  final String prefixIconAsset;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final double contentPaddingRight;

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
        height: UIDefine.getPixelHeight(60),
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(5)),
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
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: CustomTextStyle.getBaseStyle(height: 1.1, color: widget.hintColor),
            labelStyle:  CustomTextStyle.getBaseStyle(color: Colors.black),
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.only(
                top: 0, left: 20, right: widget.contentPaddingRight),
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
