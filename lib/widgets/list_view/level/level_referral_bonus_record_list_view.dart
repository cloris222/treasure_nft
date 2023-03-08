import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/models/http/api/level_api.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/bonus_referral_record_data.dart';
import '../../../utils/date_format_util.dart';
import '../../label/gradually_network_image.dart';

///MARK: 推廣儲金罐紀錄
class LevelReferralBonusRecordListView extends StatefulWidget {
  const LevelReferralBonusRecordListView(
      {Key? key, required this.startTime, required this.endTime})
      : super(key: key);
  final String startTime;
  final String endTime;

  @override
  State<LevelReferralBonusRecordListView> createState() =>
      _LevelReferralBonusRecordListViewState();
}

class _LevelReferralBonusRecordListViewState
    extends State<LevelReferralBonusRecordListView> with BaseListInterface {
  @override
  void didUpdateWidget(covariant LevelReferralBonusRecordListView oldWidget) {
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
    ));
  }

  @override
  Widget buildItemBuilder(int index, data) {
    BonusReferralRecordData record = data;

    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(record.itemName),
              Spacer(),
              Text(record.getLevelOrder())
            ],
          ),
          Text(DateFormatUtil().getFullWithDateFormat(record.createdAt)),
          Row(
            children: [
              GraduallyNetworkImage(
                imageUrl: record.imgUrl,
                width: UIDefine.getPixelWidth(80),
                height: UIDefine.getPixelWidth(80),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getPixelWidth(15));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return BonusReferralRecordData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await LevelAPI().getBonusReferralRecord(
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
    return 'levelReferralBonusRecord';
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
