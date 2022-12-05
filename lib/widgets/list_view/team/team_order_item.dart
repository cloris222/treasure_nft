import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_order.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/personal/team/share_team_order_page.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';

import '../../../views/personal/team/other_collect_page.dart';

class TeamOrderItemView extends StatefulWidget {
  const TeamOrderItemView({super.key, required this.itemData});

  final TeamOrderData itemData;

  @override
  State<StatefulWidget> createState() => _TeamOrderItem();
}

class _TeamOrderItem extends State<TeamOrderItemView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(
        alignment: Alignment.topLeft,
        children: [
          CachedNetworkImage(
            imageUrl: widget.itemData.imgUrl,
            fit: BoxFit.contain,
            errorWidget: (context, url, error) => const Icon(Icons.cancel_rounded),
          ),
          Positioned(child: _buildOrderType())
        ],
      ),
      viewModel.getPadding(1),

      /// Name
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.itemData.getItemName(),
            maxLines: 1,
            style: TextStyle(
                fontSize: UIDefine.fontSize14, fontWeight: FontWeight.bold),
          ),

          /// Share
          Visibility(
              visible: widget.itemData.type == 'SELL',
              child: GestureDetector(
                  onTap: _onPressShare,
                  child: SizedBox(
                    width: UIDefine.getScreenWidth(6),
                    child: Image.asset(AppImagePath.shareIcon02),
                  )))
        ],
      ),

      viewModel.getPadding(1),

      /// Time
      Wrap(children: [
        Text(viewModel.changeTimeZone(widget.itemData.time),
            style: TextStyle(
                fontSize: UIDefine.fontSize12, color: AppColors.textGrey))
      ]),

      viewModel.getPadding(1),

      /// buyer
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('buyer'),
              style: TextStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.textGrey,
              ),
            ),
            SizedBox(width: UIDefine.getScreenWidth(5)),
            Flexible(
              child: GestureDetector(
                onTap: () => _onPressBuyer(),
                child: Text(
                  widget.itemData.buyerName,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.mainThemeButton,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ]),

      viewModel.getPadding(1),

      /// seller
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('seller'),
              style: TextStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.textGrey,
              ),
            ),
            SizedBox(width: UIDefine.getScreenWidth(5)),
            Flexible(
              child: GestureDetector(
                onTap: () => _onPressSeller(),
                child: Text(
                  widget.itemData.sellerName,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.mainThemeButton,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ]),

      viewModel.getPadding(1),

      /// income
      Visibility(
        visible: widget.itemData.type == 'SELL',
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            tr('income'),
            style: TextStyle(
              fontSize: UIDefine.fontSize12,
              color: AppColors.textGrey,
            ),
          ),
          viewModel.getPadding(1),
          Row(
            children: [
              viewModel.getCoinImage(),
              viewModel.getPadding(0.5),
              Text(
                NumberFormatUtil().removeTwoPointFormat(widget.itemData.income),
                style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                ),
              ),
            ],
          )
        ]),
      ),

      viewModel.getPadding(1),

      /// 儲金罐
      Visibility(
        visible: widget.itemData.type == 'SELL',
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            tr('goldStorageTank'),
            style: TextStyle(
              fontSize: UIDefine.fontSize12,
              color: AppColors.textGrey,
            ),
          ),
          viewModel.getPadding(1),
          Row(
            children: [
              viewModel.getCoinImage(),
              viewModel.getPadding(0.5),
              Text(
                NumberFormatUtil()
                    .removeTwoPointFormat(widget.itemData.moneyBox),
                style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                ),
              ),
            ],
          )
        ]),
      ),
      const Spacer(),
      const Divider(
        color: AppColors.datePickerBorder,
      ),

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(),
        Row(
          children: [
            viewModel.getCoinImage(),
            viewModel.getPadding(0.5),
            Text(
              NumberFormatUtil().removeTwoPointFormat(widget.itemData.price),
              style: TextStyle(
                fontSize: UIDefine.fontSize12,
              ),
            ),
          ],
        )
      ]),
    ]);
  }

  Widget _buildOrderType() {
    Color bg;
    String text;
    if (widget.itemData.type == 'SELL') {
      bg = AppColors.textRed;
      text = tr('type_SELL');
    } else {
      bg = AppColors.growPrice;
      text = tr('ord_bought');
    }

    return Container(
        constraints: BoxConstraints(minWidth: UIDefine.getScreenWidth(15)),
        padding: EdgeInsets.symmetric(
            vertical: UIDefine.getScreenHeight(1),
            horizontal: UIDefine.getScreenWidth(1)),
        color: bg,
        child: Text(text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w600)));
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
