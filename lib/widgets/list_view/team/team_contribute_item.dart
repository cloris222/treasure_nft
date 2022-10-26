
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_list_data.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';


class TeamContributeItemView extends StatefulWidget {
  const TeamContributeItemView({super.key, required this.itemData, required this.itemCount});
  final TeamContributeList itemData;
  final int itemCount;

  @override
  State<StatefulWidget> createState() => _TeamContributeItem();

}

class _TeamContributeItem extends State<TeamContributeItemView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UIDefine.getScreenWidth(3)),

     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [

         Row(children: [
           Text('${widget.itemCount.toString()}. ',
             style: TextStyle(
               fontSize: UIDefine.fontSize12,
               color: AppColors.textGrey,
             ),
           ),
           Text(widget.itemData.name,
             style: TextStyle(
               fontSize: UIDefine.fontSize12,
               color: AppColors.textGrey,
             ),
           ),
         ],),

         Container(),

         SizedBox(
           width: UIDefine.getScreenWidth(25),
           child:Row(children: [
             viewModel.getCoinImage(),
             viewModel.getPadding(1),

             Text(viewModel.numberCompatFormat(widget.itemData.share.toString()),
               style: TextStyle(
                 fontSize: UIDefine.fontSize12,
                 color: AppColors.textGrey,
               ),
               textAlign: TextAlign.start,
             ),
           ]),
         ),

      ],)

    );
  }
}