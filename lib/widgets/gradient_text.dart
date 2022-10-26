import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    this.size,
    this.weight,
    this.starColor = AppColors.mainThemeButton,
    this.endColor = AppColors.deepBlue,
    this.begin = Alignment.bottomLeft,
    this.end = Alignment.topRight,
    this.maxLines,
    this.overflow,
  });

  final String text;
  double? size = UIDefine.fontSize20;
  FontWeight? weight = FontWeight.w400;
  final Color starColor;
  final Color endColor;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          LinearGradient(begin: begin, end: end, colors: [
        starColor,
        endColor,
      ]).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text,
          maxLines: maxLines,
          overflow: overflow,
          style: TextStyle(fontSize: size, fontWeight: weight)),
    );
  }
}
