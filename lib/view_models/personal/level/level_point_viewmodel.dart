import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/api/mission_api.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';

class LevelPointViewModel extends BaseListViewModel {
  LevelPointViewModel({required super.onListChange});

  String startDate = '';
  String endDate = '';

  @override
  Widget itemView(int index, data) {
    return Container();
  }

  @override
  Future<List> loadData(int page, int size) {
    return MissionAPI().getPointRecord(startDate: startDate, endDate: endDate);
  }

  void onDataCallBack(String startDate, String endDate) {}
}
