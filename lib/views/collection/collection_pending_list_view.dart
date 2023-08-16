import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/widgets/list_view/base_list_interface.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/base_view_model.dart';
import '../../view_models/collection/collection_main_view_model.dart';
import 'api/collection_api.dart';
import 'data/collection_nft_item_response_data.dart';
import 'deposit/deposit_nft_main_view.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/list_view/collection/collection_blind_box_item_view.dart';
import '../../widgets/list_view/collection/collection_sell_unsell_item_view.dart';

class CollectionPendingListView extends ConsumerStatefulWidget {
  const CollectionPendingListView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionPendingListViewState();
}

class _CollectionPendingListViewState
    extends ConsumerState<CollectionPendingListView> with BaseListInterface {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView(
        crossAxisCount: 2,
        spaceWidget: SizedBox(width: UIDefine.getScreenWidth(2.7)),
      placeHolderWidget: _buildPlaceHolderWidget()
    );
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getScreenWidth(4));
  }

  @override
  Widget buildItemBuilder(int index, data) {
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
            CollectionMainViewModel()
                .getOpenBoxResponse(action: 'openBox', itemId: data.itemId);
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
            CollectionMainViewModel()
                .getOpenBoxResponse(action: 'unlock', itemId: data.itemId);
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

  void _updateItem(int index) {
    // 解鎖
    currentItems[index].status = 'PENDING';
    setSharedPreferencesValue(maxSize: maxLoad());

    loadingFinish();
  }

  void _removeItem(int index) {
    // 上架,轉出
    currentItems.removeAt(index);
    setSharedPreferencesValue(maxSize: maxLoad());
    loadingFinish();
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
    return await CollectionApi(onConnectFail: (msg)=>reloadAPI(page,size))
        .getNFTItemResponse(page: page, size: size, status: 'PENDING');
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
    return "collectionTypePending";
  }

  @override
  bool setUserTemporaryValue() {
    return true;
  }

  @override
  changeDataFromJson(json) {
    return CollectionNftItemResponseData.fromJson(json);
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
        Text('no_data_placeHolder_text'.tr(),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w400,color: AppColors.hintGrey),)
      ],
    );
  }
}
