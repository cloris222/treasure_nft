import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/order_api.dart';
import 'package:treasure_nft_project/utils/app_shared_Preferences.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';
import 'package:treasure_nft_project/widgets/card/item_info_card.dart';
import 'package:treasure_nft_project/widgets/card/saves_info_card.dart';

import '../../../widgets/card/data/card_showing_data.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';

class OrderDetailViewModel extends BaseListViewModel {
  OrderDetailViewModel(
      {required super.onListChange,
      this.type = EarningIncomeType.ALL,
      super.hasTopView = true,
      super.padding});

  double income = GlobalData.totalIncome ?? 0;
  EarningIncomeType type;
  String startDate = '';
  String endDate = '';
  Search? currentType;

  Future<void> initState() async {
    ///MARK: 載入預讀
    if (type == EarningIncomeType.ALL && startDate.isEmpty && endDate.isEmpty) {
      reloadItems = await AppSharedPreferences.getProfitRecord();
    } else {
      reloadItems = [];
    }
    OrderAPI().saveTempTotalIncome(type: type).then((value) {
      income = value;
      onListChange();
    });
    initListView();
  }

  @override
  Widget itemView(int index, data) {
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
              dateTime: changeTimeZone(data.time),
              imageUrl: data.imgUrl,
              price: data.price.toString(),
              bShowPriceAtEnd: true,
              dataList: _getItemData(
                  data.sellerName, data.orderNo, data.income, data.rebate),
            ),
          );
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await OrderAPI().getEarningData(
        page: page,
        size: size,
        startDate: getStartTime(startDate),
        endDate: getEndTime(endDate),
        type: type);
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
    data.title = tr("nickname");
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
  Widget buildTopView() {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: AppColors.textWhite,
        ),
        child: CustomDatePickerWidget(
          dateCallback: _callback,
          typeCallback: _callType,
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

  void _callback(String startDate, String endDate) {
    /// 判斷與當前顯示日期不同在進行畫面更新
    if (this.startDate != startDate || this.endDate != endDate) {
      this.startDate = startDate;
      this.endDate = endDate;
      initState();
    }
  }

  void _callType(Search type) {
    currentType = type;
  }
}
