import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/collection/data/collection_financial_management_response_data.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/theme/app_colors.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/list_view/collection/collection_financial_management_item_view.dart';
import '../../widgets/list_view/collection/collection_medal_item_view.dart';
import '../personal/orders/orderinfo/data/order_message_list_response_data.dart';
import 'api/collection_api.dart';

class CollectionFinancialManagementListView extends ConsumerStatefulWidget {
  const CollectionFinancialManagementListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionFinancialManagementListViewState();
}

class _CollectionFinancialManagementListViewState
    extends ConsumerState<CollectionFinancialManagementListView> with BaseListInterface {

  DateTime loadTime = DateTime.now().toUtc();

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView(
        crossAxisCount: 2,
        spaceWidget: SizedBox(width: UIDefine.getPixelWidth(10)),
        placeHolderWidget: _buildPlaceHolderWidget()
    );
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CollectionFinancialManagementItemView(data: CollectionFinancialManagementResponseData(),);
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getPixelWidth(12));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return OrderMessageListResponseData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    loadTime = DateTime.now().toUtc();
    return await CollectionApi(onConnectFail: (msg)=>reloadAPI(page,size)).getMedalResponse(page: page, size: size);
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool needSave(int page) {
    return page == 1;
  }

  @override
  String setKey() {
    return "collectionTypeMedal";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
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
          SizedBox(
              width: UIDefine.getWidth()*0.7,
              child: Text('no_data_placeHolder_text'.tr(),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w400,color: AppColors.hintGrey,),textAlign: TextAlign.center,))
        ],
      ),
    );
  }
}
