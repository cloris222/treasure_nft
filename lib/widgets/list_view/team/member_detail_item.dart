import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_member_detail.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/widgets/bottom_sheet/list_bottom_sheet.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../../views/personal/team/team_main_style.dart';
import 'lower_invite_listview.dart';
import 'lower_nft_listview.dart';

class MemberDetailItemView extends StatelessWidget {
  const MemberDetailItemView({super.key, required this.itemData});

  final MemberDetailPageList itemData;

  @override
  Widget build(BuildContext context) {
    TeamMainStyle style = TeamMainStyle();
    TextStyle titleStyle = AppTextStyle.getBaseStyle(
        color: AppColors.textSixBlack,
        fontSize: UIDefine.fontSize12,
        fontWeight: FontWeight.w400);

    TextStyle contentStyle = AppTextStyle.getBaseStyle(
        color: AppColors.textBlack,
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w400);

    return Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
        height: UIDefine.getPixelHeight(350),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// email
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr('email'), style: titleStyle),
                          style.getPadding(1),
                          SizedBox(
                            width: UIDefine.getScreenWidth(35),
                            child: Text(itemData.email, style: contentStyle),
                          ),
                        ]),

                    /// Phone
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr('phone'), style: titleStyle),
                        style.getPadding(1),
                        Text(itemData.phone.toString(), style: contentStyle),
                      ],
                    ),

                    /// Trading Volume
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr('tradingVol'), style: titleStyle),
                        style.getPadding(1),
                        Row(children: [
                          SizedBox(
                            height: UIDefine.getScreenWidth(4),
                            child: Image.asset(AppImagePath.tetherImg),
                          ),
                          style.getPadding(0.5),
                          Text(
                              NumberFormatUtil()
                                  .removeTwoPointFormat(itemData.tradingVolume),
                              style: contentStyle),
                        ]),
                      ],
                    ),

                    /// NFTs
                    LoginBolderButtonWidget(
                      margin:
                          const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                      radius: 8,
                      alignment: Alignment.centerLeft,
                      onPressed: () => _onShowNFTs(context),
                      fontSize: UIDefine.fontSize14,
                      btnText: '${tr('NFTs')}　${itemData.itemCount.toString()}',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// NickName
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr('account'), style: titleStyle),
                        style.getPadding(1),
                        Text(itemData.account, style: contentStyle),
                      ],
                    ),

                    /// Holding price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr('value'), style: titleStyle),
                        style.getPadding(1),
                        Row(
                          children: [
                            SizedBox(
                              height: UIDefine.getScreenWidth(4),
                              child: Image.asset(AppImagePath.tetherImg),
                            ),
                            style.getPadding(0.5),
                            Text(
                                NumberFormatUtil()
                                    .removeTwoPointFormat(itemData.totalPrice),
                                style: contentStyle),
                          ],
                        )
                      ],
                    ),

                    Opacity(
                        opacity: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr('tradingVol'), style: titleStyle),
                            style.getPadding(1),
                            Row(children: [
                              SizedBox(
                                height: UIDefine.getScreenWidth(4),
                                child: Image.asset(AppImagePath.tetherImg),
                              ),
                              style.getPadding(0.5),
                              Text(
                                  NumberFormatUtil().removeTwoPointFormat(
                                      itemData.tradingVolume),
                                  style: contentStyle),
                            ]),
                          ],
                        )),

                    /// Invite
                    LoginBolderButtonWidget(
                      margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                      radius: 8,
                      alignment: Alignment.centerLeft,
                      onPressed: () => _onShowInvite(context),
                      fontSize: UIDefine.fontSize14,
                      btnText:
                          '${tr('invite')}　${itemData.inviteCount.toString()}',
                    ),
                  ],
                ),
              ),
            ]));
  }

  _onShowInvite(BuildContext context) {
    if (itemData.inviteCount == 0) {
      ListBottomSheet(
        context,
        mainText: tr('invite'),
        callOkFunction: () {},
        listView: _buildEmptyView(),
      ).show();
    } else {
      TeamMemberViewModel()
          .getLowerInvite(itemData.inviteCount, itemData.userId)
          .then((value) => {
                ListBottomSheet(
                  context,
                  mainText: tr('invite'),
                  callOkFunction: () {},
                  listView: LowerInviteListView(list: value),
                ).show(),
              });
    }
  }

  _onShowNFTs(BuildContext context) {
    if (itemData.itemCount == 0) {
      ListBottomSheet(
        context,
        mainText: tr('NFTs'),
        callOkFunction: () {},
        listView: _buildEmptyView(),
      ).show();
    } else {
      TeamMemberViewModel()
          .getLowerNFT(itemData.itemCount, itemData.userId)
          .then((value) => {
                ListBottomSheet(
                  context,
                  mainText: tr('NFTs'),
                  callOkFunction: () {},
                  listView: LowerNFTListView(list: value),
                ).show(),
              });
    }
  }

  Widget _buildEmptyView() {
    Widget space = SizedBox(height: UIDefine.getScreenHeight(2));
    return Container(
        height: UIDefine.getScreenHeight(50),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  AppImagePath.emptyCoffee,
                  height: UIDefine.getWidth() * 0.25,
                  fit: BoxFit.fitHeight,
                ),
                space,
                Text(
                  'No Notifications',
                  style: AppTextStyle.getBaseStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.emptyCoffee,
                      fontSize: UIDefine.fontSize14),
                ),
                space
              ]),
          Center(
            child: Text(tr('noData'),
                style: AppTextStyle.getBaseStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.emptyCoffee.withOpacity(0.3),
                    fontSize: UIDefine.fontSize16)),
          ),
          space
        ]));
  }
}
