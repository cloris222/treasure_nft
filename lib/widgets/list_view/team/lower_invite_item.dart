import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_invite_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

class LowerInviteItemView extends StatelessWidget {
  const LowerInviteItemView({super.key, required this.itemData});

  final LowerInviteData itemData;

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(height: UIDefine.getPixelHeight(5));
    return Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(3)),
        decoration: BoxDecoration(
          color: AppColors.textWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.datePickerBorder, width: 2),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: UIDefine.getScreenWidth(16),
                  child: itemData.isActive == 0
                      ? null
                      : Image.asset(AppImagePath.checkIcon02)),
              space,
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(BaseViewModel().changeTimeZone(itemData.time),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: UIDefine.fontSize12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.dialogGrey)),
                    space,
                    _buildParam(tr('nickname'), itemData.userName),
                    space,
                    _buildParam(tr('email'), itemData.email),
                    space,
                    _buildParam(
                        tr('tradingVol'), itemData.tradingVolume.toString()),
                  ]))
            ]));
  }

  Widget _buildParam(String title, String value) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title,
          style: TextStyle(
            fontSize: UIDefine.fontSize12,
          )),
      Text(
        value.trim(),
        overflow: TextOverflow.clip,
        style: TextStyle(
            fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
      )
    ]);
  }
}
