import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_member_detail.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/widgets/dialog/list_dialog.dart';
import 'lower_invite_listview.dart';
import 'lower_nft_listview.dart';

class MemberDetailItemView extends StatefulWidget {
  const MemberDetailItemView({super.key, required this.itemData});

  final MemberDetailPageList itemData;

  @override
  State<StatefulWidget> createState() => _MemberDetailItem();
}

class _MemberDetailItem extends State<MemberDetailItemView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();
  bool _loadingNFT = true;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        color: AppColors.dialogGrey,
        fontSize: UIDefine.fontSize12,
        fontWeight: FontWeight.w500);

    TextStyle contentStyle = TextStyle(
        color: AppColors.dialogBlack,
        fontSize: UIDefine.fontSize12,
        fontWeight: FontWeight.w600);

    return Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(5)),
        height: UIDefine.getScreenHeight(38),
        decoration: BoxDecoration(
          color: AppColors.textWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.datePickerBorder, width: 2),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// email
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr('email'), style: titleStyle),
                        viewModel.getPadding(1),
                        SizedBox(
                          width: UIDefine.getScreenWidth(35),
                          child:
                              Text(widget.itemData.email, style: contentStyle),
                        ),
                      ]),

                  /// Phone
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('phone'), style: titleStyle),
                      viewModel.getPadding(1),
                      Text(widget.itemData.phone.toString(),
                          style: contentStyle),
                    ],
                  ),

                  /// Trading Volume
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('tradingVol'), style: titleStyle),
                      viewModel.getPadding(1),
                      Row(children: [
                        SizedBox(
                          height: UIDefine.getScreenWidth(4),
                          child: Image.asset(AppImagePath.tetherImg),
                        ),
                        viewModel.getPadding(0.5),
                        Text(
                            NumberFormatUtil().removeTwoPointFormat(
                                widget.itemData.tradingVolume),
                            style: contentStyle),
                      ]),
                    ],
                  ),

                  /// NFTs
                  TextButton(
                    //圓角
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 2, color: AppColors.mainThemeButton),
                          borderRadius: BorderRadius.circular(10))),
                    ),

                    onPressed: () {
                      viewModel
                          .getLowerNFT(
                              widget.itemData.itemCount, widget.itemData.userId)
                          .then((value) => {
                                ListDialog(
                                  context,
                                  mainText: tr('NFTs'),
                                  callOkFunction: () {},
                                  listView: LowerNFTListView(list: value),
                                ).show(),
                              });
                    },

                    child: Container(
                        padding: EdgeInsets.only(
                          left: UIDefine.getScreenWidth(2),
                          right: UIDefine.getScreenWidth(2),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('NFTs'),
                              style: const TextStyle(
                                  color: AppColors.mainThemeButton),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                              left: UIDefine.getScreenWidth(6),
                            )),
                            Text(
                              widget.itemData.itemCount.toString(),
                              style: const TextStyle(
                                  color: AppColors.mainThemeButton),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NickName
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('nickname'), style: titleStyle),
                      viewModel.getPadding(1),
                      Text(widget.itemData.userName, style: contentStyle),
                    ],
                  ),

                  /// Holding price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('value'), style: titleStyle),
                      viewModel.getPadding(1),
                      Row(
                        children: [
                          SizedBox(
                            height: UIDefine.getScreenWidth(4),
                            child: Image.asset(AppImagePath.tetherImg),
                          ),
                          viewModel.getPadding(0.5),
                          Text(
                              NumberFormatUtil().removeTwoPointFormat(
                                  widget.itemData.totalPrice),
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
                          Text(
                            ' ',
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: UIDefine.fontSize12,
                            ),
                          ),
                          viewModel.getPadding(1),
                          Text(
                            ' ',
                            style: TextStyle(
                              color: AppColors.textBlack,
                              fontSize: UIDefine.fontSize12,
                            ),
                          ),
                        ],
                      )),

                  /// Invite
                  TextButton(
                      //圓角
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 2, color: AppColors.mainThemeButton),
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      onPressed: () {
                        viewModel
                            .getLowerInvite(widget.itemData.inviteCount,
                                widget.itemData.userId)
                            .then((value) => {
                                  ListDialog(
                                    context,
                                    mainText: tr('invite'),
                                    callOkFunction: () {},
                                    listView: LowerInviteListView(list: value),
                                  ).show(),
                                });
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                            left: UIDefine.getScreenWidth(2),
                            right: UIDefine.getScreenWidth(2),
                          ),
                          child: Row(
                            children: [
                              Text(
                                tr('invite'),
                                style: const TextStyle(
                                    color: AppColors.mainThemeButton),
                              ),
                              viewModel.getPadding(3),
                              Text(
                                widget.itemData.inviteCount.toString(),
                                style: const TextStyle(
                                    color: AppColors.mainThemeButton),
                              ),
                            ],
                          ))),
                ],
              ),
            ]));
  }
}
