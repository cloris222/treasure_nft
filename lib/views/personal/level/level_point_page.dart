import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../../constant/enum/team_enum.dart';
import '../../../constant/theme/app_style.dart';
import '../../../models/http/api/mission_api.dart';
import '../../../models/http/parameter/point_record_data.dart';
import '../../../view_models/control_router_viem_model.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';
import '../../../widgets/label/background_with_land.dart';
import '../../../widgets/list_view/base_list_interface.dart';
import '../../../widgets/list_view/mission/point_record_item_widget.dart';
import '../personal_new_sub_user_info_view.dart';

///MARK: 積分紀錄
class LevelPointPage extends ConsumerStatefulWidget {
  const LevelPointPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LevelPointPageState();
}

class _LevelPointPageState extends ConsumerState<LevelPointPage>
    with BaseListInterface {
  Search currentType = Search.Today;
  String startDate = '';
  String endDate = '';

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///MARK: 建立畫面
    return CustomAppbarView(
      needCover: true,
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: _buildBody(),
      type: AppNavigationBarType.typePersonal,
    );
  }

  Widget _buildBody() {
    return Container(
        color: AppColors.defaultBackgroundSpace,
        child: buildListView(
            padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding)));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    bool isEnd = false;
    if (currentItems.isNotEmpty) {
      isEnd = (currentItems.length - 1 == index);
    }
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: UIDefine.getPixelWidth(20),
            vertical: UIDefine.getPixelWidth(10)),
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
        decoration: AppStyle().styleColorsRadiusBackground(
            radius: 8,
            hasTopLeft: false,
            hasTopRight: false,
            hasBottomRight: isEnd,
            hasBottomLef: isEnd),
        child: PointRecordItemWidget(record: data));
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return buildLine();
  }

  Widget buildLine() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
          height: UIDefine.getPixelWidth(0.5),
          width: UIDefine.getWidth(),
          color: AppColors.lineBarGrey,
        ));
  }

  @override
  Widget? buildTopView() {
    return Column(
      children: [
        BackgroundWithLand(
            mainHeight: 230,
            bottomHeight: 100,
            onBackPress: () => ControlRouterViewModel().popPage(context),
            body: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
              padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
              decoration: AppStyle().styleNewUserSetting(),
              child: const PersonalNewSubUserInfoView(
                  enablePoint: false, showId: false),
            )),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: UIDefine.getPixelWidth(20),
              vertical: UIDefine.getPixelWidth(10)),
          margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
          decoration: AppStyle().styleColorsRadiusBackground(
              radius: 8, hasBottomLef: false, hasBottomRight: false),
          child: CustomDatePickerWidget(
            typeCallback: _onTypeCallBack,
            dateCallback: _onDataCallBack,
            typeList: const [
              Search.Today,
              Search.Yesterday,
              Search.ThisWeek,
              Search.ThisMonth
            ],
            initType: currentType,
          ),
        ),
        buildLine()
      ],
    );
  }

  void _onDataCallBack(String startDate, String endDate) {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      if (this.startDate != startDate || this.endDate != endDate) {
        this.startDate = startDate;
        this.endDate = endDate;
        reloadListView();
      }
    });
  }

  void _onTypeCallBack(Search type) {
    currentType = type;
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await MissionAPI().getPointRecord(
        page: page, size: size, startDate: startDate, endDate: endDate);
  }

  @override
  bool needSave(int page) {
    return page == 1 && currentType == Search.Today;
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  String setKey() {
    return "levelPointRecord";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return PointRecordData.fromJson(json);
  }
}
