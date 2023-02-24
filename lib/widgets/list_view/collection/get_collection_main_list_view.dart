import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/view_models/collection/collection_main_view_model.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import '../../../constant/enum/collection_enum.dart';
import '../../../constant/ui_define.dart';
import '../../../views/collection/data/collection_nft_item_response_data.dart';
import '../../../views/collection/data/collection_reservation_response_data.dart';
import '../../../views/collection/data/collection_ticket_response_data.dart';
import '../../../views/collection/deposit/deposit_nft_main_view.dart';
import '../../button/icon_text_button_widget.dart';
import 'collection_blind_box_item_view.dart';
import 'collection_sell_unsell_item_view.dart';
import 'collection_reservation_item_view.dart';
import 'collection_ticket_item_view.dart';

class GetCollectionMainListview extends StatefulWidget {
  const GetCollectionMainListview({
    super.key,
    required this.reserveList,
    required this.itemsList,
    required this.ticketList,
    required this.currentType,
  });

  final List<CollectionReservationResponseData> reserveList;
  final List<CollectionNftItemResponseData> itemsList;
  final List<CollectionTicketResponseData> ticketList;
  final CollectionTag currentType;

  @override
  State<StatefulWidget> createState() => _GetCollectionMainListview();
}

class _GetCollectionMainListview extends State<GetCollectionMainListview> {
  CollectionTag get currentType {
    return widget.currentType;
  }

  List<CollectionReservationResponseData> get reserveList {
    return widget.reserveList;
  }

  List<CollectionNftItemResponseData> get itemsList {
    return widget.itemsList;
  }

  List<CollectionTicketResponseData> get ticketList {
    return widget.ticketList;
  }

  CollectionMainViewModel viewModel = CollectionMainViewModel();
  int page = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (isTop) {
              GlobalData.printLog('At the top');
            } else {
              GlobalData.printLog('At the bottom');
              updateView();
            }
          }
          return true;
        },
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
          shrinkWrap: true,
          itemCount: _getItemCount(),
          itemBuilder: (context, index) {
            return _createItemBuilder(index);
          },
        ));
  }

  Widget _createItemBuilder(int index) {
    if (index == 0) {
      return _getDepositAndSwitchBtn(); // 充值按鈕
    }
    switch (currentType) {
      case CollectionTag.Reservation: // 今日預約
        return _getReservationListViewItem(reserveList[index - 1], index - 1);

      case CollectionTag.Pending: // 未上架
        return _makeTwoColumnsOfItem(false, index - 1);
      case CollectionTag.Selling: // 上架中
        return _makeTwoColumnsOfItem(true, index - 1);
      case CollectionTag.Ticket: // 我的票券
        return _getTicketListViewItem(ticketList[index - 1], index - 1);
    }
  }

  Widget _makeTwoColumnsOfItem(bool isSelling, int index) {
    if (index % 2 == 0 && index == itemsList.length - 1) {
      return Padding(
          padding: EdgeInsets.fromLTRB(
              UIDefine.getScreenWidth(4), 0, 0, UIDefine.getScreenWidth(4)),
          child: Wrap(
            children: [
              isSelling
                  ? _getSellingListViewItem(itemsList[index], index)
                  : _getPendingListViewItem(itemsList[index], index),
            ],
          ));
    }
    if (index % 2 != 0) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4), 0,
          UIDefine.getScreenWidth(4), UIDefine.getScreenWidth(4)),
      child: Wrap(
        children: [
          isSelling
              ? _getSellingListViewItem(itemsList[index], index)
              : _getPendingListViewItem(itemsList[index], index),
          SizedBox(width: UIDefine.getScreenWidth(2.7)),
          isSelling
              ? _getSellingListViewItem(itemsList[index + 1], index + 1)
              : _getPendingListViewItem(itemsList[index + 1], index + 1)
        ],
      ),
    );
  }

  Widget _createSeparatorBuilder(BuildContext context, int index) {
    return SizedBox(height: UIDefine.getScreenWidth(4.16));
  }

  int _getItemCount() {
    // +1 => 要有按鈕充值按鈕
    if (currentType == CollectionTag.Reservation) {
      return reserveList.length + 1;
    } else if (currentType == CollectionTag.Ticket) {
      return ticketList.length + 1;
    }

    return itemsList.length + 1;
  }

  Widget _getDepositAndSwitchBtn() {
    return IconTextButtonWidget(
        height: UIDefine.getScreenWidth(10),
        btnText: tr("depositNFT"),
        iconPath: 'assets/icon/btn/btn_card_01_nor.png',
        onPressed: () {
          viewModel.pushPage(context, DepositNftMainView());
        });
  }

  Widget _getReservationListViewItem(
      CollectionReservationResponseData data, int index) {
    return CollectionReservationItemView(
      collectionReservationResponseData: data,
    );
  }

  Widget _getSellingListViewItem(
      CollectionNftItemResponseData data, int index) {
    return CollectionSellUnSellItemView(
        collectionNftItemResponseData: data,
        index: index,
        type: 'Selling',
        callBack: (index) => _removeItem(index));
  }

  Widget _getPendingListViewItem(
      CollectionNftItemResponseData data, int index) {
    // data.status = 'GIVE'; // test 已開未解鎖 測試用
    // data.boxOpen = 'TRUE'; // test 已開未解鎖 測試用

    // data.boxOpen = 'FALSE'; // test 盲盒 測試用

    if (data.boxOpen == 'FALSE') {
      // 盲盒未開
      return CollectionBlindBoxItemView(
          data: data,
          index: index,
          openBlind: () {
            // 開盲盒
            viewModel.getOpenBoxResponse(
                action: 'openBox', itemId: data.itemId);
          },
          unlock: (int value) {});
    } else if (data.status == 'GIVE' && data.boxOpen == 'TRUE') {
      // 盲盒已開但未解鎖
      return CollectionBlindBoxItemView(
          data: data,
          index: index,
          openBlind: () {},
          unlock: (index) {
            // 解鎖
            viewModel.getOpenBoxResponse(action: 'unlock', itemId: data.itemId);
            _updateItem(index);
          });
    } else {
      return CollectionSellUnSellItemView(
          // 一般圖
          collectionNftItemResponseData: data,
          index: index,
          type: 'Pending',
          callBack: (index) => _removeItem(index));
    }
  }

  Widget _getTicketListViewItem(CollectionTicketResponseData data, int index) {
    return CollectionTicketItemView(data: data, index: index);
  }

  void _removeItem(int index) {
    // 上架,轉出
    itemsList.removeAt(index);
    setState(() {});
  }

  void _updateItem(int index) {
    // 解鎖
    itemsList[index].status = 'PENDING';
    setState(() {});
  }

  updateView() async {
    page += 1;
    switch (currentType) {
      case CollectionTag.Reservation:
        {
          var newListItem =
              await viewModel.getReservationResponse('ITEM', page, 10);
          var newListPrice =
              await viewModel.getReservationResponse('PRICE', page, 10);
          reserveList.addAll(newListItem);
          reserveList.addAll(newListPrice);
        }
        break;
      case CollectionTag.Pending:
        {
          var newList = await viewModel.getNFTItemResponse('PENDING', page, 10);
          itemsList.addAll(newList);
        }
        break;
      case CollectionTag.Selling:
        {
          var newList = await viewModel.getNFTItemResponse('SELLING', page, 10);
          itemsList.addAll(newList);
        }
        break;
      case CollectionTag.Ticket:
        {
          var newList = await viewModel.getTicketResponse('TICKET', page, 10);
          ticketList.addAll(newList);
        }
        break;
    }
    setState(() {});
  }
}
