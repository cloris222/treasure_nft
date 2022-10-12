import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

class GradientText extends StatelessWidget {
  GradientText(this.text,
      {this.size,
      this.weight,
      this.starColor = AppColors.mainThemeButton,
      this.endColor = AppColors.deepBlue});

  final String text;
  double? size = UIDefine.fontSize20;
  FontWeight? weight = FontWeight.w400;
  final Color starColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            starColor,
            endColor,
          ]).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: TextStyle(fontSize: size, fontWeight: weight)),
    );
  }
}
