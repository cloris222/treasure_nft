import 'package:easy_localization/easy_localization.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../../constant/call_back_function.dart';
import '../../../models/http/api/order_api.dart';
import '../../../views/personal/orders/orderinfo/data/order_message_list_response_data.dart';
import '../../../widgets/card/awd_info_card.dart';
import '../../../widgets/card/buyer_seller_info_card.dart';
import '../../../widgets/card/data/card_showing_data.dart';
import '../../../widgets/card/item_info_card.dart';
import '../../../widgets/card/order_info_card.dart';

class OrderInfoPageViewModel extends BaseViewModel {
  OrderInfoPageViewModel({required this.setState});

  final ViewChange setState;
  String currentType = 'BUY';
  String startDate = '';
  String endDate = '';
  List<OrderMessageListResponseData> dataList = [];

  requestAPI(int page, int size, {ResponseErrorFunction? onConnectFail}) async {
    if (currentType.isNotEmpty) {
      await OrderAPI(onConnectFail: onConnectFail)
          .getOrderMessageListResponse(page: page, size: size,
          type: currentType, startTime: startDate, endTime: endDate)
          .then((value) => {_setState(value)} );
    }
  }

  requestAPIForUpdate(int page, int size, {ResponseErrorFunction? onConnectFail}) async {
    if (currentType.isNotEmpty) {
      await OrderAPI(onConnectFail: onConnectFail)
          .getOrderMessageListResponse(page: page, size: size,
          type: currentType, startTime: startDate, endTime: endDate)
          .then((value) => {_update(value)} );
    }
  }

  void _setState(value) {
    setState(() {
      dataList = value;
    });
  }

  void _update(value) {
    setState(() {
      dataList.addAll(value);
    });
  }

  ///TODO: 給定不同的卡牌樣式＆資料
  createItemView(int index) {
    OrderMessageListResponseData data = dataList[index];
    switch(currentType) {
      // case 'ITEM': // 隱藏不做
      //   return ItemInfoCard(itemName: data.itemName, dateTime: BaseViewModel().changeTimeZone(data.createdAt),
      //       imageUrl: data.imgUrl, price: data.price.toString(), dataList: _itemListContent(data), status: data.status);
      // case 'FEE': // 隱藏不做
      //   return ItemInfoCard(itemName: data.itemName, dateTime: BaseViewModel().changeTimeZone(data.time), bShowPriceAtEnd: true,
      //       imageUrl: data.imgUrl, price: data.price.toString(), dataList: _feeListContent(data));
      // case 'TRANSFER_NFT': // 隱藏不做
      //   return ItemInfoCard(itemName: data.itemName, dateTime: dateTime,
      //       imageUrl: imageUrl, price: price, dataList: dataList);
      case 'ROYALTY':
        return ItemInfoCard(itemName: data.itemName, dateTime: BaseViewModel().changeTimeZone(data.time), bShowPriceAtEnd: true,
            imageUrl: data.imgUrl, price: data.price.toString(), dataList: _royaltyListContent(data));

      case 'PRICE':
        return OrderInfoCard(
            orderNumber: data.orderNo, dateTime: BaseViewModel().changeTimeZone(data.createdAt, isShowGmt: true),
            dataList: _priceListContent(data), status: data.status,
            imageUrl: data.imgUrl, itemName: data.itemName, price: data.price.toString());

      case 'ACTIVITY':
        return AWDInfoCard(type: data.type, datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _activityListContent(data));
      case 'DEPOSIT':
        return AWDInfoCard(type: data.type, datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _depositListContent(data), status: data.status);
      case 'WITHDRAW':
        return AWDInfoCard(type: data.type, datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _withdrawListContent(data), status: data.status);

      case 'BUY':
        return BuyerSellerInfoCard(
            data: data,
            dataList: _buyListContent(data),
            moreInfoDataList: _buyListContentMore(data));
      case 'SELL':
        return BuyerSellerInfoCard(
            data: data,
            bShowShare: true,
            dataList: _sellListContent(data),
            moreInfoDataList: _sellListContentMore(data));
      case 'DEPOSIT_NFT':
        return ItemInfoCard(itemName: data.itemName, dateTime: BaseViewModel().changeTimeZone(data.createdAt),
            imageUrl: data.imgUrl, price: '', dataList: _depositAndTransferNFTContent(data));

      case 'TRANSFER_NFT':
        return ItemInfoCard(itemName: data.itemName, dateTime: BaseViewModel().changeTimeZone(data.createdAt),
            imageUrl: data.imgUrl, price: '', dataList: _depositAndTransferNFTContent(data));
    }
  }

  ///TODO: 以下為各卡牌所需的 欄位 & 資料
  // 單一預約 // 隱藏不做
  // _itemListContent(OrderMessageListResponseData resData) {
  //   List<CardShowingData> dataList = [];
  //   CardShowingData data = CardShowingData();
  //   data.title = tr('theAmountGoods');
  //   data.content = resData.price.toString();
  //   data.bIcon = true;
  //   dataList.add(data);
  //
  //   data = CardShowingData();
  //   data.title = tr('orderNo');
  //   data.content = resData.orderNo;
  //   dataList.add(data);
  //
  //   return dataList;
  // }

  // 手續費 // 隱藏不做
  // _feeListContent(OrderMessageListResponseData resData) {
  //   List<CardShowingData> dataList = [];
  //   CardShowingData data = CardShowingData();
  //   data.title = tr('orderNo');
  //   data.content = resData.orderNo;
  //   dataList.add(data);
  //
  //   data = CardShowingData();
  //   data.title = tr('type');
  //   data.content = resData.type;
  //   dataList.add(data);
  //
  //   data = CardShowingData();
  //   data.title = tr('serviceFee');
  //   data.content = resData.amount.toString();
  //   dataList.add(data);
  //
  //   return dataList;
  // }

  // 充值NFT / 轉出NFT
  _depositAndTransferNFTContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('orderNo');
    data.content = resData.orderNo;
    dataList.add(data);

    return dataList;
  }

  // 版費
  _royaltyListContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('orderNo');
    data.content = resData.orderNo;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('buyer');
    data.content = resData.buyer;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('seller');
    data.content = resData.seller;
    dataList.add(data);

    return dataList;
  }

  // 副本預約
  _priceListContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('reservationAmount');
    data.content = resData.startPrice.toString() + ' ~ ' + resData.endPrice.toString();
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('reservationFee');
    data.content = resData.deposit.toString();
    data.bIcon = true;
    dataList.add(data);

    return dataList;
  }

  // 活動獎勵
  _activityListContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('amount');
    data.content = resData.amount>0? '+' + resData.amount.toString() : resData.amount.toString();
    dataList.add(data);

    return dataList;
  }

  // 充值
  _depositListContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('orderNo');
    data.content = resData.orderNo;
    dataList.add(data);

    if (resData.type == 'DEPOSIT_INTERNAL') {
      data = CardShowingData();
      data.title = tr('from');
      data.content = resData.from;
      dataList.add(data);
    }

    data = CardShowingData();
    data.title = tr('amount');
    data.content = resData.amount.toString();
    dataList.add(data);

    return dataList;
  }

  // 提領
  _withdrawListContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('orderNo');
    data.content = resData.orderNo;
    dataList.add(data);

    if (resData.type == 'WITHDRAW_INTERNAL') {
      data = CardShowingData();
      data.title = tr('to');
      data.content = resData.from;
      dataList.add(data);
    }

    data = CardShowingData();
    data.title = tr('amount');
    data.content = resData.amount.toString();
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('serviceFee');
    data.content = resData.fee.toString();
    dataList.add(data);

    return dataList;
  }

  // 買家
  _buyListContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('orderNo');
    data.content = resData.orderNo;
    dataList.add(data);

    data = CardShowingData();
    data.title = resData.itemName;
    data.content = resData.buyPrice.toString();
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('seeMore');
    data.content = BaseViewModel().changeTimeZone(resData.createdAt);
    dataList.add(data);

    return dataList;
  }

  // 買家 展開更多
  _buyListContentMore(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('type');
    data.content = tr("usdt-type-BUY_ITEM'");
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('seller');
    data.content = resData.seller;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('payMethod');
    data.content = resData.payType;
    dataList.add(data);

    return dataList;
  }

  // 賣家
  _sellListContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('orderNo');
    data.content = resData.orderNo;
    dataList.add(data);

    data = CardShowingData();
    data.title = resData.itemName;
    data.content = resData.buyPrice.toString();
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('income');
    data.content = resData.income.toString();
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('seeMore');
    data.content = BaseViewModel().changeTimeZone(resData.createdAt);
    dataList.add(data);

    return dataList;
  }

  // 賣家 展開更多
  _sellListContentMore(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('type');
    data.content = tr("usdt-type-SELL_ITEM'");
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('buyer');
    data.content = resData.buyer;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('payMethod');
    data.content = resData.payType;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('buyPrice');
    data.content = resData.buyPrice.toString();
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr("usdt-type-SELLING_FEE'");
    data.content = resData.serviceFee.toString();
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('creatorFee');
    data.content = resData.royalFee.toString();
    data.bIcon = true;
    dataList.add(data);

    return dataList;
  }
}