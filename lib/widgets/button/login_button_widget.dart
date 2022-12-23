import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

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
      this.isFlip = false,
      this.radius = 10,
      this.showIcon = false,
      this.needTimes = 1})
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

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
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
    return InkWell(
      onTap: () => intervalClick(widget.needTimes),
      child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: widget.enable
              ? widget.isGradient
                  ? widget.isFlip
                      ? AppStyle().baseFlipGradient(radius: widget.radius)
                      : AppStyle().baseGradient(radius: widget.radius)
                  : AppStyle().styleColorsRadiusBackground(
                      color: AppColors.mainThemeButton)
              : AppStyle()
                  .styleColorsRadiusBackground(color: AppColors.buttonGrey),
          width: widget.width ?? UIDefine.getWidth(),
          height: widget.height ?? 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(widget.btnText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.fontSize ?? UIDefine.fontSize16,
                      fontWeight: widget.fontWeight)),
            ],
          )),
    );
  }
}
