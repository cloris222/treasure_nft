import 'package:flutter/material.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_theme.dart';

class LoginTextWidget extends StatefulWidget {
  const LoginTextWidget(
      {Key? key,
      required this.hintText,
      this.isSecure = false,
      this.prefixIconAsset = '',
      this.setNullWidget,
      this.onChanged,
      required this.controller})
      : super(key: key);
  final String hintText;
  final bool isSecure;
  final String prefixIconAsset;
  final Widget? setNullWidget;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  State<LoginTextWidget> createState() => _LoginTextWidgetState();
}

class _LoginTextWidgetState extends State<LoginTextWidget> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _buildEdit());
  }

  Widget _buildEdit() {
    return TextField(
        controller: widget.controller,
        obscureText: widget.isSecure && isPasswordVisible,
//        controller: userPasswordController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(height: 1.1),
            labelStyle: const TextStyle(color: Colors.black),
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.only(top: 0, left: 20),
            enabledBorder: AppTheme.style
                .styleTextEditBorderBackground(color: AppColors.bolderGrey),
            focusedBorder: AppTheme.style
                .styleTextEditBorderBackground(color: AppColors.bolderGrey),
            border: AppTheme.style
                .styleTextEditBorderBackground(color: AppColors.bolderGrey),
            suffixIcon:
                widget.isSecure ? _buildSecureView() : widget.setNullWidget,
            prefixIcon: widget.prefixIconAsset.isNotEmpty
                ? Image.asset(widget.prefixIconAsset)
                : widget.setNullWidget));
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
