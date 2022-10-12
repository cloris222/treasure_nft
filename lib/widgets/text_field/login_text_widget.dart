import 'package:flutter/material.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_theme.dart';

class LoginTextWidget extends StatefulWidget {
  const LoginTextWidget(
      {Key? key,
      required this.hintText,
      this.isSecure = false,
      this.prefixIconAsset = '',
      this.onChanged,
      this.enabledColor = AppColors.bolderGrey,
      this.focusedColor = AppColors.bolderGrey,
      this.initColor = AppColors.bolderGrey,
      required this.controller})
      : super(key: key);
  final String hintText;
  final bool isSecure;
  final String prefixIconAsset;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  ///控制不同狀態下的框限顏色
  final Color enabledColor; //可用狀態
  final Color focusedColor; //點選中
  final Color initColor; //初始化

  @override
  State<LoginTextWidget> createState() => _LoginTextWidgetState();
}

class _LoginTextWidgetState extends State<LoginTextWidget> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: _buildEdit());
  }

  Widget _buildEdit() {
    return TextField(
        controller: widget.controller,
        obscureText: widget.isSecure && isPasswordVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(height: 1.1),
            labelStyle: const TextStyle(color: Colors.black),
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.only(top: 0, left: 20),
            enabledBorder: AppTheme.style.styleTextEditBorderBackground(
                color: widget.enabledColor, radius: 10),
            focusedBorder: AppTheme.style.styleTextEditBorderBackground(
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
