import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../../models/http/api/group_api.dart';
import '../../../models/http/parameter/team_member_detail.dart';
import '../../../widgets/appbar/title_app_bar.dart';
import '../../../widgets/list_view/base_list_interface.dart';
import '../../../widgets/list_view/team/member_detail_item.dart';
import '../../custom_appbar_view.dart';

///MARK:成員詳細
class TeamMemberDetailPage extends ConsumerStatefulWidget {
  const TeamMemberDetailPage(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.type});

  final String startTime;
  final String endTime;
  final String type;

  @override
  ConsumerState createState() => _TeamMemberDetailPageState();
}

class _TeamMemberDetailPageState extends ConsumerState<TeamMemberDetailPage>
    with BaseListInterface {
  String get startTime {
    return widget.startTime;
  }

  String get endTime {
    return widget.endTime;
  }

  String get type {
    return widget.type;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        needScrollView: false,
        onLanguageChange: () {
          if (mounted) {
            setState(() {});
          }
        },
        type: AppNavigationBarType.typePersonal,
        backgroundColor: AppColors.defaultBackgroundSpace,
        body: buildListView(
            padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding)));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
        child: MemberDetailItemView(itemData: data));
  }

  @override
  Widget? buildTopView() {
    return Column(
      children: [
        Container(
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
            color: Colors.white,
            child: const TitleAppBar(title: '')),
        Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(3))),
      ],
    );
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(3)));
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await GroupAPI().getMemberDetail(
        page: page,
        size: size,
        type: type,
        startTime: startTime,
        endTime: endTime);
  }

  @override
  bool needSave(int page) {
    return page == 1 && startTime.isEmpty && endTime.isEmpty;
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  String setKey() {
    return "teamMemberDetail_$type";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return MemberDetailPageList.fromJson(json);
  }
}
