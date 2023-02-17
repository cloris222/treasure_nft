import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../../view_models/personal/team/team_member_detail_provider.dart';
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
    super.initState();
    ref.read(teamMemberDetailProvider(type).notifier).init(onFinish: () {
      initListView();
    });
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
  List getCurrentList() {
    return ref.watch(teamMemberDetailProvider(type));
  }

  @override
  Future<List> loadData(int page, int size) async {
    return ref.read(teamMemberDetailProvider(type).notifier).loadData(
        page: page,
        size: size,
        startTime: startTime,
        endTime: endTime,
        needSave: needSave(page, size));
  }

  bool needSave(int page, int size) {
    return page == 1 && startTime.isEmpty && endTime.isEmpty;
  }

  @override
  void addCurrentList(List data) {
    ref.read(teamMemberDetailProvider(type).notifier).addList(data);
  }

  @override
  void clearCurrentList() {
    ref.read(teamMemberDetailProvider(type).notifier).clearList();
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }
}
