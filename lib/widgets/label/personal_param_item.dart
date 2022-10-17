import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import '../../constant/theme/app_colors.dart';

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
    return GestureDetector(
        onTap: onPress,
        child: Container(
            width: fillWidth ? UIDefine.getWidth() : null,
            alignment: Alignment.center,
            child: Column(children: [
              _buildTop(),
              const SizedBox(height: 5),
              _buildTitle()
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
            ? Image.asset(assetImagePath!,
                width: UIDefine.fontSize22, height: UIDefine.fontSize22)
            : Text('0', style: style);
  }

  Widget _buildTitle() {
    return Text(
      title,
      style:
          TextStyle(fontSize: UIDefine.fontSize14, color: AppColors.dialogGrey),
    );
  }
}
