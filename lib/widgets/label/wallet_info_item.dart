import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import '../../constant/theme/app_colors.dart';
import 'coin/tether_coin_widget.dart';

class WalletInfoItem extends StatelessWidget {
  const WalletInfoItem(
      {Key? key,
      required this.title,
      this.value,
      this.onPress,
      this.fillWidth = true})
      : super(key: key);
  final String title;
  final double? value;
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
        TetherCoinWidget(size: UIDefine.fontSize14),
        const SizedBox(width: 5),
        Text(NumberFormatUtil().removeTwoPointFormat(value),
            maxLines: 1,
            style: TextStyle(
                fontSize: UIDefine.fontSize14,
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
