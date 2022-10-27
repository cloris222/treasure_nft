import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_order.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'team_order_item.dart';


class TeamOrderListView extends StatefulWidget {
  const TeamOrderListView({super.key,
    required this.list,
  });

  final List<TeamOrderData> list;

  @override
  State<StatefulWidget> createState() => _TeamOrderListView();

}

class _TeamOrderListView extends State<TeamOrderListView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();


  Widget createItemBuilder(BuildContext context, int index) {
    return TeamOrderItemView(
      itemData: widget.list[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: UIDefine.getScreenHeight(100),
          crossAxisSpacing: UIDefine.getScreenWidth(5)),
      itemCount:widget.list.length,
      itemBuilder: (context, index) {
        return createItemBuilder(context, index);
      },
    );
  }

}