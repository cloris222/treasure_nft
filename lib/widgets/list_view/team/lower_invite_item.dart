import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_invite_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';

class LowerInviteItemView extends StatelessWidget {
  const LowerInviteItemView({super.key, required this.itemData});

  final LowerInviteData itemData;

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: UIDefine.getPixelHeight(5));
    return Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(3)),
        decoration: AppStyle().styleColorsRadiusBackground(
            color: AppColors.itemBackground, radius: 4),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //     width: UIDefine.getScreenWidth(16),
              //     child: itemData.isActive == 0
              //         ? null
              //         : Image.asset(AppImagePath.checkIcon02)),
              // space,
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(BaseViewModel().changeTimeZone(itemData.time),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14,
                            color: AppColors.textSixBlack)),
                    space,
                    _buildParam(tr('nickname'), itemData.userName, false),
                    space,
                    _buildParam(tr('email'), itemData.email, false),
                    space,
                    _buildParam(tr('tradingVol'),
                        itemData.tradingVolume.toString(), true),
                  ]))
            ]));
  }

  Widget _buildParam(String title, String value, bool needCoin) {
    return Row(children: [
      Text(title,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14, color: AppColors.textSixBlack)),
      const Spacer(),
      Visibility(
        visible: needCoin,
        child: Padding(
            padding: EdgeInsets.only(right: UIDefine.getPixelWidth(5)),
            child: TetherCoinWidget(size: UIDefine.getPixelWidth(12))),
      ),
      Text(
        value.trim(),
        overflow: TextOverflow.clip,
        style: AppTextStyle.getBaseStyle(
            fontSize: UIDefine.fontSize14,
            fontWeight: FontWeight.w400,
            color: AppColors.textBlack),
      )
    ]);
  }
}
