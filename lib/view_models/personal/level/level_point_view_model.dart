import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/mission_api.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/date_picker/custom_date_picker.dart';
import 'package:treasure_nft_project/widgets/label/background_with_land.dart';
import 'package:treasure_nft_project/widgets/list_view/mission/point_record_item_widget.dart';

class LevelPointViewModel extends BaseListViewModel {
  LevelPointViewModel(
      {required this.context,
      required super.onListChange,
      super.hasTopView = true,
      super.padding});

  String startDate = '';
  String endDate = '';
  Search currentType = Search.Today;
  BuildContext context;

  void initState() {
    startDate = DateFormatUtil().getTimeWithDayFormat();
    endDate = DateFormatUtil().getTimeWithDayFormat();
    initListView();
  }

  @override
  Widget itemView(int index, data) {
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
  Future<List> loadData(int page, int size) {
    return MissionAPI().getPointRecord(
        page: page, size: size, startDate: startDate, endDate: endDate);
  }

  @override
  Widget buildSeparatorView(BuildContext context, int index) {
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
  Widget buildTopView() {
    return Column(
      children: [
        BackgroundWithLand(
            mainHeight: 230,
            bottomHeight: 100,
            onBackPress: () => popPage(context),
            body: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
              padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
              decoration: AppStyle().styleNewUserSetting(),
              child: PersonalNewSubUserInfoView(
                  enablePoint: false,
                  showId: false,
                  userLevelInfo: GlobalData.userLevelInfo),
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
    if (this.startDate != startDate || this.endDate != endDate) {
      this.startDate = startDate;
      this.endDate = endDate;
      initListView();
    }
  }

  void _onTypeCallBack(Search type) {
    currentType = type;
  }
}
