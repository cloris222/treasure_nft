import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';

class GradientButtonWidget extends StatefulWidget {
  const GradientButtonWidget({
    Key? key,
    required this.btnText,
    required this.onPressed,
    this.width,
    this.height,
    this.needTimes = 1,
    this.radius = 15,
    this.fontSize,
    this.fontWeight,
    this.isFillWidth = true,
    this.margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    this.padding,
    this.alignment = Alignment.center,
  }) : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final int needTimes;
  final double radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final bool isFillWidth;
  final AlignmentGeometry alignment;

  @override
  State<GradientButtonWidget> createState() => _GradientButtonWidgetState();
}

class _GradientButtonWidgetState extends State<GradientButtonWidget> {
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
    return GestureDetector(
        onTap: () => intervalClick(widget.needTimes),
        child: Container(
            alignment: widget.alignment,
            decoration: AppStyle().baseBolderGradient(
                backgroundColor: Colors.white,
                borderWidth: 2,
                radius: widget.radius),
            width: widget.width ??
                (widget.isFillWidth ? UIDefine.getWidth() : null),
            height: widget.height ?? UIDefine.getPixelWidth(50),
            margin: widget.margin,
            padding: widget.padding ??
                EdgeInsets.symmetric(
                    horizontal: UIDefine.getPixelWidth(10),
                    vertical: UIDefine.getPixelWidth(5)),
            child: Text(widget.btnText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textNineBlack,
                    fontSize: widget.fontSize ?? UIDefine.fontSize16,
                    fontWeight: widget.fontWeight))));
  }
}
