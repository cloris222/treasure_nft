import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    this.size,
    this.weight = FontWeight.w400,
    this.starColor = AppColors.mainThemeButton,
    this.endColor = AppColors.deepBlue,
    this.begin = Alignment.bottomLeft,
    this.end = Alignment.topRight,
    this.maxLines,
    this.overflow,
    this.strutStyle,
    this.styleHeight,
  });

  final String text;
  final double? size;
  final FontWeight weight;
  final Color starColor;
  final Color endColor;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final int? maxLines;
  final TextOverflow? overflow;
  final StrutStyle? strutStyle;
  final double? styleHeight;

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
          strutStyle: strutStyle,
          maxLines: maxLines,
          overflow: overflow,
          style: TextStyle(
              fontSize: size ?? UIDefine.fontSize20,
              fontWeight: weight,
              height: styleHeight)),
    );
  }
}
