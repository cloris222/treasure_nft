import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/api/mission_api.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';

import '../../../constant/enum/team_enum.dart';
import '../../../utils/date_format_util.dart';
import '../../../views/personal/personal_sub_user_info_view.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';
import '../../../widgets/label/mission/point_record_item_widget.dart';

class LevelPointViewModel extends BaseListViewModel {
  LevelPointViewModel({required super.onListChange, super.hasTopView = true});

  String startDate = '';
  String endDate = '';

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
        const PersonalSubUserInfoView(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomDatePickerWidget(
            dateCallback: onDataCallBack,
            typeList: const [
              Search.Today,
              Search.Yesterday,
              Search.SevenDays,
              Search.ThirtyDays
            ],
            initType: Search.Today,
          ),
        )
      ],
    );
  }

  void onDataCallBack(String startDate, String endDate) {
    if (this.startDate != startDate || this.endDate != endDate) {
      this.startDate = startDate;
      this.endDate = endDate;
      initListView();
    }
  }
}
