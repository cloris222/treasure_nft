import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_order.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';


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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      Image.network(widget.itemData.imgUrl),

        /// Name
        Text(widget.itemData.itemName,
          style: TextStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.bold
          ),
        ),

      viewModel.getPadding(1),

        /// Time
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.itemData.time.toString(),
              style: TextStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.textGrey,
              ),
            ),

            /// Share
            Visibility(
              visible: widget.itemData.type == 'SELL',
              child:GestureDetector(
                  onTap: () {
                    SimpleCustomDialog(context).show();
                  },
                  child:  SizedBox(
                    width: UIDefine.getScreenWidth(6),
                    child: Image.asset(AppImagePath.shareIcon02),
                  )),
            ),
          ],),


      viewModel.getPadding(1),

      /// buyer
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tr('buyer'),
              style: TextStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.textGrey,
              ),
            ),

            Text(widget.itemData.buyerName,
              style: TextStyle(
                fontSize: UIDefine.fontSize12,
              ),
            ),
          ]),

      viewModel.getPadding(1),

      /// seller
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tr('seller'),
              style: TextStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.textGrey,
              ),
            ),

            Text(widget.itemData.sellerName,
              style: TextStyle(
                fontSize: UIDefine.fontSize12,
              ),
            ),
          ]),

      viewModel.getPadding(1),

      /// income
      Visibility(
        visible: widget.itemData.type == 'SELL',
        maintainState: true, maintainAnimation:true, maintainSize: true,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tr('income'),
                style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                  color: AppColors.textGrey,
                ),
              ),
              viewModel.getPadding(1),

              Row(children: [
                viewModel.getCoinImage(),
                viewModel.getPadding(0.5),
                Text(widget.itemData.income.toString(),
                  style: TextStyle(
                    fontSize: UIDefine.fontSize12,
                  ),
                ),
              ],)
            ]),
      ),

      viewModel.getPadding(1),

      /// 儲金罐
      Visibility(
        visible: widget.itemData.type == 'SELL',
        maintainState: true, maintainAnimation:true, maintainSize: true,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tr('goldStorageTank'),
                style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                  color: AppColors.textGrey,
                ),
              ),
              viewModel.getPadding(1),

              Row(children: [
                viewModel.getCoinImage(),
                viewModel.getPadding(0.5),
                Text(widget.itemData.moneyBox.toString(),
                  style: TextStyle(
                    fontSize: UIDefine.fontSize12,
                  ),
                ),
              ],)
            ]),
      ),

      const Divider(
        color: AppColors.datePickerBorder,
      ),


      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Row(children: [
              viewModel.getCoinImage(),
              viewModel.getPadding(0.5),
              Text(widget.itemData.price.toString(),
                style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                ),
              ),
            ],)
          ]),

    ]);
  }
}