import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import '../../../constant/enum/order_enum.dart';
import '../../../views/personal/orders/orderinfo/data/order_message_list_response_data.dart';
import '../../../widgets/card/awd_info_card.dart';
import '../../../widgets/card/buyer_seller_info_card.dart';
import '../../../widgets/card/data/card_showing_data.dart';
import '../../../widgets/card/item_info_card.dart';
import '../../../widgets/card/order_info_card.dart';
import '../../../widgets/card/treasure_box_card.dart';

class OrderInfoPageViewModel extends BaseViewModel {
  OrderInfoPageViewModel();

  OrderInfoType currentType = OrderInfoType.BUY;
  String startDate = '';
  String endDate = '';
  String _today = '';

  void init(bool bFromWallet) {
    if (bFromWallet) {
      currentType = OrderInfoType.DEPOSIT;
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
    // String timeZoneCode2 = _getTimeZoneCode(GlobalData.userZone);
    // var istanbulTimeZone = tz.getLocation(timeZoneCode2);
    // int year = tz.TZDateTime.now(istanbulTimeZone).year;
    // int month = tz.TZDateTime.now(istanbulTimeZone).month;
    // int day = tz.TZDateTime.now(istanbulTimeZone).day;
    startDate = getCurrentDayWithUtcZone();
    endDate = startDate;
    _today = startDate;
  }

  ///MARK:判斷是否為今日
  bool checkToday() {
    return (startDate.compareTo(_today) == 0 && endDate.compareTo(_today) == 0);
  }

  String _formatMMDD(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  String _getTimeZoneCode(String sGMT) {
    switch (sGMT) {
      case 'GMT-3':
        return 'America/Araguaina';
      case 'GMT-4':
        return 'America/Aruba';
      case 'GMT-5':
        return 'America/Atikokan';
      case 'GMT-6':
        return 'America/Belize';
      case 'GMT+0':
        return 'Africa/Monrovia';
      case 'GMT+1':
        return 'Africa/Ndjamena';
      case 'GMT+2':
        return 'Africa/Tripoli';
      case 'GMT+3':
        return 'Africa/Mogadishu';
      case 'GMT+3:30':
        return 'Asia/Tehran';
      case 'GMT+4':
        return 'Asia/Tbilisi';
      case 'GMT+4:30':
        return 'Asia/Kabul';
      case 'GMT+5':
        return 'Asia/Karachi';
      case 'GMT+5:30':
        return 'Asia/Kolkata';
      case 'GMT+5:45':
        return 'Asia/Kathmandu';
      case 'GMT+6':
        return 'Asia/Kashgar';
      case 'GMT+6:30':
        return 'Asia/Rangoon';
      case 'GMT+7':
        return 'Asia/Krasnoyarsk';
      case 'GMT+8':
        return 'Asia/Kuching';
      case 'GMT+9':
        return 'Asia/Khandyga';
      case 'GMT+10':
        return 'Asia/Vladivostok';
      case 'GMT+11':
        return 'Asia/Srednekolymsk';
      case 'GMT+12':
        return 'Antarctica/McMurdo';
      case 'GMT+13':
        return 'Pacific/Apia';
    }
    return 'America/Toronto';
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

  ///MARK: 給定不同的卡牌樣式＆資料
  Widget createItemView(int index, OrderMessageListResponseData data) {
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
      case OrderInfoType.ROYALTY:
        return ItemInfoCard(
            drewAt: null,
            itemName: data.itemName,
            dateTime: BaseViewModel().changeTimeZone(data.time),
            bShowPriceAtEnd: true,
            imageUrl: data.imgUrl,
            price: data.price.toString(),
            dataList: _royaltyListContent(data));

      case OrderInfoType.PRICE:
        return OrderInfoCard(
            drewAt: null,
            orderNumber: data.orderNo,
            dateTime:
                BaseViewModel().changeTimeZone(data.createdAt, isShowGmt: true),
            dataList: _priceListContent(data),
            status: data.status,
            // 訂單信息的副本預約，不要顯示餘額補足按鈕
            imageUrl: data.imgUrl,
            itemName: data.itemName,
            price: data.price.toString());

      case OrderInfoType.ACTIVITY:
        return AWDInfoCard(
            type: data.type,
            datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _activityListContent(data));
      case OrderInfoType.DEPOSIT:
        return AWDInfoCard(
            type: data.type,
            datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _depositListContent(data),
            status: data.status);
      case OrderInfoType.WITHDRAW:
        return AWDInfoCard(
            type: data.type,
            datetime: BaseViewModel().changeTimeZone(data.time),
            dataList: _withdrawListContent(data),
            status: data.status);

      case OrderInfoType.BUY:
        return BuyerSellerInfoCard(
            data: data,
            dataList: _buyListContent(data),
            moreInfoDataList: _buyListContentMore(data));
      case OrderInfoType.SELL:
        return BuyerSellerInfoCard(
            data: data,
            bShowShare: true,
            dataList: _sellListContent(data),
            moreInfoDataList: _sellListContentMore(data));
      case OrderInfoType.DEPOSIT_NFT:
        return ItemInfoCard(
            drewAt: null,
            itemName: data.itemName,
            dateTime: BaseViewModel().changeTimeZone(data.createdAt),
            imageUrl: data.imgUrl,
            price: '',
            dataList: _depositAndTransferNFTContent(data));

      case OrderInfoType.TRANSFER_NFT:
        return ItemInfoCard(
            drewAt: null,
            itemName: data.itemName,
            dateTime: BaseViewModel().changeTimeZone(data.createdAt),
            imageUrl: data.imgUrl,
            price: '',
            dataList: _depositAndTransferNFTContent(data));
      case OrderInfoType.TREASURE_BOX:
        return TreasureBoxCard(record: data.changeBoxRecord());
    }
  }

  ///MARK: 以下為各卡牌所需的 欄位 & 資料
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
    data.content =
        '${BaseViewModel().numberFormat(resData.startPrice.toString())} '
        '~ ${BaseViewModel().numberFormat(resData.endPrice.toString())}';
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
    data.content =
        resData.amount > 0 ? '+${resData.amount}' : resData.amount.toString();
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
