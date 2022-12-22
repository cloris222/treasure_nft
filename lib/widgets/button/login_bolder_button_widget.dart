import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/theme/app_colors.dart';
import '../gradient_text.dart';
import '../label/gradient_bolder_widget.dart';

class LoginBolderButtonWidget extends StatefulWidget {
  const LoginBolderButtonWidget(
      {Key? key,
      required this.btnText,
      required this.onPressed,
      this.width,
      this.height,
      this.needTimes = 1})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final int needTimes;

  @override
  State<LoginBolderButtonWidget> createState() =>
      _LoginBolderButtonWidgetState();
}

class _LoginBolderButtonWidgetState extends State<LoginBolderButtonWidget> {
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
        child: GradientBolderWidget(
            width: widget.width,
            height: widget.height,
            child: GradientText(widget.btnText,
                size: UIDefine.fontSize16,
                starColor: AppColors.mainThemeButton,
                endColor: AppColors.subThemePurple)));
  }
}
