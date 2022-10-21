import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/members_detail.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';


class MembersDetailItemView extends StatefulWidget {
  const MembersDetailItemView({super.key, required this.itemData});

  final MembersDetail itemData;

  @override
  State<StatefulWidget> createState() => _TeamMembersItem();

}

class _TeamMembersItem extends State<MembersDetailItemView> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }

}