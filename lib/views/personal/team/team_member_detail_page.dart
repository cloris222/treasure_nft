import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_member_detail.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/personal/team/widget/number_paginator_widget.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/list_view/team/member_detail_listview.dart';


///MARK:成員詳細
class TeamMemberDetailPage extends StatefulWidget {
  const TeamMemberDetailPage({super.key,
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
  TeamMemberViewModel viewModel = TeamMemberViewModel();
  late List<MemberDetailPageList> list = [];
  int currentPage = 1;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    callMemberDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.getCommonAppBar(() {
          BaseViewModel().popPage(context);
        }, tr('teamDetail')),
        bottomNavigationBar:
        const AppBottomNavigationBar(initType: AppNavigationBarType.typePersonal),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left:UIDefine.getScreenWidth(6),
                right: UIDefine.getScreenWidth(6)),
            child:Column(
                children: [
                  viewModel.getPadding(3),

                  MemberDetailListView(list: list),

                  viewModel.getPadding(3),


                  SizedBox(
                    height: UIDefine.getScreenHeight(8),
                    child:NumberPaginatorWidget(
                      onPageChange: (int index){
                        currentPage = index;
                        debugPrint('currentPage" $currentPage');
                        callMemberDetail();
                        setState(() {});
                      },
                      totalPages: viewModel.memberDetailTotalPages,
                    ),
                  ),

                ]),
          ),


          ));
  }

  callMemberDetail() {
    debugPrint('callMemberDetail');
    viewModel.getMemberDetail(currentPage, widget.startTime,
        widget.endTime, widget.type).then((value) => {
      list = value,
      setState(() {}),
    });
  }
}


