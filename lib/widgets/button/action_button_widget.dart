import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import '../../constant/theme/app_colors.dart';

class ActionButtonWidget extends StatefulWidget {
  const ActionButtonWidget(
      {Key? key,
      required this.btnText,
      required this.onPressed,
      this.setMainColor = AppColors.mainThemeButton,
      this.setSubColor = AppColors.textWhite,
      this.setTransColor = Colors.transparent,
      this.setHeight,
      this.fontSize,
      this.fontWeight,
      this.margin,
      this.padding,
      this.isBorderStyle = false,
      this.isFillWidth = true,
      this.radius = 10,
      this.needTimes = 1})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final Color setMainColor; //主色
  final Color setSubColor; //子色
  final Color setTransColor; //取代透明色,用於倒數框
  final double? setHeight;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isBorderStyle; //false 時 為填滿顏色 true 為 只有框線色
  final bool isFillWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final int needTimes;

  @override
  State<ActionButtonWidget> createState() => _ActionButtonWidgetState();
}

class _ActionButtonWidgetState extends State<ActionButtonWidget> {
  DateTime? _delay;

  /// 防止重複點擊button
  void intervalClick(int needTime) {
    if (_delay == null ||
        DateTime.now().difference(_delay!) > Duration(seconds: needTime)) {
      GlobalData.printLog("允許點擊");
      _delay = DateTime.now();
      widget.onPressed();
    } else {
      ///强制用户一定要间隔3s后才能成功点击. 而不是以上一次点击成功的时间开始计算.
      GlobalData.printLog("重複點擊");
    }
  }

  @override
  Widget build(BuildContext context) {
    return createButton(context);
  }

  Widget createButton(BuildContext context) {
    Color primaryColor, borderColor, textColor;
    if (widget.isBorderStyle) {
      primaryColor = widget.setSubColor;
      borderColor = widget.setMainColor;
      textColor = widget.setMainColor;
    } else {
      primaryColor = widget.setMainColor;
      borderColor = widget.setTransColor;
      textColor = widget.setSubColor;
    }
    var actionButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                side: BorderSide(color: borderColor))),
        onPressed: () => intervalClick(widget.needTimes),
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: textColor,
              fontSize: widget.fontSize ?? UIDefine.fontSize16,
              fontWeight: widget.fontWeight),
        ));

    return widget.isFillWidth
        ? Container(
            height: widget.setHeight,
            width: MediaQuery.of(context).size.width,
            margin: widget.margin,
            padding: widget.padding,
            child: actionButton)
        : Container(
            height: widget.setHeight,
            margin: widget.margin,
            padding: widget.padding,
            child: actionButton);
  }
}
