import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/collection/data/collection_financial_management_response_data.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/theme/app_colors.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/list_view/finance/financial_management_item_view.dart';
import '../../widgets/list_view/collection/collection_medal_item_view.dart';
import '../collection/deposit/deposit_nft_main_view.dart';
import '../personal/orders/orderinfo/data/order_message_list_response_data.dart';
import '../collection/api/collection_api.dart';

class FinancialManagementListView extends ConsumerStatefulWidget {
  const FinancialManagementListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FinancialManagementListViewState();
}

class _FinancialManagementListViewState
    extends ConsumerState<FinancialManagementListView> with BaseListInterface {

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
    return FinancialManagementItemView(data: data,);
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getPixelWidth(12));
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
  changeDataFromJson(json) {
    // return FinancialManagementResponseData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    loadTime = DateTime.now().toUtc();
    List<FinancialManagementResponseData> dataList = [
      FinancialManagementResponseData(
        minRank: 1,
        maxRank: 6,
        dayCircle: 7,
        minInMoney: 200,
        maxInMoney: 500,
        dayIncome: 2.3,
        note: format(tr("limitParticipationDay"), {
          "day":'35',
          "items": '1'
        }),
        imgUrl: AppImagePath.financeImg1
      ),
      FinancialManagementResponseData(
          minRank: 2,
          maxRank: 6,
          dayCircle: 35,
          minInMoney: 200,
          maxInMoney: 1500,
          dayIncome: 2.8,
          note: format(tr("limitParticipationDay"), {
            "day":'35',
            "items": '1'
          }),
          imgUrl: AppImagePath.financeImg2
      ),
      FinancialManagementResponseData(
          minRank: 2,
          maxRank: 6,
          dayCircle: 70,
          minInMoney: 200,
          maxInMoney: 2000,
          dayIncome: 3.5,
          imgUrl: AppImagePath.financeImg3
      ),
      FinancialManagementResponseData(
          minRank: 2,
          maxRank: 6,
          dayCircle: 120,
          minInMoney: 200,
          maxInMoney: 5000,
          dayIncome: 4.1,
          imgUrl: AppImagePath.financeImg4
      ),
      FinancialManagementResponseData(
          minRank: 2,
          maxRank: 3,
          dayCircle: 120,
          minInMoney: 200,
          maxInMoney: 10000,
          dayIncome: 4.1,
          imgUrl: AppImagePath.financeImg5
      ),
      FinancialManagementResponseData(
          minRank: 4,
          maxRank: 5,
          dayCircle: 180,
          minInMoney: 200,
          maxInMoney: 20000,
          dayIncome: 4.8,
          imgUrl: AppImagePath.financeImg6
      ),
      FinancialManagementResponseData(
          minRank: 5,
          dayCircle: 10,
          minInMoney: 200,
          maxInMoney: 5000,
          dayIncome: 5.3,
          imgUrl: AppImagePath.financeImg7
      ),
      FinancialManagementResponseData(
          minRank: 6,
          dayCircle: 10,
          minInMoney: 200,
          maxInMoney: 1000,
          dayIncome: 5.3,
          imgUrl: AppImagePath.financeImg8
      ),
    ];

    return dataList;
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
    return "finance";
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
