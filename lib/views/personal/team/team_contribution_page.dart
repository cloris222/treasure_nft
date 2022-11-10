import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/team/team_contribution_member_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/date_picker/custom_date_picker.dart';

import '../../../view_models/personal/team/team_contribution_viewmodel.dart';
import '../../../widgets/slider_page_view.dart';

///MARK:團隊貢獻
class TeamContributionPage extends StatelessWidget {
  const TeamContributionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      title: tr("teamContribution"),
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
  TeamMemberViewModel memberViewModel = TeamMemberViewModel();
  late TeamContributionViewModel viewModel;

  List<String> titles = [
    'A${tr('levelMember')}',
    'B${tr('levelMember')}',
    'C${tr('levelMember')}',
  ];

  @override
  void initState() {
    super.initState();
    viewModel = TeamContributionViewModel(onListChange: () {
      if (mounted) {
        setState(() {});
      }
    });
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderPageView(
        titles: titles,
        initialPage: 0,
        topView: _buildTopView(),
        getPageIndex: _onChangeView,
        children: [
          TeamContributionMemberView(viewModel: viewModel, type: 'A'),
          TeamContributionMemberView(viewModel: viewModel, type: 'B'),
          TeamContributionMemberView(viewModel: viewModel, type: 'C'),
        ]);
  }

  Widget _buildTopView() {
    return Padding(
        padding: EdgeInsets.only(
            left: UIDefine.getScreenWidth(6),
            right: UIDefine.getScreenWidth(6)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          memberViewModel.getPadding(2),

          /// 日期選擇器 & 按鈕
          CustomDatePickerWidget(dateCallback: viewModel.onDataCallBack),
          memberViewModel.getPadding(3),

          /// 獎勵框
          Container(
              padding: EdgeInsets.all(UIDefine.getScreenWidth(7)),
              decoration: BoxDecoration(
                  color: AppColors.textWhite,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.datePickerBorder, width: 3)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 總獎勵
                          _buildInfo(tr('totalCommission'),
                              viewModel.teamContribute.teamShare),

                          /// A級獎勵
                          _buildInfo(tr('A-antiCommission\''),
                              viewModel.teamContribute.directShare),
                        ]),
                    memberViewModel.getPadding(3),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// B級獎勵
                          _buildInfo(tr('B-antiCommission\''),
                              viewModel.teamContribute.indirectShare),

                          /// C級獎勵
                          _buildInfo(tr('C-antiCommission\''),
                              viewModel.teamContribute.thirdShare),
                        ])
                  ]))
        ]));
  }

  Widget _buildInfo(String title, dynamic value) {
    return Flexible(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(
                color: AppColors.textGrey, fontSize: UIDefine.fontSize12)),
        memberViewModel.getPadding(1),
        Row(children: [
          memberViewModel.getCoinImage(),
          memberViewModel.getPadding(0.5),
          Text(NumberFormatUtil().removeTwoPointFormat(value),
              style: TextStyle(
                  color: AppColors.textBlack, fontSize: UIDefine.fontSize14))
        ])
      ]),
    );
  }

  void _onChangeView(int value) {
    String type = '';
    switch (value) {
      case 0:
        {
          type = 'direct';
        }
        break;
      case 1:
        {
          type = 'indirect';
        }
        break;
      case 2:
        {
          type = 'third';
        }
        break;
    }
    if (type != viewModel.type) {
      viewModel.type = type;
      viewModel.initListView();
    }
  }
}
