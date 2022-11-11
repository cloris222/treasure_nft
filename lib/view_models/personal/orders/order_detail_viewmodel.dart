import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/order_api.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';
import 'package:treasure_nft_project/widgets/card/item_info_card.dart';

import '../../../models/http/parameter/user_property.dart';
import '../../../widgets/card/data/card_showing_data.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';
import '../../base_view_model.dart';

class OrderDetailViewModel extends BaseListViewModel {
  OrderDetailViewModel({
    required super.onListChange,
    this.type = EarningIncomeType.ALL,
    super.hasTopView = true,
  });

  double income = GlobalData.totalIncome ?? 0;
  EarningIncomeType type;
  String startDate = '';
  String endDate = '';
  Search? currentType;

  Future<void> initState() async {

    /// 拿完總收入後馬上更新並建立畫面
    OrderAPI().saveTempTotalIncome().then((value) {
      income = value;
      onListChange();
    });
    initListView();
  }

  @override
  Widget itemView(int index, data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ItemInfoCard(
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
      String nickName, String orderNo, double income, num rebate) {
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
    return CustomDatePickerWidget(
      dateCallback: _callback,
      typeCallback: _callType,
      initType: currentType,
      typeList: const [
        Search.Today,
        Search.Yesterday,
        Search.SevenDays,
        Search.ThirtyDays
      ],
    );
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
