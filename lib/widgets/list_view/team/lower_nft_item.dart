import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_nft_data.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';


class LowerNFTItemView extends StatefulWidget {
  const LowerNFTItemView({super.key, required this.itemData});
  final LowerNftData itemData;

  @override
  State<StatefulWidget> createState() => _LowerNFTItem();

}

class _LowerNFTItem extends State<LowerNFTItemView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(3)),
        decoration: BoxDecoration(
          color: AppColors.textWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: AppColors.datePickerBorder,
              width: 2
          ),
        ),

        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                width: UIDefine.getScreenWidth(20),
                child:Image.network(widget.itemData.originImgUrl),
              ),

              viewModel.getPadding(1),

              SizedBox(
              width: UIDefine.getScreenWidth(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(widget.itemData.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: UIDefine.fontSize14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  viewModel.getPadding(2),

                  Row(children: [
                  SizedBox(
                    height: UIDefine.getScreenWidth(4),
                    child:Image.asset(AppImagePath.tetherImg),
                  ),

                  viewModel.getPadding(1),

                  Text(widget.itemData.currentPrice.toString(),
                    style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                    ),),
                ],)


              ],))
            ]));
  }

}
