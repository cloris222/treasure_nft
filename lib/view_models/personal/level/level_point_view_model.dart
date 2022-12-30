import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/models/http/api/mission_api.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/date_picker/custom_date_picker.dart';
import 'package:treasure_nft_project/widgets/list_view/mission/point_record_item_widget.dart';

class LevelPointViewModel extends BaseListViewModel {
  LevelPointViewModel({required super.onListChange, super.hasTopView = true,super.padding});

  String startDate = '';
  String endDate = '';
  Search currentType = Search.Today;

  void initState() {
    startDate = DateFormatUtil().getTimeWithDayFormat();
    endDate = DateFormatUtil().getTimeWithDayFormat();
    initListView();
  }

  @override
  Widget itemView(int index, data) {
    return PointRecordItemWidget(record: data);
  }

  @override
  Future<List> loadData(int page, int size) {
    return MissionAPI().getPointRecord(
        page: page, size: size, startDate: startDate, endDate: endDate);
  }

  @override
  Widget buildTopView() {
    return Column(
      children: [
        TitleAppBar(title: tr('pointRecord')),
        const PersonalSubUserInfoView(enablePoint: false),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        )
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
