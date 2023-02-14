import 'package:easy_localization/easy_localization.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  // num walletBalance = 0;

  void init(bool bFromWallet) {
    if (bFromWallet) {
      currentType = 'DEPOSIT';
    }

    /// 取得日期 by 帳號所屬國家名: 會自動換成該國慣用用法 ex: 台灣會有年月日單位且分開取：2022年 12月 2日
    // String timeZoneCode = _getTimeZoneCode(GlobalData.userInfo.country);
    // DateTime now = DateTime.now();
    // var formatterYear = DateFormat.y(timeZoneCode);
    // var formatterMonth = DateFormat.M(timeZoneCode);
    // var formatterDay = DateFormat.d(timeZoneCode);
    //
    // String year = formatterYear.format(now);
    // String month = formatterMonth.format(now);
    // String day = formatterDay.format(now);
    //
    // startDate = year + '-' + month + '-' + day;
    // endDate = startDate;

    /// 取得日期 by 帳號所屬國家時區(洲名/都市) ex：年月日純數字但需分開取 2022 12 2
    // tz.initializeTimeZones();
    // String timeZoneCode2 = _getTimeZoneCode(GlobalData.userInfo.country);
    // var istanbulTimeZone = tz.getLocation(timeZoneCode2);
    // int year = tz.TZDateTime.now(istanbulTimeZone).year;
    // int month = tz.TZDateTime.now(istanbulTimeZone).month;
    // int day = tz.TZDateTime.now(istanbulTimeZone).day;
    var now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    startDate = changeTimeZone(now,
        setSystemZone: GlobalData.userInfo.zone, strFormat: 'yyyy-MM-dd');
    // startDate = year.toString() + '-' + _formatMMDD(month) + '-' + _formatMMDD(day);
    endDate = startDate;
  }

  String _formatMMDD(int value) {
    if (value < 10) {
      return '0' + value.toString();
    }
    return value.toString();
  }

  String _getTimeZoneCode(String countryName) {
    switch (countryName) {
      case 'Canada':
        return 'America/Toronto';
      case 'SaudiArabia':
        return 'Africa/Nairobi';
      case 'Jordan':
        return 'Africa/Nairobi';
      case 'Spain':
        return 'Europe/Madrid';
      case 'Brazil':
        return 'America/Sao_Paulo';
      case 'Singapore':
        return 'Asia/Singapore';
      case 'America':
        return 'America/Toronto';
      case 'Kuwait':
        return 'Asia/Riyadh';
      case 'Iran':
        return 'Asia/Tehran';
      case 'Taiwan':
        return 'Asia/Taipei';
      case 'Philippines':
        return 'Asia/Taipei';
      case 'Turkey':
        return 'Europe/Istanbul';
      case 'UnitedKingdom':
        return 'Europe/London';
      case 'Korea':
        return 'Asia/Tokyo';
      case 'Thailand':
        return 'Asia/Bangkok';
      case 'Laos':
        return 'Asia/Bangkok';
      case 'Indonesia':
        return 'Asia/Bangkok';
      case 'Malaysia':
        return 'Asia/Singapore';
      case 'TimorTimur':
        return 'Asia/Makassar';
      case 'Japan':
        return 'Asia/Tokyo';
      case 'PapuaNewGuinea':
        return 'Pacific/Port_Moresby';
    }
    return '';
  }

  /// 這個會自動換成該國慣用用法 ex: 台灣會有年月日單位, 阿拉伯會是阿拉伯語非數字
  // String _getTimeZoneCode(String countryName) {
  //   switch(countryName) {
  //     case 'Canada':
  //       return 'en_CA';
  //     case 'SaudiArabia':
  //       return 'ar_SA';
  //     case 'Jordan':
  //       return 'ar_JO';
  //     case 'Spain':
  //       return 'es_ES';
  //     case 'Brazil':
  //       return 'pt_BR';
  //     case 'Singapore':
  //       return 'en_SG';
  //     case 'America':
  //       return 'en_US';
  //     case 'Kuwait':
  //       return 'ar_KW';
  //     case 'Iran':
  //       return 'fa_IR';
  //     case 'Taiwan':
  //       return 'zh_TW';
  //     case 'Philippines':
  //       return 'en_PH';
  //     case 'Turkey':
  //       return 'tr_TR';
  //     case 'UnitedKingdom':
  //       return 'en_GB';
  //     case 'Korea':
  //       return 'ko_KR';
  //     case 'Thailand':
  //       return 'th_TH';
  //     case 'Laos':
  //       return 'lo_LA';
  //     case 'Indonesia':
  //       return 'in_ID';
  //     case 'Malaysia':
  //       return 'ms_MY';
  //     case 'TimorTimur':
  //       return 'pt_TL';
  //     case 'Japan':
  //       return 'ja_JP';
  //     case 'PapuaNewGuinea':
  //       return 'en_PG';
  //   }
  //   return '';
  // }

  void requestAPI(int page, int size,
      {ResponseErrorFunction? onConnectFail}) async {
    if (currentType.isNotEmpty) {
      await OrderAPI(onConnectFail: onConnectFail)
          .getOrderMessageListResponse(
              page: page,
              size: size,
              type: currentType,
              startTime: startDate,
              endTime: endDate)
          .then((value) => {_setState(value)});

      // await CollectionApi(onConnectFail: onConnectFail) // 這裡的副本預約 不顯示餘額補足按鈕
      //     .getWalletBalanceResponse()
      //     .then((value) => walletBalance = value);

    }
  }

  void requestAPIForUpdate(int page, int size,
      {ResponseErrorFunction? onConnectFail}) async {
    if (currentType.isNotEmpty) {
      await OrderAPI(onConnectFail: onConnectFail)
          .getOrderMessageListResponse(
              page: page,
              size: size,
              type: currentType,
              startTime: startDate,
              endTime: endDate)
          .then((value) => {_update(value)});
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
    switch (currentType) {
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
        return ItemInfoCard(
            itemName: data.itemName,
            dateTime: BaseViewModel().changeTimeZone(data.time),
            bShowPriceAtEnd: true,
            imageUrl: data.imgUrl,
            price: data.price.toString(),
            dataList: _royaltyListContent(data));

      case 'PRICE':
        return OrderInfoCard(
            orderNumber: data.orderNo,
            dateTime:
                BaseViewModel().changeTimeZone(data.createdAt, isShowGmt: true),
            dataList: _priceListContent(data),
            status: data.status,
            // 訂單信息的副本預約，不要顯示餘額補足按鈕
            imageUrl: data.imgUrl,
            itemName: data.itemName,
            price: data.price.toString());

      case 'ACTIVITY':
        return AWDInfoCard(
            type: data.type,
            datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _activityListContent(data));
      case 'DEPOSIT':
        return AWDInfoCard(
            type: data.type,
            datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _depositListContent(data),
            status: data.status);
      case 'WITHDRAW':
        return AWDInfoCard(
            type: data.type,
            datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _withdrawListContent(data),
            status: data.status);

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
        return ItemInfoCard(
            itemName: data.itemName,
            dateTime: BaseViewModel().changeTimeZone(data.createdAt),
            imageUrl: data.imgUrl,
            price: '',
            dataList: _depositAndTransferNFTContent(data));

      case 'TRANSFER_NFT':
        return ItemInfoCard(
            itemName: data.itemName,
            dateTime: BaseViewModel().changeTimeZone(data.createdAt),
            imageUrl: data.imgUrl,
            price: '',
            dataList: _depositAndTransferNFTContent(data));
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
    data.content = BaseViewModel().numberFormat(resData.startPrice.toString()) +
        ' ~ ' +
        BaseViewModel().numberFormat(resData.endPrice.toString());
    data.bIcon = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('reservationFee');
    data.content = resData.deposit.toString();
    data.bIcon = true;
    data.bPrice = true;
    dataList.add(data);

    return dataList;
  }

  // 活動獎勵
  _activityListContent(OrderMessageListResponseData resData) {
    List<CardShowingData> dataList = [];
    CardShowingData data = CardShowingData();
    data.title = tr('amount');
    data.content = resData.amount > 0
        ? '+' + resData.amount.toString()
        : resData.amount.toString();
    data.bPrice = true;
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
    data.bPrice = true;
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
    data.bPrice = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('serviceFee');
    data.content = resData.fee.toString();
    data.bPrice = true;
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
    data.bPrice = true;
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
    data.bPrice = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('income');
    data.content = resData.income.toString();
    data.bIcon = true;
    data.bPrice = true;
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
    data.bPrice = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr("usdt-type-SELLING_FEE'");
    data.content = resData.serviceFee.toString();
    data.bIcon = true;
    data.bPrice = true;
    dataList.add(data);

    data = CardShowingData();
    data.title = tr('creatorFee');
    data.content = resData.royalFee.toString();
    data.bIcon = true;
    data.bPrice = true;
    dataList.add(data);

    return dataList;
  }
}
