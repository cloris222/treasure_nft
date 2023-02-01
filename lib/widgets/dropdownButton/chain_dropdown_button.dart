import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/coin_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_theme.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';

class ChainDropDownButton extends StatelessWidget {
  const ChainDropDownButton(
      {Key? key, required this.onChainChange, required this.currentChain})
      : super(key: key);
  final void Function(CoinEnum chain) onChainChange;
  final CoinEnum currentChain;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        icon: Image.asset(AppImagePath.arrowDownGrey),
        onChanged: (newValue) => onChainChange(newValue as CoinEnum),
        value: currentChain,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
              UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(4.16), 0),
          hintStyle: AppTextStyle.getBaseStyle(
              height: 1.6, color: AppColors.textBlack),
          border: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.bolderGrey, radius: 10),
          focusedBorder: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.bolderGrey, radius: 10),
          enabledBorder: AppTheme.style.styleTextEditBorderBackground(
              color: AppColors.bolderGrey, radius: 10),
        ),
        items: [
          DropdownMenuItem(
              value: CoinEnum.TRON,
              child: Row(children: [
                TetherCoinWidget(size: UIDefine.fontSize24),
                currentChain == CoinEnum.TRON
                    ? GradientText(
                        '  USDT-TRC20',
                        size: UIDefine.fontSize14,
                        colors: AppColors.gradientBaseColorBg,
                      )
                    : Text('  USDT-TRC20',
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14, color: Colors.black))
              ])),
          DropdownMenuItem(
              value: CoinEnum.BSC,
              child: Row(children: [
                TetherCoinWidget(size: UIDefine.fontSize24),
                currentChain == CoinEnum.BSC
                    ? GradientText(
                        '  USDT-BSC',
                        size: UIDefine.fontSize14,
                        colors: AppColors.gradientBaseColorBg,
                      )
                    : Text('  USDT-BSC',
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14, color: Colors.black))
              ]))
        ]);
  }
}
