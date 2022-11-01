import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
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
    TextStyle style = TextStyle(
        fontSize: UIDefine.fontSize18,
        color: AppColors.dialogBlack,
        fontWeight: FontWeight.bold);
    return value != null
        ? Text(value!, style: style)
        : assetImagePath != null
            ? Image.asset(
                assetImagePath!,
                height: UIDefine.fontSize22,
                fit: BoxFit.fitHeight,
              )
            : Text('', style: style);
  }

  Widget _buildTitle() {
    return FlexTwoTextWidget(
      text: title,
      fontSize: 14,
      textAlign: TextAlign.center,
      color: AppColors.dialogGrey,
      fontWeight: FontWeight.w500,
    );
  }
}
