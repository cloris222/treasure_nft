import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/team/team_member_detail_page.dart';
import 'package:treasure_nft_project/views/personal/team/widget/all_members_card.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/date_picker/date_picker.dart';

///MARK:團隊成員
class TeamMemberPage extends StatelessWidget {
  const TeamMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      title: tr("teamMember"),
      type: AppNavigationBarType.typePersonal,
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  TeamMemberViewModel viewModel = TeamMemberViewModel();

  String startDate = 'Select date';
  String endDate = '';

  Search buttonType = Search.All;
  TeamMembers teamMembers = TeamMembers();

  @override
  void initState() {
    super.initState();
    viewModel.getTeamMembers('', '').then((value) => {
          teamMembers = value,
          setState(() {}),
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
                left: UIDefine.getScreenWidth(6),
                right: UIDefine.getScreenWidth(6)),
            child: Column(
              children: [
                viewModel.getPadding(3),

                /// 日期選擇器 & 按鈕
                DatePickerWidget(
                  dateCallback: (String startDate, String endDate) async {
                    await viewModel
                        .getTeamMembers(
                          startDate,
                          endDate,
                        )
                        .then((value) => {teamMembers = value});
                    setState(() {});
                  },
                ),

                /// all members
                Container(
                  alignment: Alignment.centerLeft,
                  width: UIDefine.getWidth(),
                  height: UIDefine.getScreenHeight(10),
                  child: Text(
                    tr('AllMembers'),
                    style: TextStyle(fontSize: UIDefine.fontSize14),
                  ),
                ),

                /// all
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    viewModel.pushPage(
                        context,
                        TeamMemberDetailPage(
                          startTime: startDate,
                          endTime: endDate,
                          type: 'totalUser',
                        ));
                  },
                  child: AllMembersCard(
                    leftTitle: tr('AllMember'),
                    leftValue: teamMembers.totalUser.toString(),
                    rightTitle: tr('allValidMembers'),
                    rightValue: teamMembers.totalActive.toString(),
                    onPressActive: () {},
                    onPressAll: () {},
                  ),
                ),

                viewModel.getPaddingWithView(
                  2,
                  const Divider(
                      color: AppColors.datePickerBorder, thickness: 1.5),
                ),

                /// A class
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    viewModel.pushPage(
                        context,
                        TeamMemberDetailPage(
                          startTime: startDate,
                          endTime: endDate,
                          type: 'direct',
                        ));
                  },
                  child: AllMembersCard(
                    leftTitle: tr('direct'),
                    leftValue: teamMembers.direct.toString(),
                    rightTitle: tr('activeDirect'),
                    rightValue: teamMembers.activeDirect.toString(),
                    onPressActive: () {},
                    onPressAll: () {},
                  ),
                ),

                viewModel.getPaddingWithView(
                  2,
                  const Divider(
                      color: AppColors.datePickerBorder, thickness: 1.5),
                ),

                /// B class
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    viewModel.pushPage(
                        context,
                        TeamMemberDetailPage(
                          startTime: startDate,
                          endTime: endDate,
                          type: 'indirect',
                        ));
                  },
                  child: AllMembersCard(
                    leftTitle: tr('indirect'),
                    leftValue: teamMembers.indirect.toString(),
                    rightTitle: tr('activeIndirect'),
                    rightValue: teamMembers.activeIndirect.toString(),
                    onPressActive: () {},
                    onPressAll: () {},
                  ),
                ),

                viewModel.getPaddingWithView(
                  2,
                  const Divider(
                      color: AppColors.datePickerBorder, thickness: 1.5),
                ),

                /// C class
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    viewModel.pushPage(
                        context,
                        TeamMemberDetailPage(
                          startTime: startDate,
                          endTime: endDate,
                          type: 'third',
                        ));
                  },
                  child: AllMembersCard(
                    leftTitle: tr('third'),
                    leftValue: teamMembers.third.toString(),
                    rightTitle: tr('activeThird'),
                    rightValue: teamMembers.activeThird.toString(),
                    onPressActive: () {},
                    onPressAll: () {},
                  ),
                ),
              ],
            )));
  }

  Future<void> _showDatePicker(BuildContext context) async {
    await showDateRangePicker(
            context: context,
            firstDate: DateTime(2022, 10),
            lastDate: DateTime.now())
        .then((value) => {
              startDate = viewModel.dateTimeFormat(value?.start),
              endDate = viewModel.dateTimeFormat(value?.end),
            })
        .then((value) async => {
              await viewModel
                  .getTeamMembers(startDate, endDate)
                  .then((value) => {
                        teamMembers = value,
                        setState(() {}),
                      }),
            });
    debugPrint('startDate: $startDate');
  }
}
