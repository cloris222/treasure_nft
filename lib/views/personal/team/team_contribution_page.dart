import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/team/team_contribution_member_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/date_picker/custom_date_picker.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../view_models/personal/team/team_contribution_viewmodel.dart';
import '../../../widgets/slider_page_view.dart';

///MARK:團隊貢獻
class TeamContributionPage extends StatefulWidget {
  const TeamContributionPage({Key? key}) : super(key: key);

  @override
  State<TeamContributionPage> createState() => _TeamContributionPageState();
}

class _TeamContributionPageState extends State<TeamContributionPage> {
  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      type: AppNavigationBarType.typePersonal,
      body: Body(),
      backgroundColor: AppColors.defaultBackgroundSpace,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
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
    viewModel = TeamContributionViewModel(
        onListChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding));
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderPageView(
        backgroundColor: AppColors.defaultBackgroundSpace,
        buttonDecoration: AppStyle().styleColorsRadiusBackground(
            hasBottomRight: false, hasBottomLef: false),
        titles: titles,
        initialPage: 0,
        topView: _buildTopView(),
        onPageListener: _onChangeView,
        children: [
          TeamContributionMemberView(viewModel: viewModel, type: 'A'),
          TeamContributionMemberView(viewModel: viewModel, type: 'B'),
          TeamContributionMemberView(viewModel: viewModel, type: 'C'),
        ]);
  }

  Widget _buildTopView() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: EdgeInsets.only(
            left: UIDefine.getPixelWidth(20),
            right: UIDefine.getPixelWidth(20),
            bottom: UIDefine.getPixelWidth(20)),
        color: Colors.white,
        child: Column(
          children: [
            const TitleAppBar(title: ''),

            /// 日期選擇器 & 按鈕
            CustomDatePickerWidget(dateCallback: viewModel.onDataCallBack),
          ],
        ),
      ),

      /// 獎勵框
      Container(
          padding: EdgeInsets.symmetric(
              vertical: UIDefine.getPixelWidth(20),
              horizontal: UIDefine.getPixelWidth(20)),
          margin: EdgeInsets.symmetric(
              vertical: UIDefine.getPixelWidth(10),
              horizontal: UIDefine.getPixelWidth(10)),
          decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              /// 總獎勵
              _buildInfo(
                  tr('totalCommission'), viewModel.teamContribute.teamShare),

              /// A級獎勵
              _buildInfo(tr('A-antiCommission\''),
                  viewModel.teamContribute.directShare),
            ]),
            memberViewModel.getPadding(3),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              /// B級獎勵
              _buildInfo(tr('B-antiCommission\''),
                  viewModel.teamContribute.indirectShare),

              /// C級獎勵
              _buildInfo(tr('C-antiCommission\''),
                  viewModel.teamContribute.thirdShare),
            ])
          ]))
    ]);
  }

  Widget _buildInfo(String title, dynamic value) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            memberViewModel.getCoinImage(),
            memberViewModel.getPadding(0.5),
            Text(NumberFormatUtil().removeTwoPointFormat(value),
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack,
                    fontSize: UIDefine.fontSize16,
                    fontWeight: FontWeight.w600))
          ],
        ),
        memberViewModel.getPadding(1),
        Text(title,
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textSixBlack,
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w400)),
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
