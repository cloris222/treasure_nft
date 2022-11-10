import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_member_detail.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/personal/team/widget/number_paginator_widget.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/list_view/team/member_detail_listview.dart';

import '../../../view_models/personal/team/team_member_datail_viewmodel.dart';
import '../../custom_appbar_view.dart';

///MARK:成員詳細
class TeamMemberDetailPage extends StatefulWidget {
  const TeamMemberDetailPage(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.type});

  final String startTime;
  final String endTime;
  final String type;

  @override
  State<StatefulWidget> createState() {
    return _TeamMemberDetailPage();
  }
}

class _TeamMemberDetailPage extends State<TeamMemberDetailPage> {
  TeamMemberViewModel memberViewModel = TeamMemberViewModel();
  late TeamMemberDetailViewModel viewModel;
  late List<MemberDetailPageList> list = [];
  int currentPage = 1;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    viewModel = TeamMemberDetailViewModel(
        onListChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        startTime: widget.startTime,
        endTime: widget.endTime,
        type: widget.type);
    viewModel.initListView();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        needScrollView: false,
        title: tr("teamDetail"),
        type: AppNavigationBarType.typePersonal,
        body: Padding(
            padding: EdgeInsets.only(
                left: UIDefine.getScreenWidth(6),
                right: UIDefine.getScreenWidth(6)),
            child: viewModel.buildListView()));
  }
}
