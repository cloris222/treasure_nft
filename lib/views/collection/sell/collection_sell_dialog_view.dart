import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/ui_define.dart';
import '../../../view_models/collection/collection_sell_view_model.dart';
import '../data/collection_item_status_response_error_data.dart';
import '../data/collection_level_fee_response_data.dart';




/// 收藏 > 未上架Item > 販售
class CollectionSellDialogView extends BaseDialog {
  CollectionSellDialogView(super.context, this.imgUrl, this.name,
  this.itemId, this.growPrice, this.callBack) : super(isDialogCancel: false);

  String imgUrl;
  String name;
  String itemId;
  String growPrice;
  onClickFunction callBack;
  TextEditingController controller = TextEditingController();
  late StateSetter setState;
  ClassSellViewModel viewModel = ClassSellViewModel();
  CollectionLevelFeeResponseData data = CollectionLevelFeeResponseData();
  String dropDownValue = 'USDT';

  @override
  Future<void> initValue() async {
    Future<CollectionLevelFeeResponseData> result = viewModel.getLevelFeeResponse(itemId);
    result.then((value) => {data = value, setState(() {})});
  }

  @override
  Widget initTitle() {
    return const SizedBox();
  }

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    this.setState = setState;
    return SizedBox(
        width: UIDefine.getScreenWidth(97),
        child: Stack(
          children: [
            Positioned(
              right: 0, top: 0,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset('assets/icon/btn/btn_cancel_01_nor.png')
              )
            ),

            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(imgUrl, width: UIDefine.getScreenWidth(42), height: UIDefine.getScreenWidth(42)),
                    SizedBox(height: UIDefine.getScreenWidth(5)),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: UIDefine.getScreenWidth(5)),
                    Text(
                      'List item for sale',
                      style: TextStyle(
                          fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: UIDefine.getScreenWidth(5)),
                    Text(
                      'Price',
                      style: TextStyle(
                          fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _dropDownBar()),
                        SizedBox(width: UIDefine.getScreenWidth(2.77)),
                        Container(
                          width: UIDefine.getScreenWidth(32.5),
                          height: UIDefine.getScreenWidth(12),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.bolderGrey, width: 1.5),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text(
                            growPrice,
                            style: TextStyle(fontSize: UIDefine.fontSize14, color: AppColors.searchBar),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: UIDefine.getScreenWidth(8)),
                    Container(width: double.infinity, height: 1.5, color: AppColors.searchBar),
                    SizedBox(height: UIDefine.getScreenWidth(10)),
                    Text(
                      'Fees',
                      style: TextStyle(
                          fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service Fee',
                          style: TextStyle(color: AppColors.searchBar,
                              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          data.feeRate.toString() + ' %',
                          style: TextStyle(color: AppColors.searchBar,
                              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Creator Fee',
                          style: TextStyle(color: AppColors.searchBar,
                              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          data.royalRate.toString() + ' %',
                          style: TextStyle(color: AppColors.searchBar,
                              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(height: UIDefine.getScreenWidth(10)),

                Container(
                  alignment: Alignment.center,
                  width: UIDefine.getScreenWidth(50.8),
                  decoration: BoxDecoration(
                      color: AppColors.mainThemeButton,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(
                      onPressed: () {
                        _pressComplete();
                      },
                      child: Text(
                        tr('Complete listing'), // 完成上架
                        style: TextStyle(
                            color: AppColors.textWhite, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                      )
                  ),
                )
              ],
            )
          ],
        )
    );
  }

  final List<String> _currencies = [
    "USDT",
    // "BSC", // 現在網頁沒有BSC
  ];

  Widget _dropDownBar() {
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        // 將選擇的暫存在全域
        dropDownValue = newValue!;
      },
      value: _currencies.first,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(2.5), 0,
            UIDefine.getScreenWidth(2.5), 0),
        hintText: 'USDT',
        hintStyle: const TextStyle(height: 1.6, color: AppColors.textBlack),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.bolderGrey, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.bolderGrey, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.bolderGrey, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      items: _currencies.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Image.asset('assets/icon/coins/icon_tether_01.png', width: 14, height: 14),
                SizedBox(width: UIDefine.getScreenWidth(2.5)),
                Text(category,
                    style: const TextStyle(color: AppColors.searchBar)),
              ],
            ));
      }).toList(),
    );
  }


  void _pressComplete() {
    Future<dynamic> result = viewModel.getItemStatusResponse(itemId, 'SELLING');
    result.then((message) => _onItemStatusSuccess(message));

  }

  void _onItemStatusSuccess(dynamic message) {
    if (message == 'SUCCESS') {
      SimpleCustomDialog(
          context,
          isSuccess: true,
          mainText: '付款成功'
      ).show();

      Navigator.pop(context); // 關商品視窗
      callBack();

    } else {
      CollectionItemStatusResponseErrorData data = CollectionItemStatusResponseErrorData();
      data = message;
      CommonCustomDialog(
          context,
          type: DialogImageType.fail,
          title: '上架失敗',
          content: '可上架時間為\n' + data.zone + data.startTime + ' ~ ' + data.endTime,
          rightBtnText: '確定',
          onLeftPress: (){},
          onRightPress: () {
            Navigator.pop(context);
          }
      ).show();
    }

  }


}