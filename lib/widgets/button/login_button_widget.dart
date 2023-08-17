import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';

class LoginButtonWidget extends StatefulWidget {
  const LoginButtonWidget(
      {Key? key,
      required this.btnText,
      required this.onPressed,
      this.width,
      this.enable = true,
      this.height,
      this.fontSize,
      this.fontWeight,
      this.isGradient = true,
      this.isUnEnableGradient = true,
      this.isFlip = false,
      this.radius = 10,
      this.showIcon = false,
      this.needTimes = 1,
      this.isFillWidth = true,
      this.isAutoHeight = false,
      this.margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      this.padding,
      this.fontFamily = AppTextFamily.PosteramaText,
        this.isShowProgress = false,
        this.textColor = Colors.white,
        this.customGradientColor})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final bool enable;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isGradient;
  final bool isFlip;
  final double radius;
  final bool showIcon;
  final int needTimes;
  final bool isFillWidth;
  final bool isAutoHeight;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? padding;
  final AppTextFamily fontFamily;
  final List<Color>? customGradientColor;
  final bool isUnEnableGradient;
  final bool isShowProgress;
  final Color textColor;


  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  DateTime? _delay;

  /// 防止重複點擊button
  void intervalClick(int needTime) {
    /// 讀取中禁止點擊
    if (widget.isShowProgress) {
      return;
    }
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
          alignment: Alignment.center,
          margin: widget.margin,
          padding: widget.padding ??
              EdgeInsets.symmetric(
                  horizontal: UIDefine.getPixelWidth(10),
                  vertical: UIDefine.getPixelWidth(5)),
          decoration: widget.enable
              ? widget.isGradient
                  ? widget.customGradientColor != null
                      ? AppStyle().buildGradient(
                          colors: widget.customGradientColor!,
                          radius: widget.radius)
                      : widget.isFlip
                          ? AppStyle().baseFlipGradient(radius: widget.radius)
                          : AppStyle().baseGradient(radius: widget.radius)
                  : AppStyle().styleColorsRadiusBackground(
                      color: AppColors.mainThemeButton)
              : widget.isGradient && widget.isUnEnableGradient
                  ? AppStyle().buildGradient(
                      radius: widget.radius,
                      colors: AppColors.gradientBackgroundColorBg)
                  : AppStyle().styleColorsRadiusBackground(
                      color: AppColors.buttonGrey,
                      radius: widget.radius,
                    ),
          width:
              widget.width ?? (widget.isFillWidth ? UIDefine.getWidth() : null),
          height: widget.height ??
              (widget.isAutoHeight ? null : UIDefine.getPixelWidth(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize:
                widget.isFillWidth ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Visibility(
                  visible: widget.showIcon,
                  child: Icon(
                    Icons.storefront,
                    color: Colors.white,
                    size: UIDefine.fontSize18,
                  )),
              Visibility(
                  visible: widget.showIcon,
                  child: SizedBox(
                    width: UIDefine.getPixelWidth(5),
                  )),

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(visible: widget.isShowProgress,
                    child: Container(
                        margin: EdgeInsets.only(right: UIDefine.getPixelHeight(10)),
                        height: UIDefine.getPixelWidth(15),
                        width: UIDefine.getPixelWidth(15),
                        child:const CircularProgressIndicator(strokeWidth: 2,color: AppColors.textWhite,))),
                Text(widget.btnText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.getBaseStyle(
                        color: widget.textColor,
                        fontSize: widget.fontSize ?? UIDefine.fontSize16,
                        fontWeight: widget.fontWeight ?? FontWeight.w600,
                        fontFamily: widget.fontFamily)),
              ])

            ],
          )),
    );
  }
}
