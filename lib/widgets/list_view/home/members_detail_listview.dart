import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/members_detail.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'members_detail_item.dart';


class TeamMembersListView extends StatefulWidget {
  const TeamMembersListView({super.key});

  @override
  State<StatefulWidget> createState() => _TeamMembersListView();

}

class _TeamMembersListView extends State<TeamMembersListView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();
  late List<MembersDetail> list = [];

  MembersDetail teamMembers = MembersDetail();

  @override
  void initState() {
    super.initState();
    viewModel.getMembersDetail().then((value) => {
      teamMembers = value,
      list.add(teamMembers),
      setState(() {}),
    });
  }


  Widget createItemBuilder(BuildContext context, int index) {
    return MembersDetailItemView(
      itemData: list[index],
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
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) {
          return createSeparatorBuilder(context, index);
        });
  }

}