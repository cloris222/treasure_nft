import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_list_data.dart';
import 'package:treasure_nft_project/models/http/parameter/team_members.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/home/widget/search_action_button.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/list_view/team/team_contribute_listview.dart';

import '../../../widgets/app_bottom_center_button.dart';


///MARK:團隊貢獻
class TeamContributionPage extends StatelessWidget {
  const TeamContributionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('teamContribution')),
      body: const Body(),
      bottomNavigationBar:
      const AppBottomNavigationBar(initType: AppNavigationBarType.typePersonal),
      floatingActionButton: const AppBottomCenterButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
  TeamContribute teamContribute = TeamContribute();
  List<TeamContributeList> teamContributeList = [];

  @override
  void initState() {
    super.initState();
    viewModel.getContribute('', '').then((value) => {
      teamContribute = value,
      setState(() {}),
    });

    viewModel.getContributeList('', '').then((value) => {
      teamContributeList = value,
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

            child: Column(children: [
              viewModel.getPadding(3),

              /// 日期選擇器
              GestureDetector(
                  onTap: () async {
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


                    child: Row(children: [
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
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          SearchActionButton(
                            isSelect: buttonType == Search.All,
                            btnText: '  ${tr('all')}  ',
                            onPressed: () async {
                              buttonType = Search.All;
                              startDate = ''; endDate = '';
                              await viewModel.getContribute('', '').then((
                                  value) => {teamContribute = value,});

                              await viewModel.getContributeList('', '').then((
                                  value) => {teamContributeList = value,});
                              setState(() {});
                            },
                          ),

                          viewModel.getPadding(2),

                          SearchActionButton(
                            isSelect: buttonType == Search.Today,
                            btnText: tr('today'),
                            onPressed: () async {
                              buttonType = Search.Today;

                              startDate =
                                  viewModel.dateTimeFormat(DateTime.now());
                              endDate =
                                  viewModel.dateTimeFormat(DateTime.now());
                              await viewModel.getContribute(
                                startDate, endDate,).then((value) => {
                                teamContribute = value,
                              });
                              await viewModel.getContributeList(
                                  startDate, endDate).then((value) => {
                                teamContributeList = value
                              });
                              setState(() {});
                            },
                          ),

                          viewModel.getPadding(2),

                          SearchActionButton(
                            isSelect: buttonType == Search.Yesterday,
                            btnText: tr('yesterday'),
                            onPressed: () async {
                              buttonType = Search.Yesterday;

                              startDate = viewModel.getDays(1);
                              endDate = viewModel.getDays(1);
                              await viewModel.getContribute(
                                  startDate, endDate
                              ).then((value) => {teamContribute = value,
                              });
                              await viewModel.getContributeList(
                                  startDate, endDate).then((value) => {
                                teamContributeList = value
                              });
                              setState(() {});
                            },
                          ),

                          viewModel.getPadding(2),

                          SearchActionButton(
                            isSelect: buttonType == Search.SevenDays,
                            btnText: tr('day7'),
                            onPressed: () async {
                              buttonType = Search.SevenDays;

                              startDate = viewModel.getDays(7);
                              endDate =
                                  viewModel.dateTimeFormat(DateTime.now());
                              await viewModel.getContribute(
                                startDate, endDate,).then((value) => {
                                teamContribute = value,
                              });
                              await viewModel.getContributeList(
                                  startDate, endDate).then((value) => {
                                teamContributeList = value
                              });
                              setState(() {});
                            },
                          ),

                          viewModel.getPadding(2),

                          SearchActionButton(
                            isSelect: buttonType == Search.ThirtyDays,
                            btnText: tr('day30'),
                            onPressed: () async {
                              buttonType = Search.ThirtyDays;

                              startDate = viewModel.getDays(30);
                              endDate =
                                  viewModel.dateTimeFormat(DateTime.now());
                              await viewModel.getContribute(
                                startDate, endDate,).then((value) => {
                                teamContribute = value,
                              });
                              await viewModel.getContributeList(
                                  startDate, endDate).then((value) => {
                                teamContributeList = value
                              });
                              setState(() {});
                            },
                          ),
                        ],))),

              /// 獎勵框
              Container(
                padding: EdgeInsets.all(UIDefine.getScreenWidth(7)),
                decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.datePickerBorder,
                        width: 3
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// 總獎勵
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tr('reward_total'),
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: UIDefine.fontSize12,
                              ),
                            ),

                            viewModel.getPadding(1),

                            Row(children: [
                              viewModel.getCoinImage(),

                              viewModel.getPadding(0.5),
                              Text(teamContribute.teamShare.toString(),
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: UIDefine.fontSize14,
                                ),
                              ),
                            ]),
                          ],),



                        /// A級獎勵
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: UIDefine.getScreenWidth(30),
                              child:Text(tr('directShare-extra'),
                                style: TextStyle(
                                  color: AppColors.textGrey,
                                  fontSize: UIDefine.fontSize12,
                                ),
                              ),
                            ),
                            viewModel.getPadding(1),
                            Row(children: [
                              viewModel.getCoinImage(),

                              viewModel.getPadding(0.5),

                              Text(teamContribute.directShare.toString(),
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: UIDefine.fontSize14,
                                ),
                              ),
                            ]),
                          ],),
                      ],),

                    viewModel.getPadding(3),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// B級獎勵
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: UIDefine.getScreenWidth(30),
                                child:Text(tr('indirectShare-extra'),
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: UIDefine.fontSize12,
                                  ),
                                ),
                              ),
                              viewModel.getPadding(1),
                              Row(children: [
                                viewModel.getCoinImage(),

                                viewModel.getPadding(0.5),
                                Text(teamContribute.indirectShare.toString(),
                                  style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: UIDefine.fontSize14,
                                  ),
                                ),
                              ]),
                            ],
                          ),


                          /// C級獎勵
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: UIDefine.getScreenWidth(30),
                                child:Text(tr('thirdShare-extra'),
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: UIDefine.fontSize12,
                                  ),
                                ),
                              ),
                              viewModel.getPadding(1),
                              Row(children: [
                                viewModel.getCoinImage(),

                                viewModel.getPadding(0.5),

                                Text(teamContribute.thirdShare.toString(),
                                  style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: UIDefine.fontSize14,
                                  ),
                                ),
                              ]),
                            ],),
                        ]),
                  ],),
              ),

              /// A級會員列表
              Container(
                padding: EdgeInsets.all(UIDefine.getScreenWidth(3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr('direct'),
                      style:TextStyle(
                          fontSize: UIDefine.fontSize14
                      ),
                    ),

                    viewModel.getPadding(1),

                    SizedBox(
                      width: UIDefine.getScreenWidth(25),
                      child:Text(tr('bonus'),
                        style:TextStyle(
                            fontSize: UIDefine.fontSize14
                        ),
                      ),
                    ),

                  ],),
              ),

              TeamContributeListView(
                list: teamContributeList,
              ),

            ],)));
  }

  Future<void> _showDatePicker(BuildContext context) async {
    await showDateRangePicker(
        context: context,
        firstDate: DateTime(2022, 10),
        lastDate: DateTime.now()).then((value) =>
    {
      startDate = viewModel.dateTimeFormat(value?.start),
      endDate = viewModel.dateTimeFormat(value?.end),
    }).then((value) async =>
    {
      await viewModel.getContribute(startDate, endDate).then((value) =>
      {
        teamContribute = value,
        setState(() {}),
      }),
    });
    debugPrint('startDate: $startDate');
  }

}
