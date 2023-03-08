import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/bonus_trade_record_data.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../../constant/ui_define.dart';
import '../../../models/http/api/level_api.dart';

class LevelTradeBonusRecordListView extends StatefulWidget {
  const LevelTradeBonusRecordListView(
      {Key? key, required this.startTime, required this.endTime})
      : super(key: key);
  final String startTime;
  final String endTime;

  @override
  State<LevelTradeBonusRecordListView> createState() =>
      _LevelTradeBonusRecordListViewState();
}

class _LevelTradeBonusRecordListViewState
    extends State<LevelTradeBonusRecordListView> with BaseListInterface {
  @override
  void didUpdateWidget(covariant LevelTradeBonusRecordListView oldWidget) {
    ///MARK: 代表數值有更動
    if (oldWidget.endTime.compareTo(widget.endTime) != 0 &&
        oldWidget.startTime.compareTo(widget.startTime) != 0) {
      initListView();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView(
        padding: EdgeInsets.only(
            top: UIDefine.getScreenWidth(5),
            bottom: UIDefine.navigationBarPadding,
            right: UIDefine.getScreenWidth(5),
            left: UIDefine.getScreenWidth(5)));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    BonusTradeRecordData record = data;

    return Text(record.orderNo);
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return BonusTradeRecordData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await LevelAPI().getBonusTradeRecord(
        page: page,
        size: size,
        startTime: widget.startTime,
        endTime: widget.endTime);
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool needSave(int page) {
    return page == 1 && widget.startTime.isEmpty && widget.endTime.isEmpty;
  }

  @override
  String setKey() {
    return 'levelTradeBonusRecord';
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
