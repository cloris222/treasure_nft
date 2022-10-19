import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import '../../constant/theme/app_colors.dart';

class WalletInfoItem extends StatelessWidget {
  const WalletInfoItem(
      {Key? key,
      required this.title,
      this.value,
      this.assetImagePath = AppImagePath.tetherImg,
      this.onPress,
      this.fillWidth = true})
      : super(key: key);
  final String title;
  final double? value;
  final String assetImagePath;
  final GestureTapCallback? onPress;
  final bool fillWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
            height: UIDefine.fontSize20 * 3,
            width: fillWidth ? UIDefine.getWidth() : null,
            alignment: Alignment.center,
            child: Column(children: [
              Expanded(child: _buildTitle()),
              const SizedBox(height: 5),
              Expanded(child: _buildValue()),
            ])));
  }

  Widget _buildValue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(assetImagePath,
            width: UIDefine.fontSize16,
            height: UIDefine.fontSize16,
            fit: BoxFit.contain),
        const SizedBox(width: 5),
        Text(NumberFormatUtil().removeTwoPointFormat(value),
            style: TextStyle(
                fontSize: UIDefine.fontSize16,
                color: AppColors.dialogBlack,
                fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Text(
        title,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: UIDefine.fontSize14, color: AppColors.dialogBlack),
      ),
    );
  }
}
