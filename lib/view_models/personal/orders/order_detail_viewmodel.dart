import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/models/http/api/order_api.dart';
import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
import 'package:treasure_nft_project/view_models/base_list_view_model.dart';
import 'package:treasure_nft_project/widgets/card/item_info_card.dart';

import '../../../models/http/parameter/check_earning_income.dart';
import '../../../models/http/parameter/user_property.dart';
import '../../../widgets/card/data/card_showing_data.dart';

class OrderDetailViewModel extends BaseListViewModel {
  OrderDetailViewModel(
      {required super.onListChange, this.type = EarningIncomeType.ALL});

  UserProperty? userProperty;
  double income = 0.0;
  EarningIncomeType type;

  Future<void> initState() async {
    userProperty = await UserInfoAPI().getUserPropertyInfo();
    income = await OrderAPI().getPersonalIncome();
    onListChange();
    initListView();
  }

  @override
  Widget itemView(int index, data) {
    return ItemInfoCard(
      itemName: data.itemName,
      dateTime: data.time.toString(),
      imageUrl: data.imgUrl,
      price: data.price.toString(),
      dataList: _getItemData(data.orderNo, data.sellerName, data.income),
    );
  }

  @override
  Future<List> loadData(int page, int size) async {
    return await OrderAPI().getEarningData(page: page, size: size);
  }

  List<CardShowingData> _getItemData(
      String nickName, String orderNo, double income) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr("orderNo");
    data.content = orderNo;
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr("nickname");
    data.content = nickName;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr("income");
    data.content = income.toString();
    dataList.add(data);

    return dataList;
  }
}
