import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../constant/theme/app_colors.dart';
import 'flex_two_text_widget.dart';

class PersonalParamItem extends StatelessWidget {
  const PersonalParamItem(
      {Key? key,
      required this.title,
      this.value,
      this.assetImagePath,
      this.onPress,
      this.fillWidth = true})
      : super(key: key);
  final String title;
  final String? value;
  final String? assetImagePath;
  final GestureTapCallback? onPress;
  final bool fillWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
            width: fillWidth ? UIDefine.getWidth() : null,
            height: UIDefine.fontSize18 * 3.5,
            alignment: Alignment.center,
            child: Column(children: [
              _buildTop(),
              const SizedBox(height: 5),
              Flexible(child: _buildTitle())
            ])));
  }

  Widget _buildTop() {
    TextStyle style = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize16,
        color: AppColors.textBlack,
        fontWeight: FontWeight.w600);
    return value != null
        ? Text(value!, style: style)
        : assetImagePath != null
            ? Image.asset(
                assetImagePath!,
                height: UIDefine.getPixelWidth(30),
                fit: BoxFit.fitHeight,
              )
            : Text('', style: style);
  }

  Widget _buildTitle() {
    return FlexTwoTextWidget(
      text: title,
      fontSize: 12,
      textAlign: TextAlign.center,
      color: AppColors.textSixBlack,
    );
  }
}
