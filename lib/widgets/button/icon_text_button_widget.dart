import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:flutter/rendering.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';

class IconTextButtonWidget extends StatefulWidget {
  const IconTextButtonWidget(
      {super.key,
      required this.btnText,
      required this.iconPath,
      required this.onPressed,
      this.width,
      this.enable = true,
      this.height,
      this.fontSize,
      this.fontWeight,
        this.marginHorizon,
      this.needTimes = 1});

  final String btnText;
  final String iconPath;
  final VoidCallback onPressed;
  final bool enable;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int needTimes;
  final double? marginHorizon;

  @override
  State<IconTextButtonWidget> createState() => _IconTextButtonWidgetState();
}

class _IconTextButtonWidgetState extends State<IconTextButtonWidget> {
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
          margin: EdgeInsets.symmetric(
              vertical: UIDefine.getScreenWidth(2),
              horizontal:UIDefine.getScreenWidth( widget.marginHorizon ?? 5)),
          decoration: widget.enable
              ? AppStyle().baseGradient(radius: 10)
              : AppStyle()
                  .styleColorsRadiusBackground(color: AppColors.buttonGrey),
          width: widget.width ?? UIDefine.getWidth(),
          height: widget.height ?? UIDefine.getPixelWidth(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.iconPath.isNotEmpty?BaseIconWidget(
                imageAssetPath: widget.iconPath,
                size: (widget.height ?? UIDefine.getPixelWidth(50)) * 0.78,
              ):Container(),
              const SizedBox(width: 4),
              Text(widget.btnText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.fontSize ?? UIDefine.fontSize16,
                      fontWeight: widget.fontWeight))
            ],
          )),
    );
  }
}
