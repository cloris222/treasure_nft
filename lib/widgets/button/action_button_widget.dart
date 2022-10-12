import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import '../../constant/theme/app_colors.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget(
      {Key? key,
      required this.btnText,
      required this.onPressed,
      this.setMainColor = AppColors.mainThemeButton,
      this.setSubColor = AppColors.textWhite,
      this.setTransColor = Colors.transparent,
      this.setHeight,
      this.fontSize,
      this.margin,
      this.padding,
      this.isBorderStyle = false,
      this.isFillWidth = true})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final Color setMainColor; //主色
  final Color setSubColor; //子色
  final Color setTransColor; //取代透明色,用於倒數框
  final double? setHeight;
  final double ?fontSize;
  final bool isBorderStyle; //false 時 為填滿顏色 true 為 只有框線色
  final bool isFillWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return createButton(context);
  }

  Widget createButton(BuildContext context) {
    Color primaryColor, borderColor, textColor;
    if (isBorderStyle) {
      primaryColor = setSubColor;
      borderColor = setMainColor;
      textColor = setMainColor;
    } else {
      primaryColor = setMainColor;
      borderColor = setTransColor;
      textColor = setSubColor;
    }
    var actionButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: borderColor))),
        onPressed: onPressed,
        child: Text(
          btnText,
          style: TextStyle(color: textColor, fontSize: fontSize??UIDefine.fontSize16),
        ));

    return isFillWidth
        ? Container(
            height: setHeight,
            width: MediaQuery.of(context).size.width,
            margin: margin,
            padding: padding,
            child: actionButton)
        : Container(
            height: setHeight,
            margin: margin,
            padding: padding,
            child: actionButton);
  }
}
