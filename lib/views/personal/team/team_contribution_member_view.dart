import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../../constant/ui_define.dart';
import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/team_contribute_list_data.dart';
import '../../../widgets/list_view/team/team_contribute_item.dart';

class TeamContributionMemberView extends StatefulWidget {
  const TeamContributionMemberView(
      {Key? key,
      required this.type,
      required this.startTime,
      required this.endTime})
      : super(key: key);
  final String type;
  final String startTime;
  final String endTime;

  @override
  State<TeamContributionMemberView> createState() =>
      _TeamContributionMemberViewState();
}

class _TeamContributionMemberViewState extends State<TeamContributionMemberView>
    with BaseListInterface {
  String get type {
    return widget.type;
  }

  String get startTime {
    return widget.startTime;
  }

  String get endTime {
    return widget.endTime;
  }

  @override
  void didUpdateWidget(covariant TeamContributionMemberView oldWidget) {
    ///MARK: 代表數值有更動
    if (oldWidget.endTime.compareTo(widget.endTime) != 0 ||
        oldWidget.startTime.compareTo(widget.startTime) != 0) {
      initListView();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (widget.endTime.isEmpty && widget.startTime.isEmpty) {
      init();
    } else {
      initListView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
      child: Column(children: [
        _buildTitle(),
        SizedBox(height: UIDefine.getPixelWidth(15)),
        Expanded(
            child: buildListView(
                padding:
                    EdgeInsets.only(bottom: UIDefine.navigationBarPadding))),
      ]),
    );
  }

  Widget _buildTitle() {
    /// A級會員列表
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        flex: 2,
        child: Text(
          '$type${tr('levelMember')}',
          textAlign: TextAlign.start,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w400,
              color: AppColors.textThreeBlack),
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(
          tr('bonus'),
          textAlign: TextAlign.start,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w400,
              color: AppColors.textThreeBlack),
        ),
      )
    ]);
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return TeamContributeItemView(serialNumber: index + 1, itemData: data);
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return const Divider(height: 0.5, color: Color(0xFFE1E1E1));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return TeamContributeList.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) {
    String apiType = '';
    switch (type) {
      case 'A':
        {
          apiType = 'direct';
        }
        break;
      case 'B':
        {
          apiType = 'indirect';
        }
        break;
      case 'C':
        {
          apiType = 'third';
        }
        break;
    }

    return GroupAPI().getContributeList(
        page: page,
        size: size,
        type: apiType,
        startTime: BaseViewModel().getStartTime(startTime),
        endTime: BaseViewModel().getEndTime(endTime));
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool needSave(int page) {
    return startTime.isEmpty && endTime.isEmpty && page == 1;
  }

  @override
  String setKey() {
    return "teamContributionMembers_$type";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
