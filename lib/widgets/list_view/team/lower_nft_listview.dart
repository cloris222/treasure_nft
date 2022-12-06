import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_nft_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_member_detail.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'lower_nft_item.dart';
import 'member_detail_item.dart';


class LowerNFTListView extends StatefulWidget {
  const LowerNFTListView({super.key,
    required this.list,
  });

  final List<LowerNftData> list;

  @override
  State<StatefulWidget> createState() => _LowerNFTListView();

}

class _LowerNFTListView extends State<LowerNFTListView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();


  Widget createItemBuilder(BuildContext context, int index) {
    return LowerNFTItemView(
      itemData: widget.list[index],
    );
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return viewModel.getPadding(3);
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