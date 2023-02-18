import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/http/api/mission_api.dart';
import '../../../models/http/parameter/point_record_data.dart';
import '../../../utils/app_shared_Preferences.dart';
import '../../base_list_provider.dart';

final levelPointRecordListProvider = StateNotifierProvider.autoDispose<
    LevelPointRecordListNotifier, List<PointRecordData>>((ref) {
  return LevelPointRecordListNotifier();
});

class LevelPointRecordListNotifier extends StateNotifier<List<PointRecordData>>
    with BaseListProvider {
  LevelPointRecordListNotifier() : super([]);

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey());
    if (json != null) {
      List<PointRecordData> list = List<PointRecordData>.from(
          json.map((x) => PointRecordData.fromJson(x)));
      state = list;
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

  Future<List> loadData(
      {required int page,
      required int size,
      required String startDate,
      required String endDate,
      required bool needSave}) async {
    List<PointRecordData> list = await MissionAPI().getPointRecord(
        page: page, size: size, startDate: startDate, endDate: endDate);

    if (needSave) {
      setSharedPreferencesValue(list);
    }
    return list;
  }

  @override
  void addList(List data) {
    state = [...state, ...data as List<PointRecordData>];
  }

  @override
  void clearList() {
    state = <PointRecordData>[];
  }
}
