import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_order.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/team/share_team_order_page.dart';
import 'package:treasure_nft_project/views/personal/team/team_main_style.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../views/personal/team/other_collect_page.dart';

class TeamOrderItemView extends StatefulWidget {
  const TeamOrderItemView({super.key, required this.itemData});

  final TeamOrderData itemData;

  @override
  State<StatefulWidget> createState() => _TeamOrderItem();
}

class _TeamOrderItem extends State<TeamOrderItemView> {
  TeamMainStyle style = TeamMainStyle();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(8)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  GraduallyNetworkImage(
                    width: UIDefine.getWidth(),
                    height: UIDefine.getPixelWidth(100),
                    imageUrl: widget.itemData.imgUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(top: 0, left: 0, child: _buildOrderType())
                ],
              ),
            ),
            style.getPadding(1),

            /// Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.itemData.getItemName(),
                  maxLines: 1,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textThreeBlack),
                ),

                /// Share
                Visibility(
                    visible: widget.itemData.type == 'SELL' ,
                    child: GestureDetector(
                        onTap: _onPressShare,
                        child: SizedBox(
                          width: UIDefine.getScreenWidth(6),
                          child: Image.asset(AppImagePath.shareIcon02),
                        )))
              ],
            ),

            style.getPadding(1),

            /// Time
            Wrap(children: [
              Text(BaseViewModel().changeTimeZone(widget.itemData.time),
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textNineBlack,
                      fontWeight: FontWeight.w400))
            ]),

            style.getPadding(1),

            /// buyer
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('buyer'),
                    style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textSixBlack,
                    ),
                  ),
                  SizedBox(width: UIDefine.getScreenWidth(5)),
                  Flexible(
                    child: GestureDetector(
                      onTap: () => _onPressBuyer(),
                      child: GradientThirdText(widget.itemData.buyerName,
                          size: UIDefine.fontSize12, weight: FontWeight.w600),
                    ),
                  ),
                ]),

            style.getPadding(1),

            /// seller
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('seller'),
                    style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textSixBlack,
                    ),
                  ),
                  SizedBox(width: UIDefine.getScreenWidth(5)),
                  Flexible(
                    child: GestureDetector(
                      onTap: () => _onPressSeller(),
                      child: GradientThirdText(widget.itemData.sellerName,
                          size: UIDefine.fontSize12, weight: FontWeight.w600),
                    ),
                  ),
                ]),

            style.getPadding(1),

            /// income
            Visibility(
              visible: widget.itemData.type == 'SELL',
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('income'),
                      style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize12,
                        color: AppColors.textSixBlack,
                      ),
                    ),
                    style.getPadding(1),
                    Row(
                      children: [
                        TetherCoinWidget(size: UIDefine.getPixelWidth(12)),
                        style.getPadding(0.5),
                        Text(
                          NumberFormatUtil()
                              .removeTwoPointFormat(widget.itemData.income),
                          style: AppTextStyle.getBaseStyle(
                              fontSize: UIDefine.fontSize12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack),
                        ),
                      ],
                    )
                  ]),
            ),

            style.getPadding(1),

            /// 儲金罐
            Visibility(
              visible: widget.itemData.type == 'SELL',
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('goldStorageTank'),
                      style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize12,
                        color: AppColors.textSixBlack,
                      ),
                    ),
                    style.getPadding(1),
                    Row(
                      children: [
                        TetherCoinWidget(size: UIDefine.getPixelWidth(12)),
                        style.getPadding(0.5),
                        Text(
                          NumberFormatUtil()
                              .removeTwoPointFormat(widget.itemData.moneyBox),
                          style: AppTextStyle.getBaseStyle(
                              fontSize: UIDefine.fontSize12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack),
                        ),
                      ],
                    )
                  ]),
            ),

            const Divider(color: Color(0xFFEDEDED)),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(),
              Row(
                children: [
                  TetherCoinWidget(size: UIDefine.getPixelWidth(12)),
                  style.getPadding(0.5),
                  Text(
                    NumberFormatUtil()
                        .removeTwoPointFormat(widget.itemData.price),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack),
                  ),
                ],
              )
            ]),
          ]),
    );
  }

  Widget _buildOrderType() {
    String imagePath;
    if (widget.itemData.type == 'SELL') {
      imagePath = AppImagePath.orderSold;
    } else {
      imagePath = AppImagePath.orderBought;
    }

    return Container(
      constraints: BoxConstraints(minWidth: UIDefine.getScreenWidth(15)),
      child: Image.asset(imagePath),
    );
  }

  void _onPressShare() {
    BaseViewModel().pushOpacityPage(
        context, ShareTeamOrderPage(itemData: widget.itemData));
  }

  _onPressBuyer() {
    BaseViewModel().pushPage(context,
        OtherCollectPage(isSeller: false, orderNo: widget.itemData.orderNo));
  }

  _onPressSeller() {
    BaseViewModel().pushPage(context,
        OtherCollectPage(isSeller: true, orderNo: widget.itemData.orderNo));
  }
}
