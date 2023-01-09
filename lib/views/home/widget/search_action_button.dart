import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class SearchActionButton extends StatelessWidget {
  const SearchActionButton(
      {Key? key,
        required this.btnText,
        required this.onPressed,
        this.setMainColor = AppColors.mainThemeButton,
        this.setSubColor = AppColors.textWhite,
        this.setTransColor = Colors.transparent,
        this.setHeight,
        this.fontSize,
        this.borderWidth,
        this.margin,
        this.padding,
        this.isSelect = false,
        this.isFillWidth = false})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final Color setMainColor; //主色
  final Color setSubColor; //子色
  final Color setTransColor; //取代透明色,用於倒數框
  final double? setHeight;
  final double ?fontSize;
  final double? borderWidth;
  final bool isSelect;
  final bool isFillWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return createButton(context);
  }

  Widget createButton(BuildContext context) {
    Color primaryColor, borderColor, textColor;
    if (isSelect) {
      primaryColor = setMainColor;
      borderColor = setTransColor;
      textColor = setSubColor;
    } else {
      primaryColor = setSubColor;
      borderColor = AppColors.datePickerBorder;
      textColor = AppColors.textGrey;
    }
    var actionButton = GestureDetector(
        onTap: onPressed,

        child: Container(
          padding: padding?? EdgeInsets.only(
              left:UIDefine.getScreenWidth(3),
              right: UIDefine.getScreenWidth(3),
          ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: borderColor,
                  width: borderWidth??2,
                )),
            child: Center(
            child:Text(
              btnText,
              style: AppTextStyle.getBaseStyle(color: textColor, fontSize: fontSize??UIDefine.fontSize12),
            ))
        ),
       );

    return isFillWidth
        ? Container(
        height: setHeight?? UIDefine.getScreenHeight(6),
        width: UIDefine.getWidth(),
        margin: margin,
        padding: padding,
        child: actionButton)
        : Container(
        height: setHeight?? UIDefine.getScreenHeight(6),
        margin: margin,
        padding: padding,
        child: actionButton);
  }
}
