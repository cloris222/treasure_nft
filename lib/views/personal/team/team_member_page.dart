import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/home/widget/search_action_button.dart';
import 'package:treasure_nft_project/views/personal/team/widget/all_members_card.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';


///MARK:團隊成員
class TeamMemberPage extends StatelessWidget {
  const TeamMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('teamMember')),
      body: const Body(),
      bottomNavigationBar:
      const AppBottomNavigationBar(initType: AppNavigationBarType.typePersonal),
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

        child:Padding(
            padding: EdgeInsets.only(
                left:UIDefine.getScreenWidth(6),
                right: UIDefine.getScreenWidth(6)),

            child:Column(children: [
              viewModel.getPadding(3),
              /// 日期選擇器
              GestureDetector(
                  onTap: () async{
                    await _showDatePicker(context);
                    setState(() {});
                  },
                  child: Container(
                    width: UIDefine.getWidth(),
                    height: UIDefine.getScreenHeight(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3, color: AppColors.datePickerBorder),
                        borderRadius: BorderRadius.circular(10)),


                    child:Row(children: [
                      viewModel.getPadding(1),
                      Image.asset(AppImagePath.dateIcon),
                      viewModel.getPadding(1),

                      Text(startDate,
                        style: const TextStyle(color: AppColors.textGrey),
                      ),

                      viewModel.getPadding(1),
                      Visibility(
                          visible: endDate != '',
                          child: const Text('～',
                            style: TextStyle(color: AppColors.textGrey),
                          )),
                      viewModel.getPadding(1),

                      Text(endDate,
                        style: const TextStyle(color: AppColors.textGrey),
                      )

                    ],),
                  )),

              viewModel.getPadding(3),

              /// 快速搜尋按鈕列
              SizedBox(
                  height: UIDefine.getScreenHeight(10),
                  child:SingleChildScrollView(
                      scrollDirection:Axis.horizontal,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          SearchActionButton(
                            isSelect: buttonType == Search.All,
                            btnText: '  ${tr('all')}  ',
                            onPressed: () async{
                              buttonType = Search.All;
                              await viewModel.getTeamMembers('', '').then((value)  => {
                                teamMembers = value,
                              });
                              setState(() {});
                            },
                          ),

                          viewModel.getPadding(2),

                          SearchActionButton(
                            isSelect: buttonType == Search.Today,
                            btnText: tr('today'),
                            onPressed: () async{
                              buttonType = Search.Today;
                              await viewModel.getTeamMembers(
                                viewModel.dateTimeFormat(DateTime.now()),
                                viewModel.dateTimeFormat(DateTime.now()),
                              ).then((value)  => {
                                teamMembers = value,
                              });
                              setState(() {});
                            },
                          ),

                          viewModel.getPadding(2),

                          SearchActionButton(
                            isSelect: buttonType == Search.Yesterday,
                            btnText: tr('yesterday'),
                            onPressed: () async{
                              buttonType = Search.Yesterday;
                              await viewModel.getTeamMembers(
                                  viewModel.getDays(1), viewModel.getDays(1)
                              ).then((value)  => {
                                teamMembers = value,
                              });
                              setState(() {});
                            },
                          ),

                          viewModel.getPadding(2),

                          SearchActionButton(
                            isSelect: buttonType == Search.SevenDays,
                            btnText: tr('day7'),
                            onPressed: () async{
                              buttonType = Search.SevenDays;
                              await viewModel.getTeamMembers(
                                viewModel.getDays(7),
                                viewModel.dateTimeFormat(DateTime.now()),
                              ).then((value)  => {
                                teamMembers = value,
                              });
                              setState(() {});
                            },
                          ),

                          viewModel.getPadding(2),

                          SearchActionButton(
                            isSelect: buttonType == Search.ThirtyDays,
                            btnText: tr('day30'),
                            onPressed: () async{
                              buttonType = Search.ThirtyDays;
                              await viewModel.getTeamMembers(
                                viewModel.getDays(30),
                                viewModel.dateTimeFormat(DateTime.now()),
                              ).then((value)  => {
                                teamMembers = value,
                              });
                              setState(() {});
                            },
                          ),
                        ],))),



              /// all members
              Container(
                alignment: Alignment.centerLeft,
                width: UIDefine.getWidth(),
                height: UIDefine.getScreenHeight(10),
                child: Text(tr('AllMembers'),
                  style: TextStyle(fontSize: UIDefine.fontSize14),
                ),
              ),

              /// all
              AllMembersCard(
                leftTitle: tr('AllMember'),
                leftValue: teamMembers.totalUser.toString(),
                rightTitle: tr('allValidMembers'),
                rightValue: teamMembers.totalActive.toString(),
              ),


              viewModel.getPaddingWithView(2,
                const Divider(color: AppColors.datePickerBorder,thickness:1.5),
              ),

              /// A class
              AllMembersCard(
                leftTitle: tr('direct'),
                leftValue: teamMembers.direct.toString(),
                rightTitle: tr('activeDirect'),
                rightValue: teamMembers.activeDirect.toString(),
              ),

              viewModel.getPaddingWithView(2,
                const Divider(color: AppColors.datePickerBorder,thickness:1.5),
              ),

              /// B class
              AllMembersCard(
                leftTitle: tr('indirect'),
                leftValue: teamMembers.indirect.toString(),
                rightTitle: tr('activeIndirect'),
                rightValue: teamMembers.activeIndirect.toString(),
              ),

              viewModel.getPaddingWithView(2,
                const Divider(color: AppColors.datePickerBorder,thickness:1.5),
              ),

              /// C class
              AllMembersCard(
                leftTitle: tr('third'),
                leftValue: teamMembers.third.toString(),
                rightTitle: tr('activeThird'),
                rightValue: teamMembers.activeThird.toString(),
              ),

            ],)));
  }

  Future<void> _showDatePicker(BuildContext context) async{
    await showDateRangePicker(
        context:context,
        firstDate: DateTime(2022, 10),
        lastDate: DateTime.now()).then((value) => {
      startDate = viewModel.dateTimeFormat(value?.start),
      endDate = viewModel.dateTimeFormat(value?.end),
    }).then((value) async => {
      await viewModel.getTeamMembers(startDate, endDate).then((value) => {
        teamMembers = value,
        setState(() {}),
      }),
    });
    debugPrint('startDate: $startDate');
  }

}
