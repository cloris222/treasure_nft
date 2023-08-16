import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/ui_define.dart';
import 'api/collection_api.dart';
import 'data/collection_reservation_response_data.dart';
import 'deposit/deposit_nft_main_view.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/list_view/collection/collection_reservation_item_view.dart';

class CollectionReservationListView extends ConsumerStatefulWidget {
  const CollectionReservationListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionReservationListViewState();
}

class _CollectionReservationListViewState
    extends ConsumerState<CollectionReservationListView>
    with BaseListInterface {

  DateTime loadTime = DateTime.now().toUtc();

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView(
        padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
      placeHolderWidget: _buildPlaceHolderWidget()
    );
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CollectionReservationItemView(
      collectionReservationResponseData: data,
    );
  }

  @override
  Widget? buildTopView() {
    return Platform.isAndroid? IconTextButtonWidget(
        height: UIDefine.getScreenWidth(10),
        btnText: tr("depositNFT"),
        iconPath: 'assets/icon/btn/btn_card_01_nor.png',
        onPressed: () {
          BaseViewModel().pushPage(context, const DepositNftMainView());
        }):Container();
  }

  @override
  Future<List> loadData(int page, int size) async {
    loadTime = DateTime.now().toUtc();
    List<CollectionReservationResponseData> itemList = [];
    BaseViewModel viewModel = BaseViewModel();
    ///MARK: 取得使用者時區日期
    String today = viewModel.getCurrentDayWithUtcZone();
    ///MARK: 轉成系統時間
    String startTime = viewModel.getStartTime(today);
    String endTime = viewModel.getEndTime(today);
    itemList.addAll(await CollectionApi(onConnectFail: (msg)=>reloadAPI(page,size)).getReservationResponse(
      page: page,
      size: size,
      type: 'ITEM',
      startTime: startTime,
      endTime: endTime,
    ));
    itemList.addAll(await CollectionApi(onConnectFail: (msg)=>reloadAPI(page,size)).getReservationResponse(
      page: page,
      size: size,
      type: 'PRICE',
      startTime: startTime,
      endTime: endTime,
    ));
    return itemList;
  }

  @override
  bool needSave(int page) {
    return page == 1;
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  String setKey() {
    return "collectionTypeReservation";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return CollectionReservationResponseData.fromJson(json);
  }

  Widget _buildPlaceHolderWidget(){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(UIDefine.getPixelWidth(30)),
          child: Image.asset('assets/icon/img/not_found_illustration.png'),
        ),
        Text('no_data_available'.tr(),style: AppTextStyle.getBaseStyle(fontSize:UIDefine.fontSize16,fontWeight: FontWeight.w700,color: Colors.black),),
        SizedBox(height: UIDefine.getPixelWidth(8),),
        Text(BaseViewModel().changeTimeZone(loadTime.toString(),setSystemZone: 'GMT+0',isShowGmt: true),style: AppTextStyle.getBaseStyle(fontSize:UIDefine.fontSize16,fontWeight: FontWeight.w700,color: Colors.black)),
        SizedBox(height: UIDefine.getPixelWidth(8),),
        Text('no_data_placeHolder_text'.tr(),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w400,color: AppColors.hintGrey),)
      ],
    );
  }
}
