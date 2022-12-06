import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_group_list.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import '../team/group_list_item.dart';


class GroupListListView extends StatefulWidget {
  const GroupListListView({super.key});

  @override
  State<StatefulWidget> createState() => _GroupListListView();

}

class _GroupListListView extends State<GroupListListView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();
  late List<GroupList> list = [];

  GroupList teamMembers = GroupList();

  @override
  void initState() {
    super.initState();
    viewModel.getGroupList().then((value) => {
      teamMembers = value,
      list.add(teamMembers),
      setState(() {}),
    });
  }


  Widget createItemBuilder(BuildContext context, int index) {
    return GroupListItemView(
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