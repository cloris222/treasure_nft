import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/team_member_detail.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'member_detail_item.dart';


class MemberDetailListView extends StatefulWidget {
  const MemberDetailListView({super.key,
    required this.list,
  });

  final List<MemberDetailPageList> list;

  @override
  State<StatefulWidget> createState() => _MemberDetailListView();

}

class _MemberDetailListView extends State<MemberDetailListView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();


  Widget createItemBuilder(BuildContext context, int index) {
    return MemberDetailItemView(
      itemData: widget.list[index],
    );
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return viewModel.getPadding(3);
    //   Divider(
    //   height: UIDefine.getScreenWidth(4.16),
    //   color: AppColors.datePickerBorder,
    // );
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