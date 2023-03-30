import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/enum/team_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/api/order_api.dart';
import '../../../models/http/parameter/check_earning_income.dart';
import '../../../utils/number_format_util.dart';
import '../../../widgets/card/data/card_showing_data.dart';
import '../../../widgets/card/item_info_card.dart';
import '../../../widgets/card/saves_info_card.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';

class OrderDetailInfo extends StatefulWidget {
  const OrderDetailInfo(
      {Key? key,
      required this.type,
      required this.startTime,
      required this.endTime,
      this.currentType,
      required this.dateCallback,
      this.typeCallback})
      : super(key: key);
  final EarningIncomeType type;
  final String startTime;
  final String endTime;
  final Search? currentType;
  final onDateFunction dateCallback;
  final onDateTypeFunction? typeCallback;

  @override
  State<OrderDetailInfo> createState() => _OrderDetailInfoState();
}

class _OrderDetailInfoState extends State<OrderDetailInfo>
    with BaseListInterface {
  EarningIncomeType get type {
    return widget.type;
  }

  String get startTime {
    return widget.startTime;
  }

  String get endTime {
    return widget.endTime;
  }

  Search? get currentType {
    return widget.currentType;
  }

  @override
  void didUpdateWidget(covariant OrderDetailInfo oldWidget) {
    if (oldWidget.startTime.compareTo(startTime) != 0 ||
        oldWidget.endTime.compareTo(endTime) != 0) {
      reloadListView();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView(
        padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding));
  }

  @override
  Widget buildItemBuilder(int index, itemData) {
    CheckEarningIncomeData data = itemData as CheckEarningIncomeData;
    return type == EarningIncomeType.SAVINGS
        ? Container(
            padding: EdgeInsets.only(
                top: 10,
                bottom: index == currentItems.length - 1
                    ? UIDefine.getPixelHeight(130)
                    : 10),
            child: SavesInfoCard(data: data))
        : Container(
            padding: EdgeInsets.only(
                top: 10,
                bottom: index == currentItems.length - 1
                    ? UIDefine.getPixelHeight(130)
                    : 10),
            child: ItemInfoCard(
              drewAt: null,
              itemName: data.itemName,
              dateTime: BaseViewModel().changeTimeZone(data.time),
              imageUrl: data.imgUrl,
              price: data.price.toString(),
              bShowPriceAtEnd: true,
              dataList: _getItemData(
                  data.sellerName, data.orderNo, data.income, data.rebate),
            ),
          );
  }

  List<CardShowingData> _getItemData(
      String nickName, String orderNo, num income, num rebate) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();

    data = CardShowingData();
    data.title = tr("orderNo");
    data.content = orderNo;
    data.bIcon = false;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr("account");
    data.content = nickName;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr(tr('rebate'));
    data.content = '${rebate.toString()}%';
    dataList.add(data);

    data = CardShowingData();
    data.title = tr("income");
    data.content = NumberFormatUtil().removeTwoPointFormat(income);
    dataList.add(data);

    return dataList;
  }

  @override
  Widget? buildTopView() {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: AppColors.textWhite,
        ),
        child: CustomDatePickerWidget(
          dateCallback: widget.dateCallback,
          typeCallback: widget.typeCallback,
          initType: currentType,
          typeList: const [
            Search.All,
            Search.Today,
            Search.Yesterday,
            Search.SevenDays,
            Search.ThirtyDays
          ],
        ));
  }

  @override
  changeDataFromJson(json) {
    return CheckEarningIncomeData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await OrderAPI().getEarningData(
        page: page,
        size: size,
        startDate: BaseViewModel().getStartTime(startTime),
        endDate: BaseViewModel().getStartTime(endTime),
        type: type);
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool needReadSharedPreferencesValue() {
    return startTime.isEmpty && endTime.isEmpty;
  }

  @override
  bool needSave(int page) {
    return page == 1 && startTime.isEmpty && endTime.isEmpty;
  }

  @override
  String setKey() {
    return "orderDetailRecord_${type.name}";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }
}
