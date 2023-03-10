import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_list_data.dart';
import 'package:treasure_nft_project/widgets/list_view/team/team_contribute_item.dart';


class TeamContributeListView extends StatefulWidget {
  const TeamContributeListView({super.key,
    required this.list,
  });

  final List<TeamContributeList> list;

  @override
  State<StatefulWidget> createState() => _TeamContributeListView();

}

class _TeamContributeListView extends State<TeamContributeListView> {

  Widget createItemBuilder(BuildContext context, int index) {
    return TeamContributeItemView(
      itemData: widget.list[index],
      serialNumber: index,
    );
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return Divider(
      height: UIDefine.getScreenWidth(4.16),
      color: AppColors.datePickerBorder,
    );
  }


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return createItemBuilder(context, index);
        },
        itemCount: widget.list.length,
        separatorBuilder: (BuildContext context, int index) {
          return createSeparatorBuilder(context, index);
        });
  }

}