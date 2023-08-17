import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/base_view_model.dart';
import 'api/collection_api.dart';
import 'data/collection_ticket_response_data.dart';
import 'deposit/deposit_nft_main_view.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/list_view/collection/collection_ticket_item_view.dart';

class CollectionTicketListView extends ConsumerStatefulWidget {
  const CollectionTicketListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionTicketListViewState();
}

class _CollectionTicketListViewState
    extends ConsumerState<CollectionTicketListView> with BaseListInterface {
  DateTime loadTime = DateTime.now().toUtc();

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildListView(placeHolderWidget: _buildPlaceHolderWidget());
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CollectionTicketItemView(data: data, index: index);
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
    return await CollectionApi(onConnectFail: (msg)=>reloadAPI(page,size))
        .getTicketResponse(page: page, size: size, type: 'TICKET');
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
    return "collectionTypeTicket";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return CollectionTicketResponseData.fromJson(json);
  }

  Widget _buildPlaceHolderWidget(){
    return Container(
      width: UIDefine.getWidth()*0.7,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(UIDefine.getPixelWidth(30)),
            child: Image.asset('assets/icon/img/not_found_illustration.png'),
          ),
          Text('no_data_available'.tr(),style: AppTextStyle.getBaseStyle(fontSize:UIDefine.fontSize16,fontWeight: FontWeight.w700,color: Colors.black),),
          SizedBox(height: UIDefine.getPixelWidth(8),),
          Text(BaseViewModel().changeTimeZone(loadTime.toString(),setSystemZone: 'GMT+0',isShowGmt: true),style: AppTextStyle.getBaseStyle(fontSize:UIDefine.fontSize14,fontWeight: FontWeight.w700,color: Colors.black)),
          SizedBox(height: UIDefine.getPixelWidth(8),),
          Text('no_data_placeHolder_text'.tr(),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w400,color: AppColors.hintGrey,),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
