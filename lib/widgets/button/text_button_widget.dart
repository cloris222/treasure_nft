import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/ui_define.dart';
import 'action_button_widget.dart';

class TextButtonWidget extends ActionButtonWidget {
  const TextButtonWidget(
      {super.key,
      required super.btnText,
      required super.onPressed,
      super.setMainColor,
      super.setSubColor,
      super.setTransColor,
      super.fontSize,
      super.margin,
      super.padding,
      super.isBorderStyle,
      super.isFillWidth = false,
      super.radius = 5,
      super.fontWeight,
      super.setHeight,
      this.backgroundHorizontal,
      this.backgroundVertical,
      this.borderSize = 2,
      this.textAlign,
      super.needTimes});

  final double? backgroundVertical;
  final double? backgroundHorizontal;
  final double borderSize;
  final TextAlign? textAlign;

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
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
    var actionButton = InkWell(
        onTap: () => intervalClick(widget.needTimes),
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical:
                    widget.backgroundVertical ?? UIDefine.getPixelHeight(5),
                horizontal:
                    widget.backgroundHorizontal ?? UIDefine.getPixelWidth(10)),
            decoration: AppStyle().styleColorBorderBackground(
                borderLine: widget.borderSize,
                radius: widget.radius,
                color: borderColor,
                backgroundColor: primaryColor),
            child: Text(
              widget.btnText,
              textAlign: widget.textAlign,
              style: AppTextStyle.getBaseStyle(
                  fontWeight: widget.fontWeight,
                  color: textColor,
                  fontSize: widget.fontSize ?? UIDefine.fontSize16),
            )));

    return widget.isFillWidth
        ? Container(
            width: MediaQuery.of(context).size.width,
            margin: widget.margin,
            padding: widget.padding,
            child: actionButton)
        : Container(
            margin: widget.margin,
            padding: widget.padding,
            child: actionButton);
  }
}
