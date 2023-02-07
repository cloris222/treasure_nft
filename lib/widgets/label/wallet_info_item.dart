import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
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
            height: UIDefine.fontSize20 * 3.5,
            width: fillWidth ? UIDefine.getWidth() : null,
            alignment: Alignment.center,
            child: Column(children: [
              _buildValue(),
              SizedBox(height: UIDefine.getPixelWidth(5)),
              Expanded(child: _buildTitle()),
            ])));
  }

  Widget _buildValue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TetherCoinWidget(size: UIDefine.fontSize14),
        const SizedBox(width: 5),
        Flexible(
          child: Text(NumberFormatUtil().removeTwoPointFormat(value),
              maxLines: 1,
              textAlign: TextAlign.start,
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize14,
                  color: AppColors.dialogBlack,
                  fontWeight: FontWeight.w700)),
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        title,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: AppTextStyle.getBaseStyle(
            fontSize: UIDefine.fontSize12, color: AppColors.textNineBlack),
      ),
    );
  }
}
