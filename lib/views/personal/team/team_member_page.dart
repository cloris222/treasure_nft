import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';
import 'package:treasure_nft_project/view_models/control_router_viem_model.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/team/team_member_detail_page.dart';
import 'package:treasure_nft_project/views/personal/team/widget/all_members_card.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';

import '../../../view_models/personal/team/team_member_provider.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';

///MARK:團隊成員
class TeamMemberPage extends ConsumerStatefulWidget {
  const TeamMemberPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TeamMemberPageState();
}

class _TeamMemberPageState extends ConsumerState<TeamMemberPage> {

  String startDate = '';
  String endDate = '';

  Search buttonType = Search.All;

  @override
  void initState() {
    ref.read(teamMemberProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TeamMembers teamMembers = ref.watch(teamMemberProvider);
    return CustomAppbarView(
      needScrollView: false,
      backgroundColor: AppColors.defaultBackgroundSpace,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: AppNavigationBarType.typePersonal,
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(
                      left: UIDefine.getPixelWidth(20),
                      right: UIDefine.getPixelWidth(20),
                      bottom: UIDefine.getPixelWidth(20)),
                  color: Colors.white,
                  child: Column(
                    children: [
                      TitleAppBar(title: tr('')),

                      /// 日期選擇器 & 按鈕
                      CustomDatePickerWidget(
                        dateCallback: (String startDate, String endDate) async {
                          if (startDate != this.startDate ||
                              endDate != this.endDate) {
                            this.startDate = startDate;
                            this.endDate = endDate;
                            ref
                                .read(teamMemberProvider.notifier)
                                .setTimes([startDate, endDate]);
                            ref.read(teamMemberProvider.notifier).update();
                          }
                        },
                        typeList: const [
                          Search.All,
                          Search.Today,
                          Search.Yesterday,
                          Search.ThisWeek,
                          Search.ThisMonth
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: UIDefine.getPixelWidth(20),
                      horizontal: UIDefine.getPixelWidth(20)),
                  margin: EdgeInsets.symmetric(
                      vertical: UIDefine.getPixelWidth(10),
                      horizontal: UIDefine.getPixelWidth(10)),
                  decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
                  child: Column(
                    children: [
                      /// all
                      AllMembersCard(
                        leftTitle: tr('AllMember'),
                        leftValue: teamMembers.totalUser.toString(),
                        rightTitle: tr('allValidMembers'),
                        rightValue: teamMembers.totalActive.toString(),
                        onPressAll: () => showMemberDetail('totalUser'),
                        onPressActive: () => showMemberDetail('totalActive'),
                      ),

                      SizedBox(height: UIDefine.getPixelWidth(30)),

                      /// A class
                      AllMembersCard(
                        leftTitle: tr('direct'),
                        leftValue: teamMembers.direct.toString(),
                        rightTitle: tr('activeDirect'),
                        rightValue: teamMembers.activeDirect.toString(),
                        onPressAll: () => showMemberDetail('direct'),
                        onPressActive: () => showMemberDetail('activeDirect'),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: UIDefine.getPixelWidth(20),
                      horizontal: UIDefine.getPixelWidth(20)),
                  margin: EdgeInsets.symmetric(
                      vertical: UIDefine.getPixelWidth(10),
                      horizontal: UIDefine.getPixelWidth(10)),
                  decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
                  child: Column(
                    children: [
                      /// B class
                      AllMembersCard(
                        leftTitle: tr('indirect'),
                        leftValue: teamMembers.indirect.toString(),
                        rightTitle: tr('activeIndirect'),
                        rightValue: teamMembers.activeIndirect.toString(),
                        onPressAll: () => showMemberDetail('indirect'),
                        onPressActive: () => showMemberDetail('activeIndirect'),
                      ),

                      SizedBox(height: UIDefine.getPixelWidth(30)),

                      /// C class
                      AllMembersCard(
                        leftTitle: tr('third'),
                        leftValue: teamMembers.third.toString(),
                        rightTitle: tr('activeThird'),
                        rightValue: teamMembers.activeThird.toString(),
                        onPressAll: () => showMemberDetail('third'),
                        onPressActive: () => showMemberDetail('activeThird'),
                      ),
                    ],
                  ),
                )
              ]))),
    );
  }

  void showMemberDetail(String type) {
    ControlRouterViewModel().pushPage(
        context,
        TeamMemberDetailPage(
            startTime: startDate, endTime: endDate, type: type));
  }
}
