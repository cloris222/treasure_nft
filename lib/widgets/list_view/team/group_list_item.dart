import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/team_group_list.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';


class GroupListItemView extends StatefulWidget {
  const GroupListItemView({super.key, required this.itemData});

  final GroupList itemData;

  @override
  State<StatefulWidget> createState() => _GroupListItem();

}

class _GroupListItem extends State<GroupListItemView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }

}