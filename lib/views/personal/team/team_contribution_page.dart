import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_contribution_info_provider.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/team/team_contribution_member_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/date_picker/custom_date_picker.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';

import '../../../models/http/parameter/team_contribute_data.dart';
import '../../../widgets/slider_page_view.dart';
import 'team_main_style.dart';

///MARK:團隊貢獻
class TeamContributionPage extends ConsumerStatefulWidget {
  const TeamContributionPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TeamContributionPageState();
}

class _TeamContributionPageState extends ConsumerState<TeamContributionPage> {
  TeamMainStyle style = TeamMainStyle();
  String startTime = '';
  String endTime = '';

  ///MARK: direct:A級會員, indirect:B級會員, third:C級會員, totalUser:全部會員
  String type = 'direct';

  TeamContribute get teamContribute {
    return ref.read(teamContributionInfoProviderProvider);
  }

  @override
  void initState() {
    ref
        .read(teamContributionInfoProviderProvider.notifier)
        .setDate(startDate: '', endDate: '');
    ref.read(teamContributionInfoProviderProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(teamContributionInfoProviderProvider);

    return CustomAppbarView(
      needScrollView: false,
      type: AppNavigationBarType.typePersonal,
      body: _buildBody(),
      backgroundColor: AppColors.defaultBackgroundSpace,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Widget _buildBody() {
    List<String> titles = [
      'A${tr('levelMember')}',
      'B${tr('levelMember')}',
      'C${tr('levelMember')}',
    ];
    return SliderPageView(
        backgroundColor: AppColors.defaultBackgroundSpace,
        buttonDecoration: AppStyle().styleColorsRadiusBackground(
            hasBottomRight: false, hasBottomLef: false),
        titles: titles,
        initialPage: 0,
        topView: _buildTopView(),
        children: [
          TeamContributionMemberView(
              startTime: startTime, endTime: endTime, type: 'A'),
          TeamContributionMemberView(
              startTime: startTime, endTime: endTime, type: 'B'),
          TeamContributionMemberView(
              startTime: startTime, endTime: endTime, type: 'C'),
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
            CustomDatePickerWidget(dateCallback: _onDateCallback),
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
              _buildInfo(tr('totalCommission'), teamContribute.teamShare),

              /// A級獎勵
              _buildInfo(tr('A-antiCommission\''), teamContribute.directShare),
            ]),
            style.getPadding(3),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              /// B級獎勵
              _buildInfo(
                  tr('B-antiCommission\''), teamContribute.indirectShare),

              /// C級獎勵
              _buildInfo(tr('C-antiCommission\''), teamContribute.thirdShare),
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
            TetherCoinWidget(size: UIDefine.getPixelWidth(14)),
            style.getPadding(0.5),
            Text(NumberFormatUtil().removeTwoPointFormat(value),
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack,
                    fontSize: UIDefine.fontSize16,
                    fontWeight: FontWeight.w600))
          ],
        ),
        style.getPadding(1),
        Text(title,
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textSixBlack,
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w400)),
      ]),
    );
  }

  void _onDateCallback(String startDate, String endDate) {
    if (startDate.compareTo(startTime) != 0 ||
        endDate.compareTo(endTime) != 0) {
      ref
          .read(teamContributionInfoProviderProvider.notifier)
          .setDate(startDate: startDate, endDate: endDate);
      ref.read(teamContributionInfoProviderProvider.notifier).update();
      setState(() {
        startTime = startDate;
        endTime = endDate;
      });
    }
  }
}
