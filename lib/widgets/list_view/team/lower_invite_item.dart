import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_invite_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/home/home_main_view.dart';

class LowerInviteItemView extends StatefulWidget {
  const LowerInviteItemView({super.key, required this.itemData});

  final LowerInviteData itemData;

  @override
  State<StatefulWidget> createState() => _LowerInviteItem();
}

class _LowerInviteItem extends State<LowerInviteItemView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();

  @override
  Widget build(BuildContext context) {
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
                  child: widget.itemData.isActive == 0
                      ? null
                      : Image.asset(AppImagePath.checkIcon02)),
              viewModel.getPadding(1),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                        BaseViewModel().changeTimeZone(widget.itemData.time),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: UIDefine.fontSize12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.dialogGrey)),
                    viewModel.getPadding(1),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(tr('nickname'),
                              style: TextStyle(
                                fontSize: UIDefine.fontSize12,
                              )),
                          Text(
                            widget.itemData.userName.toString(),
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: UIDefine.fontSize12,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                    viewModel.getPadding(1),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr('email'),
                            style: TextStyle(
                              fontSize: UIDefine.fontSize12,
                            ),
                          ),
                          SizedBox(
                              width: UIDefine.getScreenWidth(35),
                              child: Text(
                                widget.itemData.email.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: UIDefine.fontSize12,
                                    fontWeight: FontWeight.w500),
                              ))
                        ]),
                    viewModel.getPadding(1),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(tr('tradingVol'),
                              style: TextStyle(
                                fontSize: UIDefine.fontSize12,
                              )),
                          Text(widget.itemData.tradingVolume.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: UIDefine.fontSize12,
                                  fontWeight: FontWeight.w500))
                        ])
                  ]))
            ]));
  }
}
