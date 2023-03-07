import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../constant/enum/collection_enum.dart';
import '../../constant/ui_define.dart';
import '../../view_models/collection/collection_main_view_model.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import 'collection_pending_list_view.dart';
import 'collection_reservation_list_view.dart';
import 'collection_selling_list_view.dart';
import 'collection_ticket_list_view.dart';
import 'deposit/deposit_nft_main_view.dart';

class CollectionMainView extends StatefulWidget {
  const CollectionMainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CollectionMainView();
}

class _CollectionMainView extends State<CollectionMainView> {
  CollectionMainViewModel viewModel = CollectionMainViewModel();
  CollectionTag currentExploreType = CollectionTag.Reservation;
  ItemScrollController listController = ItemScrollController();
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];

  // bool _switchHostingValue = false;

  @override
  void initState() {
    super.initState();
    _setPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(
                top: UIDefine.getScreenWidth(0.97),
                bottom: UIDefine.getScreenWidth(0.97)),
            margin: EdgeInsets.only(
                left: UIDefine.getScreenWidth(5),
                right: UIDefine.getScreenWidth(5),
                bottom: UIDefine.getScreenWidth(0.8)),
            child: viewModel.getCollectionTypeButtons(
                controller: listController,
                currentExploreType: currentExploreType,
                changePage: (CollectionTag exploreType) {
                  _changePage(exploreType);
                })),
        // 如要置頂不滑動才放此Class
        // Visibility(
        //   visible: currentExploreType == 'Pending',
        //   child: _getDepositBtn()
        // ),
        // SizedBox(height: UIDefine.getScreenWidth(2)),
        Expanded(
            child: PageView(
          controller: pageController,
          onPageChanged: _onPageChange,
          children: pages,
        ))
      ]),
    );
  }

  void _setPage() {
    pages = List<Widget>.generate(CollectionTag.values.length, (index) {
      switch (CollectionTag.values[index]) {
        case CollectionTag.Reservation:
          return const CollectionReservationListView();
        case CollectionTag.Pending:
          return const CollectionPendingListView();
        case CollectionTag.Selling:
          return const CollectionSellingListView();
        case CollectionTag.Ticket:
          return const CollectionTicketListView();
      }
    });
  }

  void _changePage(CollectionTag exploreType) {
    setState(() {
      currentExploreType = exploreType;
      pageController.jumpToPage(currentExploreType.index);
    });
  }

  void _onPageChange(int value) {
    setState(() {
      currentExploreType = CollectionTag.values[value];
      if (value != 0) {
        listController.scrollTo(
            index: value - 1, duration: const Duration(milliseconds: 300));
      }
    });
  }

  // 如要置頂不滑動才放此Class
  Widget _getDepositBtn() {
    return IconTextButtonWidget(
        height: UIDefine.getScreenWidth(10),
        btnText: tr("depositNFT"),
        iconPath: 'assets/icon/btn/btn_card_01_nor.png',
        onPressed: () {
          viewModel.pushPage(context, DepositNftMainView());
        });
  }
}
